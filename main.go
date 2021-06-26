package main

//go:generate gotext -srclang=en update -out=catalog.go -lang=en,el

import (
	"golang.org/x/text/language"
	"golang.org/x/text/message"
	_ "golang.org/x/text/message/catalog"
)

func main() {
	p := message.NewPrinter(language.Greek)
	p.Printf("Hello world!")
	p.Println()
}