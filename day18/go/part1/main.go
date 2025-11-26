package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
	"time"
)

func calculate(filepath string) (string, time.Duration) {
	start := time.Now()
	file, err := os.Open(filepath)
	if err != nil {
		panic(err)
	}
	defer func() {
		err = file.Close()
		if err != nil {
			fmt.Println(err)
		}
	}()

	result := 0
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()

		// BEGIN TO DELETE
		fmt.Println(line)
		// END TO DELETE
	}
	elapsed := time.Since(start)
	return fmt.Sprintf("%v", result), elapsed
}

func main() {
	result, elapsed := calculate("../input.txt")

	fmt.Printf("Result:\n%s\n", strings.TrimRight(result, " \t\r\n"))
	fmt.Printf("Execution time: %s\n", elapsed)
}
