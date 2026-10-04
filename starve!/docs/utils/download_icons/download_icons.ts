import { existsSync, mkdirSync } from "node:fs"
import { join, resolve } from "node:path"

const DATA_DIR = import.meta.dir
const PUBLIC_DIR = resolve(DATA_DIR, "../../public/icons")
const DISHES_DIR = join(PUBLIC_DIR, "dishes")
const EXTRA_DIR = join(PUBLIC_DIR, "extra")

const TARGET_SETS: Array<{ file: string; targetDir: string }> = [
  { file: "dishes_icons.json", targetDir: DISHES_DIR },
  { file: "warly_dishes_icons.json", targetDir: DISHES_DIR },
  { file: "extra_assets.json", targetDir: EXTRA_DIR },
]

const DEFAULT_WIKI_ORIGIN = "https://dontstarve.wiki.gg"
const WIKI_ORIGIN = process.env.WIKI_ORIGIN ?? DEFAULT_WIKI_ORIGIN

const USER_AGENT =
  "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"

const MAX_PARALLEL = 4

type DishIcons = Record<string, string | null>

interface DownloadJob {
  name: string
  link: string
  targetDir: string
}

async function loadIcons(file: string): Promise<DishIcons> {
  return (await Bun.file(join(DATA_DIR, file)).json()) as DishIcons
}

async function download(name: string, link: string, targetDir: string): Promise<void> {
  const ext = link.split('.').pop() || 'png'
  const target = join(targetDir, `${name}.${ext}`)
  if (existsSync(target)) {
    return
  }

  const response = await fetch(new URL(link, WIKI_ORIGIN), {
    headers: { "User-Agent": USER_AGENT },
  })
  if (!response.ok) {
    throw new Error(`HTTP ${response.status}`)
  }

  await Bun.write(target, await response.arrayBuffer())
}

function collectJobs(sets: Array<{ icons: DishIcons; targetDir: string }>): DownloadJob[] {
  const jobs: DownloadJob[] = []

  for (const { icons, targetDir } of sets) {
    for (const [name, link] of Object.entries(icons)) {
      if (link === null) {
        continue
      }
      jobs.push({ name, link, targetDir })
    }
  }

  return jobs
}

async function runPool(jobs: DownloadJob[]): Promise<string[]> {
  const failures: string[] = []
  let cursor = 0

  async function worker(): Promise<void> {
    while (cursor < jobs.length) {
      const { name, link, targetDir } = jobs[cursor++]
      try {
        await download(name, link, targetDir)
      } catch (error) {
        failures.push(`${name}: ${(error as Error).message}`)
      }
    }
  }

  const workers = Array.from({ length: MAX_PARALLEL }, () => worker())
  await Promise.all(workers)

  return failures
}

async function main(): Promise<void> {
  mkdirSync(DISHES_DIR, { recursive: true })
  mkdirSync(EXTRA_DIR, { recursive: true })

  const loadedSets = await Promise.all(
    TARGET_SETS.map(async ({ file, targetDir }) => ({
      icons: await loadIcons(file),
      targetDir,
    }))
  )
  const jobs = collectJobs(loadedSets)
  const failures = await runPool(jobs)

  console.log(`Icons: ${jobs.length - failures.length}/${jobs.length} downloaded`)

  for (const failure of failures) {
    console.error(failure)
  }

  if (failures.length > 0) {
    process.exitCode = 1
  }
}

await main()
