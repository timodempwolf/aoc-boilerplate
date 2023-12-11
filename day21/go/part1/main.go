package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"time"
)

func calculate(filepath string) (string, time.Duration) {
	start := time.Now()
	file, err := os.Open(filepath)
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	result := 0
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		fmt.Println(line)
	}
	elapsed := time.Since(start)
	return fmt.Sprintf("%v", result), elapsed
}

func main() {
	result, elapsed := calculate("../input.txt")
	if result[len(result)-1] != '\n' {
		result += "\n"
	}
	fmt.Printf("Result:\n%s", result)
	fmt.Printf("Execution time: %s\n", elapsed)
}
