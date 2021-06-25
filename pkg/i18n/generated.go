package i18n

import (
	"golang.org/x/text/language"
	"golang.org/x/text/message"
)

// initEnUS will init en_US support.
func initEnUS(tag language.Tag) {
	_ = message.SetString(tag, "hi, customer. %d apple or %d apples?", "hi, customer. %d apple or %d apples?")
}

// initZhCN will init zh_CN support.
func initZhCN(tag language.Tag) {
	_ = message.SetString(tag, "hi, customer. %d apple or %d apples?", "用戶您好, 你要 %d 个苹果还是 %d 两个苹果?")
}
