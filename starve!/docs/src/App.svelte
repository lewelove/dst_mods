<script lang="ts">
  import { onMount } from 'svelte'

  interface DishStats {
    hunger: number
    sanity: number
    health: number
    rot_time: number
    cook_time: number
    priority: number
  }

  interface DishEntry {
    name: string
    vanilla: DishStats
    modded?: Partial<DishStats>
  }

  type DishesData = Record<string, DishEntry>

  interface DishRow {
    prefab: string
    name: string
    hunger: number
    sanity: number
    health: number
    rot_time: number
    cook_time: number
    priority: number
    moddedFields: Record<string, boolean>
  }

  type SortKey = 'name' | 'hunger' | 'sanity' | 'health' | 'rot_time' | 'cook_time' | 'priority'
  type SortDirection = 'asc' | 'desc'

  let dishes = $state<DishRow[]>([])
  let loading = $state(true)
  let error = $state<string | null>(null)
  let sortKey = $state<SortKey>('name')
  let sortDirection = $state<SortDirection>('asc')

  onMount(async () => {
    try {
      const response = await fetch('/dishes_data.json')
      if (!response.ok) {
        throw new Error(`Failed to load dishes: ${response.statusText}`)
      }
      const data: DishesData = await response.json()
      dishes = Object.entries(data).map(([prefab, entry]) => {
        const mod = entry.modded ?? {}
        return {
          prefab,
          name: entry.name,
          hunger: mod.hunger ?? entry.vanilla.hunger,
          sanity: mod.sanity ?? entry.vanilla.sanity,
          health: mod.health ?? entry.vanilla.health,
          rot_time: mod.rot_time ?? entry.vanilla.rot_time,
          cook_time: mod.cook_time ?? entry.vanilla.cook_time,
          priority: mod.priority ?? entry.vanilla.priority,
          moddedFields: {
            hunger: mod.hunger !== undefined,
            sanity: mod.sanity !== undefined,
            health: mod.health !== undefined,
            rot_time: mod.rot_time !== undefined,
            cook_time: mod.cook_time !== undefined,
            priority: mod.priority !== undefined,
          },
        }
      })
    } catch (err) {
      error = (err as Error).message
    } finally {
      loading = false
    }
  })

  function toggleSort(key: SortKey) {
    if (sortKey === key) {
      sortDirection = sortDirection === 'asc' ? 'desc' : 'asc'
    } else {
      sortKey = key
      sortDirection = key === 'name' ? 'asc' : 'desc'
    }
  }

  function formatRotTime(seconds: number): string {
    if (seconds <= 0 || seconds >= 9000000) {
      return 'Never'
    }
    return `${seconds / 480}d`
  }

  function formatCookTime(multiplier: number): string {
    return `${multiplier * 20}s`
  }

  let sortedDishes = $derived(
    [...dishes].sort((a, b) => {
      const valA = a[sortKey]
      const valB = b[sortKey]
      if (typeof valA === 'string' && typeof valB === 'string') {
        const comparison = valA.localeCompare(valB)
        return sortDirection === 'asc' ? comparison : -comparison
      }
      const numA = Number(valA)
      const numB = Number(valB)
      return sortDirection === 'asc' ? numA - numB : numB - numA
    })
  )
</script>

