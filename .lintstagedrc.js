export default {
  '*.js': (filenames) =>
    filenames.map((filename) => `prettier --write '${filename}'`),
  '*.{code-workspace,md,json,json5,yaml}': (filenames) =>
    filenames.map((filename) => `prettier --write '${filename}'`),
  '*.tf': () => [`tofu fmt`, `tofu validate`],
};
