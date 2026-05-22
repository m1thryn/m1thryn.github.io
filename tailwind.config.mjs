import defaultTheme from "tailwindcss/defaultTheme";

/** @type {import('tailwindcss').Config} */
export default {
  darkMode: "class",
  content: ["./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}"],
  theme: {
    extend: {
      fontFamily: {
        sans: ['"Geist Sans"', ...defaultTheme.fontFamily.sans],
        // This value is overridden for code blocks by the expressiveCode plugin - see
        // astro.config.mjs
        mono: ['"Ubuntu Mono"', ...defaultTheme.fontFamily.mono],
      },
      colors: {
        tn: {
          bg: "#1a1b2e",
          "bg-dark": "#16161e",
          surface: "#292e42",
          border: "#3b4261",
          text: "#c0caf5",
          "text-secondary": "#a9b1d6",
          muted: "#565f89",
          blue: "#7aa2f7",
          purple: "#bb9af7",
          teal: "#73daca",
          green: "#9ece6a",
          orange: "#ff9e64",
          red: "#f7768e",
          yellow: "#e0af68",
          // Light (Day)
          "day-bg": "#e4e6f2",
          "day-card": "#e8eafc",
          "day-surface": "#d8dae8",
          "day-border": "#c4c8da",
          "day-text": "#1e2a4a",
          "day-muted": "#4a5280",
          "day-blue": "#3d5cbf",
          "day-purple": "#9854f1",
          "day-teal": "#005f7a",
        },
      },
    },
  },
  plugins: [require("@tailwindcss/typography")],
};
