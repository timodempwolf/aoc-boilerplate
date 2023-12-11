package main

import (
	"testing"
)

func TestTask1(t *testing.T) {
	got, _, _ := calculate("../example.txt")
	want := "4361"
	if got != want {
		t.Errorf("got %q want %q", got, want)
	}
}

func TestTask2(t *testing.T) {
	if testing.Short() {
		t.Skip("only checking task 1 in short mode")
	}
	_, got, _ := calculate("../example2.txt")
	want := "467835"
	if got != want {
		t.Errorf("got %q want %q", got, want)
	}
}

func BenchmarkCalculate(b *testing.B) {
	for n := 0; n < b.N; n++ {
		calculate("../input.txt")
	}
}
