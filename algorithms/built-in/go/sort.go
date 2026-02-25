package main

import (
	"fmt"
	"math"
	"math/rand"
	"os"
	"slices"
	"time"

	"github.com/pborman/getopt"
)

var (
	optHelp    *bool
	optLower   *int
	optUpper   *int
	optStep    *int
	optIter    *int
	optOutfile *string
)

func init() {
	optLower = getopt.IntLong("lower", 'l', 0, "lower bound")
	optUpper = getopt.IntLong("upper", 'u', 0, "upper bound")
	optStep = getopt.IntLong("step", 's', 0, "steps")
	optIter = getopt.IntLong("iter", 'i', 0, "iterations")
	optOutfile = getopt.StringLong("out", 'o', "", "out file")
	optHelp = getopt.BoolLong("help", 'h', "Help")
}

func createArray(n int) []int {
	data := make([]int, n)

	for i := range n {
		data[i] = rand.Intn(math.MaxInt)
	}

	return data
}

func timeSort(data []int, iter int) int64 {
	tmp := make([]int, len(data))
	copy(tmp, data)

	start := time.Now()

	for range iter {
		copy(data, tmp)
		slices.Sort(data)
	}

	return time.Since(start).Nanoseconds()
}

func parseOpts() {

	getopt.Parse()
}

func formatTime(elapsed int64, n int) (out string) {
	outFile := getopt.Lookup("out")
	if outFile.Seen() {
		out = fmt.Sprintf("%d, %d\n", n, elapsed)
	} else {
		out = fmt.Sprintf("%d:\t%dns\n", n, elapsed)
	}

	return
}

func tryCreateFile() {
	outFile := getopt.Lookup("out")
	if outFile.Seen() {
		os.Create(outFile.String())
	}
}

func writeTime(out string) {
	outFile := getopt.Lookup("out")
	if !outFile.Seen() {
		fmt.Print(out)
		return
	}

	file, err := os.OpenFile(outFile.String(), os.O_APPEND|os.O_WRONLY, 0600)
	if err != nil {
		panic(err)
	}
	defer file.Close()

	_, err = file.WriteString(out)
	if err != nil {
		panic(err)
	}
}

func main() {
	parseOpts()
	tryCreateFile()

	if *optHelp || len(os.Args) == 1 {
		getopt.Usage()
		os.Exit(0)
	}

	for n := *optLower; n <= *optUpper; n += *optStep {
		data := createArray(n)
		elapsed := timeSort(data, *optIter)
		elapsed = elapsed / int64(*optIter)
		out := formatTime(elapsed, n)
		writeTime(out)
	}
}
