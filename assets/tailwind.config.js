module.exports = {
  mode: 'jit',
  purge: [
    '/app/assets/**/*.js',
    '/app/lib/hello_web/**/*.eex',
    '/app/lib/hello_web/**/*.leex',
    '/app/lib/hello_web/**/*.ex'
  ],
};
