const port = Number(process.env.PORT) || 3005
const distDir = `${import.meta.dir}/dist`

Bun.serve({
  port,
  async fetch(req) {
    const url = new URL(req.url)
    const filePath = `${distDir}${url.pathname}`

    const file = Bun.file(filePath)
    if (await file.exists()) {
      return new Response(file)
    }

    const indexHtml = Bun.file(`${distDir}/index.html`)
    if (await indexHtml.exists()) {
      return new Response(indexHtml)
    }

    return new Response("Not Found", { status: 404 })
  },
})

console.log(`Server listening on port ${port}`)
