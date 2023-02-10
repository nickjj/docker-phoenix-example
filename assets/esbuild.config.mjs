import * as esbuild from 'esbuild'
import copyStaticFiles from 'esbuild-copy-static-files'

const copyDest = '../priv/static'

let minify = false
let sourcemap = true
let watch = true

if (process.env.NODE_ENV === 'production') {
  minify = true
  sourcemap = false
  watch = false
}

const config = {
  entryPoints: ['./js/app.js'],
  outfile: `${copyDest}/js/app.js`,
  bundle: true,
  minify: minify,
  sourcemap: sourcemap,
  plugins: [copyStaticFiles({dest: copyDest})],
}

if (watch) {
  let context = await esbuild.context({...config, logLevel: 'info'})
  await context.watch()
} else {
  esbuild.build(config)
}
