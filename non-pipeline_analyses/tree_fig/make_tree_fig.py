"""
Generate Baltic tree figures from Nextstrain Auspice JSON files.

For each tree, generates two figures: one colored by Nirsevimab escape
and one by Clesrovimab escape, each labeling the relevant validation strains.
"""

import csv
import sys
from pathlib import Path

import matplotlib.pyplot as plt
from matplotlib.colors import Normalize
from matplotlib import cm

# Add baltic to path
sys.path.insert(0, str(Path(__file__).parent / "baltic" / "baltic"))
import baltic as bt

# Constants
AUSPICE_DIR = Path(__file__).parent / "nextstrain-rsv" / "auspice"
VALIDATION_CSV = Path(__file__).parent / "validation_strain_info_final.csv"
OUTPUT_DIR = Path(__file__).parent / "results"

ANTIBODIES = {
    "Nirsevimab": "Nirsevimab-Fab_total_escape",
    "Clesrovimab": "Clesrovimab-Fab_total_escape",
}


def load_validation_strains(csv_path: Path) -> dict[str, dict]:
    """Load validation strains from CSV, keyed by accession."""
    strains = {}
    with open(csv_path) as f:
        reader = csv.DictReader(f)
        for row in reader:
            strains[row["accession"]] = {
                "subtype": row["subtype"],
                "tree_label": row["tree_label"],
                "strain": row["strain"],
                "mAb": row["mAb"],
            }
    return strains


def get_tree_subtype(tree_path: Path) -> str:
    """Parse filename to get 'A' or 'B' subtype."""
    name = tree_path.name
    if "rsv_a_" in name:
        return "A"
    elif "rsv_b_" in name:
        return "B"
    else:
        raise ValueError(f"Cannot determine subtype from filename: {name}")


def get_strains_for_antibody(
    all_strains: dict, subtype: str, antibody: str
) -> dict:
    """Get strains to label for a specific antibody and subtype."""
    return {
        acc: info
        for acc, info in all_strains.items()
        if info["subtype"] == subtype
        and (info["mAb"] == antibody or "control" in info["mAb"].lower())
    }


def validate_tree_contains_strains(tree, expected_strains: dict) -> dict:
    """Validate tree contains expected strains. Returns accession->leaf mapping."""
    # Build leaf lookup by accession prefix
    leaf_lookup = {}
    for obj in tree.Objects:
        if obj.is_leaf():
            ppx = obj.traits.get("PPX_accession", "")
            if ppx:
                leaf_lookup[ppx] = obj

    # Match expected to actual (prefix match for versioned accessions)
    found = {}
    missing = []
    for accession in expected_strains:
        matched_leaf = None
        for tree_acc, leaf in leaf_lookup.items():
            if tree_acc.startswith(accession):
                matched_leaf = leaf
                break
        if matched_leaf:
            found[accession] = matched_leaf
        else:
            missing.append(accession)

    if missing:
        raise ValueError(f"Missing strains in tree: {missing}")

    return found


def get_escape_color(branch, escape_attr: str, norm, cmap):
    """Get color for branch based on escape value."""
    escape_val = branch.traits.get(escape_attr)
    if escape_val is None:
        return (0.7, 0.7, 0.7)  # gray for missing values
    return cmap(norm(escape_val))


def compute_label_positions(labeled_leaves: dict, y_span: float) -> dict:
    """Compute non-overlapping y-positions for labels.

    Uses iterative relaxation to push overlapping labels apart.
    Returns dict mapping accession to adjusted y-position.
    """
    # Estimate minimum spacing based on font size and figure dimensions
    # Font is 7pt, figure is ~6 inches tall, so need ~2.2% of y_span spacing
    min_spacing = y_span * 0.022

    items = [(acc, leaf.y) for acc, leaf in labeled_leaves.items()]
    if not items:
        return {}

    items.sort(key=lambda x: x[1])
    ys = [item[1] for item in items]

    # Iteratively resolve overlaps by pushing pairs apart
    max_iterations = 100
    for _ in range(max_iterations):
        changed = False
        for i in range(len(ys) - 1):
            gap = ys[i + 1] - ys[i]
            if gap < min_spacing:
                adjustment = (min_spacing - gap) / 2
                ys[i] -= adjustment
                ys[i + 1] += adjustment
                changed = True
        if not changed:
            break

    return {items[i][0]: ys[i] for i in range(len(items))}


