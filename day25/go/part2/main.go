package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"time"
)

func calculate(filepath string) (string, string, time.Duration) {
	start := time.Now()
	file, err := os.Open(filepath)
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	result1 := 0
	result2 := 0
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		fmt.Println(line)
	}
	elapsed := time.Since(start)
	return fmt.Sprintf("%v", result1), fmt.Sprintf("%v", result2), elapsed
}

func main() {
	result1, result2, elapsed := calculate("../input.txt")
	if result1[len(result1)-1] != '\n' {
		result1 += "\n"
	}
	if result2[len(result2)-1] != '\n' {
		result2 += "\n"
	}
	fmt.Printf("Task 1:\n%sTask 2:\n%s", result1, result2)
	fmt.Printf("Execution time: %s\n", elapsed)
}
