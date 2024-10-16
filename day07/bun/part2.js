export async function calculate(path) {
  const fullFileContents = await Bun.file(path).text()
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

if (import.meta.main) {
  const start = performance.now()
  let result = await calculate("../input.txt")
  const end = performance.now()

  console.log(`Result:\n${result.trimEnd()}`)
  console.log(`Execution time: ${(end - start).toFixed(3)} ms`)
}
