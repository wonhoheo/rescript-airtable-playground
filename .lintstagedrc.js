const path = require("path");

const buildEslintCommand = filenames => {
  const files = filenames.map(f => path.relative(process.cwd(), f)).join(" ");
  return `eslint ${files}`;
};

const buildPrettierCommand = filenames => {
  const files = filenames.map(f => path.relative(process.cwd(), f)).join(" ");
  return `prettier --check ${files}`;
};

const buildRescriptFormatCommand = filenames => {
  const files = filenames.map(f => path.relative(process.cwd(), f)).join(" ");
  return `rescript format ${files}`;
};

module.exports = {
  "*.{js,jsx,!mjs}": [buildEslintCommand, buildPrettierCommand],
  "*.{res,resi}": [buildRescriptFormatCommand],
};
