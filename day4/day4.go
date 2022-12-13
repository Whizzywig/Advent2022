package main

import (
	"fmt"
	"os"
	"strings"
)

func main() {
	dat, err := os.ReadFile("input.txt")
	if err != nil {
		panic(err)
	}
	//fmt.Print(string(dat))
	encapsulations := 0
	tmp := strings.Split(string(dat), "\n")
	for _, line := range tmp {
		// check if one pair full contains the other
		// get the two pairs e.g. 2-4,3-4 then check if first begin is smaller or equal to second begin
		s := strings.Split(line, ",")
		first := strings.Split(s[0], "-")
		seccond := strings.Split(s[1], "-")
		if (first[0] >= seccond[0]) && (first[1] <= seccond[1]) || ((first[0] <= seccond[0]) && (first[1] >= seccond[1])) {
			encapsulations++
			fmt.Printf("First: %s, seccond: %s\n", s[0], s[1])
			fmt.Println("count:", encapsulations)
		}
	}
	//457 too low
	fmt.Printf("Encapsulations: %d\n", encapsulations)
}
