const path = require("path");

const buildEslintCommand = filenames => {
  const files = filenames.map(f => path.relative(process.cwd(), f)).join(" --file ");
  return `next lint --file ${files}`;
};

const buildPrettierCommand = filenames => {
  const files = filenames.map(f => path.relative(process.cwd(), f)).join(" ");
  return `prettier --check ${files}`;
};

const buildRescriptFormatCommand = filenames => {
  const files = filenames.map(f => path.relative(process.cwd(), f)).join(" ");
  return `rescript format -stdin ${files}`;
};

module.exports = {
  "*.{js,jsx,ts,tsx,json,!mjs}": [buildEslintCommand, buildPrettierCommand],
  "*.{res,resi}": [buildRescriptFormatCommand],
};
