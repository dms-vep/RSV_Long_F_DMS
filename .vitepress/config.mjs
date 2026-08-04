import { defineConfig } from "vitepress";

// https://vitepress.dev/reference/site-config
export default defineConfig({
  lang: "en-US",
  title: "Pseudovirus deep mutational scanning of the RSV F protein",
  description:
    "Interactive figures and raw data from experimental measurements of how mutations to the F protein of RSV (subtype A Long strain) affect cell entry and antibody neutralization.",
  base: "/RSV_Long_F_DMS/",
  appearance: false,
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: "Home", link: "/" },
      { text: "Appendix", link: "/appendix", target: "_self" },
    ],
    socialLinks: [{ icon: "github", link: "https://github.com/dms-vep/RSV_Long_F_DMS" }],
    footer: {
      message: 'See <a href="https://www.biorxiv.org/content/10.64898/2026.02.12.705519">Simonich et al (2026)</a> for study details.',
    },
  },
  head: [
    [
      "script",
      { async: "", src: "https://www.googletagmanager.com/gtag/js?id=G-DXBLGR7S4L" }
    ],
    [
      "script",
      {},
      `window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag("js", new Date());
      gtag("config", "G-DXBLGR7S4L");`
    ]
  ],
});