<div class="container">
  <div class="table-wrapper">
    {#if loading}
      <div class="status-message">Loading dishes data...</div>
    {:else if error}
      <div class="status-message">{error}</div>
    {:else}
      <table>
        <colgroup>
          <col class="col-icon" />
          <col class="col-dish" />
          <col class="col-hunger" />
          <col class="col-sanity" />
          <col class="col-health" />
          <col class="col-rot" />
          <col class="col-cook" />
          <col class="col-priority" />
        </colgroup>
        <thead>
          <tr>
            <th class="col-icon">Icon</th>
            <th class="col-dish sortable" onclick={() => toggleSort('name')}>
              <div class="header-content">
                <span>Dish</span>
                <span class="sort-indicator">
                  {#if sortKey === 'name'}
                    {sortDirection === 'asc' ? '▲' : '▼'}
                  {:else}
                    <span class="sort-inactive">⇅</span>
                  {/if}
                </span>
              </div>
            </th>
            <th class="col-hunger sortable" onclick={() => toggleSort('hunger')}>
              <div class="header-content">
                <img src="/icons/extra/hunger.png" alt="Hunger" class="header-icon" title="Hunger" />
                <span class="sort-indicator">
                  {#if sortKey === 'hunger'}
                    {sortDirection === 'asc' ? '▲' : '▼'}
                  {:else}
                    <span class="sort-inactive">⇅</span>
                  {/if}
                </span>
              </div>
            </th>
            <th class="col-sanity sortable" onclick={() => toggleSort('sanity')}>
              <div class="header-content">
                <img src="/icons/extra/sanity.png" alt="Sanity" class="header-icon" title="Sanity" />
                <span class="sort-indicator">
                  {#if sortKey === 'sanity'}
                    {sortDirection === 'asc' ? '▲' : '▼'}
                  {:else}
                    <span class="sort-inactive">⇅</span>
                  {/if}
                </span>
              </div>
            </th>
            <th class="col-health sortable" onclick={() => toggleSort('health')}>
              <div class="header-content">
                <img src="/icons/extra/health.png" alt="Health" class="header-icon" title="Health" />
                <span class="sort-indicator">
                  {#if sortKey === 'health'}
                    {sortDirection === 'asc' ? '▲' : '▼'}
                  {:else}
                    <span class="sort-inactive">⇅</span>
                  {/if}
                </span>
              </div>
            </th>
            <th class="col-rot sortable" onclick={() => toggleSort('rot_time')}>
              <div class="header-content">
                <img src="/icons/extra/rot.png" alt="Rot Time" class="header-icon" title="Rot Time" />
                <span class="sort-indicator">
                  {#if sortKey === 'rot_time'}
                    {sortDirection === 'asc' ? '▲' : '▼'}
                  {:else}
                    <span class="sort-inactive">⇅</span>
                  {/if}
                </span>
              </div>
            </th>
            <th class="col-cook sortable" onclick={() => toggleSort('cook_time')}>
              <div class="header-content">
                <img src="/icons/extra/crockpot.png" alt="Cook Time" class="header-icon" title="Cook Time" />
                <span class="sort-indicator">
                  {#if sortKey === 'cook_time'}
                    {sortDirection === 'asc' ? '▲' : '▼'}
                  {:else}
                    <span class="sort-inactive">⇅</span>
                  {/if}
                </span>
              </div>
            </th>
            <th class="col-priority sortable" onclick={() => toggleSort('priority')}>
              <div class="header-content">
                <img src="/icons/extra/priority.png" alt="Priority" class="header-icon" title="Priority" />
                <span class="sort-indicator">
                  {#if sortKey === 'priority'}
                    {sortDirection === 'asc' ? '▲' : '▼'}
                  {:else}
                    <span class="sort-inactive">⇅</span>
                  {/if}
                </span>
              </div>
            </th>
          </tr>
        </thead>
        <tbody>
          {#each sortedDishes as dish (dish.prefab)}
            <tr>
              <td class="col-icon">
                <img
                  src={`/icons/dishes/${dish.prefab}.png`}
                  alt={dish.name}
                  class="dish-icon"
                  loading="lazy"
                  onerror={(e) => {
                    const target = e.currentTarget as HTMLImageElement
                    target.style.display = 'none'
                  }}
                />
              </td>
              <td class="col-dish">{dish.name}</td>
              <td class="col-hunger" class:stat-modded={dish.moddedFields.hunger}>{dish.hunger}</td>
              <td class="col-sanity" class:stat-modded={dish.moddedFields.sanity}>{dish.sanity}</td>
              <td class="col-health" class:stat-modded={dish.moddedFields.health}>{dish.health}</td>
              <td class="col-rot" class:stat-modded={dish.moddedFields.rot_time}>{formatRotTime(dish.rot_time)}</td>
              <td class="col-cook" class:stat-modded={dish.moddedFields.cook_time}>{formatCookTime(dish.cook_time)}</td>
              <td class="col-priority" class:stat-modded={dish.moddedFields.priority}>{dish.priority}</td>
            </tr>
          {/each}
        </tbody>
      </table>
    {/if}
  </div>
</div>
