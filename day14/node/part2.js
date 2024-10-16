import fs from "fs"
import { performance } from "perf_hooks"
import * as url from 'node:url';

export function calculate(path) {
  const fullFileContents = fs.readFileSync(path, 'utf8')
  const lines = fullFileContents.trim().split("\n")

  let result = 0

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i]

    // BEGIN TO DELETE
    result = line.length
    // END TO DELETE
  }

  return result.toString()
}

if (process.argv[1] === url.fileURLToPath(import.meta.url)) {
  const start = performance.now()
  let result = calculate("../input.txt")
  const end = performance.now()

  console.log(`Result:\n${result.trimEnd()}`)
  console.log(`Execution time: ${(end - start).toFixed(3)} ms`)
}
