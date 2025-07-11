const breakpoints = [
  { prefix: "s\\:", mediaQuery: "(max-width: 600px)" },
  { prefix: "m\\:", mediaQuery: "(min-width: 601px)" },
  { prefix: "l\\:", mediaQuery: "(min-width: 993px)" },
  // { prefix: "xl\\:", mediaQuery: "(min-width: 1264px)" },
]

const classes = [".medium-width", ".large-width", ".small-width", ".no-margin", ".auto-margin"]
export default {
  plugins: {
    autoprefixer: {},
    "@dialpad/postcss-responsive-variations": { breakpoints, classes },
  },
}
