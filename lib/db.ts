import { Pool } from "pg"

let pool: Pool | null = null

export function getPool(): Pool {
  if (!pool) {
    pool = new Pool({
      connectionString: process.env.DATABASE_URL,
      max: 10, // Maximum number of clients in the pool
      idleTimeoutMillis: 30000, // Close idle clients after 30 seconds
      connectionTimeoutMillis: 2000, // Return an error after 2 seconds if connection could not be established
      maxUses: 7500, // Close (and replace) a connection after it has been used 7500 times
    })

    // Handle pool errors
    pool.on("error", (err) => {
      console.error("[v0] Database pool error:", err)
    })

    // Graceful shutdown
    process.on("SIGINT", () => {
      pool?.end()
    })
    process.on("SIGTERM", () => {
      pool?.end()
    })
  }

  return pool
}

export async function query(text: string, params?: any[]) {
  const pool = getPool()
  const client = await pool.connect()

  try {
    const result = await client.query(text, params)
    return result
  } catch (error) {
    console.error("[v0] Database query error:", error)
    throw error
  } finally {
    client.release() // Always release the client back to the pool
  }
}
