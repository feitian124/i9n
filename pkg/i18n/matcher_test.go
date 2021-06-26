package i18n

import (
	"github.com/stretchr/testify/assert"
	"golang.org/x/text/language"
	"testing"
)

func TestTags(t *testing.T) {
	expected := Tags("en", "zh")
	assert.Equal(t, expected, []language.Tag{language.English, language.Chinese})
}
