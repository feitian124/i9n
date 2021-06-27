package main

//go:generate gotext -srclang=en update -out=catalog.go -lang=en,zh

import (
	"fmt"
	"golang.org/x/text/language"
	"golang.org/x/text/message"
	_ "golang.org/x/text/message/catalog"
)

func main() {
	p(language.English)

	fmt.Println()

	p(language.Chinese)

}

func p(t language.Tag) {
	p := message.NewPrinter(t)
	p.Printf("Hello, %s", "world")
	p.Println()
}
