const esbuild = require('esbuild')
const copyStaticFiles = require('esbuild-copy-static-files')

const copyDest = '../priv/static'

let minify = false
let sourcemap = true
let watch_fs = true

if (process.env.NODE_ENV === 'production') {
  minify = true
  sourcemap = false
  watch_fs = false
}

const watch = watch_fs && {
  onRebuild(error) {
    if (error) console.error('[watch] build failed', error)
    else console.log('[watch] build finished')
  },
}

esbuild.build({
  entryPoints: ['./js/app.js'],
  outfile: `${copyDest}/js/app.js`,
  bundle: true,
  minify: minify,
  sourcemap: sourcemap,
  watch: watch_fs,
  plugins: [copyStaticFiles({dest: copyDest})]
})
