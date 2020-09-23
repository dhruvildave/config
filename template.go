package main

import (
	"bufio"
	"fmt"
	"os"
)

var buf = bufio.NewReadWriter(bufio.NewReader(os.Stdin), bufio.NewWriter(os.Stdout))

func soln() {}

func main() {
	defer buf.Flush()
	t := 1
	fmt.Fscan(buf, &t) // comment this if only one test case
	for i := 0; i < t; i++ {
		soln()
	}
}
