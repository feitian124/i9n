package i18n

import (
	"golang.org/x/text/language"
)

var supported = []language.Tag{
	language.AmericanEnglish,
	language.English,
	language.SimplifiedChinese,
	language.Chinese,
}

var matcher = language.NewMatcher(supported)

// Tags convert language strings to array of language.Tag
func Tags(lang ...string) []language.Tag {
	slice := make([]language.Tag, len(lang))
	for i, _ := range slice {
		slice[i] = language.Make(lang[i])
	}
	return slice
}
