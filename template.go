package main

import (
	"bufio"
	"os"
	"strconv"
	"strings"
)

type buffer struct {
	*bufio.ReadWriter
}

func (b *buffer) read(v any) {
	s, _ := b.ReadString('\n')
	y := strings.Fields(s)

	switch x := v.(type) {
	case *bool:
		*x, _ = strconv.ParseBool(y[0])
	case *int64:
		*x, _ = strconv.ParseInt(y[0], 10, 64)
	case *float64:
		*x, _ = strconv.ParseFloat(y[0], 64)
	case *string:
		*x = y[0]
	case *[]bool:
		for i, v := range y {
			(*x)[i], _ = strconv.ParseBool(v)
		}
	case *[]int64:
		for i, v := range y {
			(*x)[i], _ = strconv.ParseInt(v, 10, 64)
		}
	case *[]float64:
		for i, v := range y {
			(*x)[i], _ = strconv.ParseFloat(v, 64)
		}
	case *[]string:
		for i, v := range y {
			(*x)[i] = v
		}
	default:
		panic("expected 'pointer' or 'pointer to slice' of bool | int64 | float64 | string")
	}
}

func (b *buffer) write(v any) {
	var y string

	switch x := v.(type) {
	case bool:
		y = strconv.FormatBool(x)
	case int64:
		y = strconv.FormatInt(x, 10)
	case float64:
		y = strconv.FormatFloat(x, 'g', -1, 64)
	case string:
		y = x
	default:
		panic("expected bool | int64 | float64 | string")
	}

	buf.WriteString(y)
}

var buf buffer = buffer{
	bufio.NewReadWriter(
		bufio.NewReader(os.Stdin),
		bufio.NewWriter(os.Stdout),
	),
}

func soln() {}

func main() {
	defer buf.Flush()

	t := 1
	buf.read(&t) // comment this if only one test case

	for i := 0; i < t; i++ {
		soln()
	}
}
