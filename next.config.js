const bsconfig = require("./bsconfig.json");

const transpileModules = ["rescript"].concat(bsconfig["bs-dependencies"]).concat([]);

const nextConfig = {
  pageExtensions: ["jsx", "js"],
  reactStrictMode: true,
  transpilePackages: transpileModules,
};

if (process.env.NODE_ENV === "production") {
  if (!nextConfig.compiler) {
    nextConfig.compiler = {};
  }

  nextConfig.compiler.removeConsole = {
    exclude: ["error"],
  };
}

module.exports = nextConfig;
