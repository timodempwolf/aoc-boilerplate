package main

import (
	"testing"
)

func TestTask(t *testing.T) {
	got, _ := calculate("../example.txt")
	want := "4361"
	if got != want {
		t.Errorf("got %q want %q", got, want)
	}
}

func BenchmarkCalculate(b *testing.B) {
	for n := 0; n < b.N; n++ {
		calculate("../input.txt")
	}
}
