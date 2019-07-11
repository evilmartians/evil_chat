const { environment } = require("@rails/webpacker");

["css", "moduleCss"].forEach(loaderName => {
  const loader = environment.loaders.get(loaderName);

  loader.test = /\.(p?css)$/i;

  environment.loaders.insert(loaderName, loader);
});

module.exports = environment;
