import fs from "fs"
import { performance } from "perf_hooks"
import * as url from 'node:url';

export function calculate(path) {
  const fullFileContents = fs.readFileSync(path, 'utf8')
  const lines = fullFileContents.trim().split("\n")

  let result = 0

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i]
    console.log(line)
  }

  return result.toString()
}

if (import.meta.url.startsWith('file:')) {
  const modulePath = url.fileURLToPath(import.meta.url);
  if (process.argv[1] === modulePath) {
    const start = performance.now()
    let result = calculate("../input.txt")
    const end = performance.now()
    if (result[result.length] === "\n") {
      result = result.slice(0, -1)
    }
    console.log(`Result:\n${result}`)
    console.log(`Time elapsed: ${(end - start).toFixed(3)} ms`)

  }
}
