package main

import (
	"flag"
	"github.com/feitian124/i9n/pkg/i18n"
	"golang.org/x/text/language"
)

//go:generate go run ../internal/cmd/extractor
//go:generate go run ../internal/cmd/generator

func main() {
	var lang = flag.String("l", "", "language: en, ch")
	flag.Parse()
	if *lang == "ch" {
		i18n.Init2(language.SimplifiedChinese)
	} else {
		i18n.Init2(language.AmericanEnglish)
	}
	i18n.Printf("hi, customer. %d apple or %d apples?", 1, 2)
}
