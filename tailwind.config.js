/** @type {import('tailwindcss').Config} */
const tokens = require("@greenlabs/formula-design-token/dist/tailwind-tokens.json");
module.exports = {
  content: ["./src/**/*.res"],
  theme: {
    // Same font size from the APP?
    fontSize: {
      xs: ["12px", { lineHeight: "14px" }],
      sm: ["14px", { lineHeight: "16px" }],
      base: ["16px", { lineHeight: "20px" }],
      lg: ["18px", { lineHeight: "22px" }],
      xl: ["20px", { lineHeight: "24px", letterSpacing: "-1px" }],
      "2xl": ["24px", { lineHeight: "28px", letterSpacing: "-1px" }],
      "3xl": ["30px", { lineHeight: "32px", letterSpacing: "-1px" }],
    },
    extend: {
      colors: {
        f: tokens.color,
        gray: {
          900: "#121212",
          800: "#262626",
          700: "#4c4c4c",
          600: "#727272",
          500: "#999999",
          400: "#b2b2b2",
          300: "#cccccc",
          250: "#d9d9d9",
          200: "#e5e5e5",
          150: "#ececec",
          100: "#f2f2f2",
          50: "#f7f7f7",
        },
        green: {
          900: "#03564e",
          800: "#056855",
          700: "#09825e",
          600: "#0d9b63",
          500: "#12b564",
          400: "#44d27d",
          300: "#7aea9c",
          250: "#8ef2a6",
          200: "#a8f8b8",
          150: "#c3fbc9",
          100: "#d5fcd9",
          50: "#ebfded",
        },
        yellow: {
          900: "#8c6400",
          800: "#ae8000",
          700: "#d09e00",
          600: "#f3be00",
          500: "#FED925",
          400: "#fee55b",
          300: "#feed7c",
          200: "#fef4a7",
          100: "#fefad3",
          50: "#fefce5",
        },
        red: {
          900: "#7a0836",
          800: "#930d37",
          700: "#b7153a",
          600: "#db1f39",
          500: "#ff2b35",
          400: "#ff6660",
          300: "#ff907f",
          250: "#ffae9b",
          200: "#ffc6b7",
          150: "#ffdace",
          100: "#ffeae1",
          50: "#fff6f2",
        },
        blue: {
          900: "#07155e",
          800: "#0c1f71",
          700: "#132d8d",
          600: "#1c3ea8",
          500: "#2751c4",
          400: "#577edb",
          300: "#7ba0ed",
          250: "#9dbaf8",
          200: "#bad0fb",
          150: "#dce8fd",
          100: "#dce8fd",
          50: "#f2f6fe",
        },
        bluegray: {
          700: "#3f4c65",
        },
        orange: {
          500: "#ff5735",
        },
        primary: "#12b564",
        background: "#ffffff",
        "bg-pressed-L1": "#f7f7f7",
        surface: "#f7f7f7",
        default: "#262626",
        emphasis: "#ff2b35",
        lower: "#2751c4",
        "border-active": "#262626",
        "border-default-L1": "#cccccc",
        "border-default-L2": "#ececec",
        "border-disabled": "#f2f2f2",
        "div-border-L1": "#d9d9d9",
        "div-border-L2": "#e5e5e5",
        "div-border-L3": "#f2f2f2",
        "div-shape-L1": "#f2f2f2",
        "div-shape-L2": "#f7f7f7",
        "enabled-L1": "#262626",
        "enabled-L2": "#727272",
        "enabled-L3": "#999999",
        "enabled-L4": "#b2b2b2",
        "enabled-L5": "#f2f2f2",
        "bg-pressed": "#f7f7f7",
        "disabled-L1": "#b2b2b2",
        "disabled-L2": "#cccccc",
        "disabled-L3": "#f2f2f2",
        "text-L1": "#262626",
        "text-L2": "#727272",
        "text-L3": "#999999",
        notice: "#ff2b35",
        "primary-light": "#ebfded",
        dim: "rgba(0, 0, 0, 0.5)",
      },
      keyframes: {
        slideUp: {
          "0%": { bottom: 0 },
          "100%": { bottom: "50%" },
        },
        sheetUp: {
          "0%": { bottom: "-100%" },
          "100%": { bottom: 0 },
        },
      },
      animation: {
        "slide-up": "slideUp 250ms",
        "sheet-up": "sheetUp 250ms",
      },
    },
  },
};
