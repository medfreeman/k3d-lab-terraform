export default {
  $schema: 'http://json.schemastore.org/prettierrc',

  printWidth: 80,
  singleQuote: true,
  semi: true,
  trailingComma: 'all',
  endOfLine: 'lf',
  overrides: [
    {
      files: '*.{code-workspace}',
      options: {
        parser: 'json',
      },
    },
    {
      files: '*.yaml',
      options: {
        singleQuote: false,
      },
    },
  ],
};
