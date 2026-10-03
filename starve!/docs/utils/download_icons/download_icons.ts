import { existsSync, mkdirSync } from "node:fs"
import { join, resolve } from "node:path"

const DATA_DIR = import.meta.dir
const DEFAULT_ICONS_DIR = resolve(DATA_DIR, "../../public/icons/dishes")
const ICONS_DIR = process.env.ICONS_DIR ? resolve(process.env.ICONS_DIR) : DEFAULT_ICONS_DIR

const DATA_FILES = ["dishes_icon_link_map.json", "warly_dishes_icon_link_map.json"]

const DEFAULT_WIKI_ORIGIN = "https://dontstarve.wiki.gg"
const WIKI_ORIGIN = process.env.WIKI_ORIGIN ?? DEFAULT_WIKI_ORIGIN

const USER_AGENT =
  "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"

const MAX_PARALLEL = 4

type DishIcons = Record<string, string | null>

async function loadIcons(file: string): Promise<DishIcons> {
  return (await Bun.file(join(DATA_DIR, file)).json()) as DishIcons
}

async function download(prefab: string, link: string): Promise<void> {
  const target = join(ICONS_DIR, `${prefab}.png`)
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

function collectJobs(iconSets: DishIcons[]): Array<[string, string]> {
  const jobs: Array<[string, string]> = []

  for (const icons of iconSets) {
    for (const [prefab, link] of Object.entries(icons)) {
      if (link === null) {
        continue
      }
      jobs.push([prefab, link])
    }
  }

  return jobs
}

async function runPool(jobs: Array<[string, string]>): Promise<string[]> {
  const failures: string[] = []
  let cursor = 0

  async function worker(): Promise<void> {
    while (cursor < jobs.length) {
      const [prefab, link] = jobs[cursor++]
      try {
        await download(prefab, link)
      } catch (error) {
        failures.push(`${prefab}: ${(error as Error).message}`)
      }
    }
  }

  const workers = Array.from({ length: MAX_PARALLEL }, () => worker())
  await Promise.all(workers)

  return failures
}

async function main(): Promise<void> {
  mkdirSync(ICONS_DIR, { recursive: true })

  const iconSets = await Promise.all(DATA_FILES.map(loadIcons))
  const jobs = collectJobs(iconSets)
  const failures = await runPool(jobs)

  console.log(`Icons: ${jobs.length - failures.length}/${jobs.length} -> ${ICONS_DIR}`)

  for (const failure of failures) {
    console.error(failure)
  }

  if (failures.length > 0) {
    process.exitCode = 1
  }
}

await main()