def create_tree_figure(
    tree,
    labeled_leaves: dict,
    strain_info: dict,
    escape_attr: str,
    antibody_name: str,
    subtype: str,
    output_path: Path,
):
    """Create Baltic tree figure with escape-colored branches and labeled strains."""
    fig, ax = plt.subplots(figsize=(4.104, 6))

    # Add centered title
    title = f"RSV subtype {subtype}, {antibody_name.lower()} neutralization"
    ax.set_title(title, fontsize=9, pad=1)

    # Compute escape value range for color normalization
    escape_vals = [
        b.traits.get(escape_attr)
        for b in tree.Objects
        if b.traits.get(escape_attr) is not None
    ]
    norm = Normalize(vmin=min(escape_vals), vmax=max(escape_vals))
    cmap_obj = cm.viridis

    # Time axis settings - trim at 2012, end scale at 2026
    x_min = 2012.0
    x_max_data = max(k.absoluteTime for k in tree.Objects)
    x_max_scale = 2026.0  # End time scale here
    x_max_labels = x_max_data + 0.2  # Labels can extend beyond

    # Plot tree with branches colored by escape, using absoluteTime for x-axis
    tree.plotTree(
        ax,
        x_attr=lambda k: k.absoluteTime,
        colour=lambda k: get_escape_color(k, escape_attr, norm, cmap_obj),
        width=0.8,
    )

    # Plot all tips as small circles colored by escape
    tree.plotPoints(
        ax,
        x_attr=lambda k: k.absoluteTime,
        target=lambda k: k.is_leaf(),
        colour=lambda k: get_escape_color(k, escape_attr, norm, cmap_obj),
        size=13.5,
        outline=False,
    )

    # Highlight labeled tips with larger squares
    target_set = set(labeled_leaves.values())
    for leaf in target_set:
        color = get_escape_color(leaf, escape_attr, norm, cmap_obj)
        ax.scatter(
            leaf.absoluteTime,
            leaf.y,
            s=64.8,
            c=[color],
            marker="s",
            edgecolors="black",
            linewidths=0.5,
            zorder=4,
        )

    # Compute non-overlapping label positions
    label_y_positions = compute_label_positions(labeled_leaves, tree.ySpan)

    # Add labels for target strains - aligned on right with dotted lines
    label_x = x_max_labels + 0.05  # Position for aligned labels
    for acc, leaf in labeled_leaves.items():
        label_text = strain_info[acc]["tree_label"]
        label_y = label_y_positions[acc]
        # Draw dotted line from tip to label (may be angled if label was adjusted)
        ax.plot(
            [leaf.absoluteTime, label_x],
            [leaf.y, label_y],
            ":",
            color="gray",
            linewidth=0.5,
            zorder=1,
        )
        # Add label text at adjusted y-position
        ax.text(
            label_x + 0.05,
            label_y,
            label_text,
            fontsize=7,
            verticalalignment="center",
            horizontalalignment="left",
        )

    # Set axis limits - labels can extend beyond the scale bar
    # Add padding to y-axis to prevent tip circles from being clipped
    y_padding = tree.ySpan * 0.02
    ax.set_xlim(x_min, label_x + 1.5)
    ax.set_ylim(-y_padding, tree.ySpan + y_padding)

    # Add time scale bar at bottom (ends at 2026)
    ax.set_xticks([2012, 2014, 2016, 2018, 2020, 2022, 2024, 2026])
    ax.set_xticklabels(["2012", "2014", "2016", "2018", "2020", "2022", "2024", "2026"])
    ax.tick_params(axis="x", direction="out", length=5, labelsize=7, pad=1)
    ax.spines["bottom"].set_visible(True)
    ax.spines["bottom"].set_position(("outward", 2))
    ax.spines["bottom"].set_bounds(x_min, x_max_scale)  # Time scale bar from x_min to 2026
    ax.spines["top"].set_visible(False)
    ax.spines["left"].set_visible(False)
    ax.spines["right"].set_visible(False)
    ax.set_yticks([])
    # Add "date" label below the scale bar
    ax.set_xlabel("date", fontsize=10, labelpad=0)

    # Add horizontal colorbar in lower left, above time scale
    # Left edge aligned ~1% to the right of where earliest date (2012) appears
    cbar_ax = fig.add_axes([0.125, 0.18, 0.24, 0.018])  # [left, bottom, width, height]
    sm = cm.ScalarMappable(cmap=cmap_obj, norm=norm)
    sm.set_array([])
    cbar = fig.colorbar(sm, cax=cbar_ax, orientation="horizontal")
    cbar.ax.tick_params(labelsize=7)  # Same size as year tick labels
    cbar.locator = plt.MaxNLocator(nbins=4)
    cbar.update_ticks()
    cbar.ax.set_title("neutralization escape", fontsize=8, loc="center")

    fig.savefig(output_path, dpi=300, bbox_inches="tight")
    plt.close(fig)


def main():
    OUTPUT_DIR.mkdir(exist_ok=True)

    all_strains = load_validation_strains(VALIDATION_CSV)

    for json_path in sorted(AUSPICE_DIR.glob("*.json")):
        if "tip-frequencies" in json_path.name:
            continue

        print(f"Processing {json_path.name}...")
        subtype = get_tree_subtype(json_path)
        tree, meta = bt.loadJSON(str(json_path), stats=False)

        for antibody, escape_attr in ANTIBODIES.items():
            strains_to_label = get_strains_for_antibody(all_strains, subtype, antibody)
            labeled_leaves = validate_tree_contains_strains(tree, strains_to_label)

            output_name = f"{json_path.stem}_{antibody}.pdf"
            output_path = OUTPUT_DIR / output_name

            create_tree_figure(
                tree,
                labeled_leaves,
                strains_to_label,
                escape_attr,
                antibody,
                subtype,
                output_path,
            )
            print(f"  Saved {output_name}")


if __name__ == "__main__":
    main()
