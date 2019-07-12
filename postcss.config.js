/* eslint global-require: off, import/no-extraneous-dependencies: off */

module.exports = {
  plugins: [
    require("postcss-import"),
    require("postcss-inline-svg"),
    require("postcss-flexbugs-fixes"),
    require("postcss-preset-env")({
      autoprefixer: {
        flexbox: "no-2009"
      },
      stage: 3
    }),
    require("postcss-nested")
  ]
};
