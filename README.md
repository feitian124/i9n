# i9n

i9n is an easy and powerful golang module make your i18n work twice faster, namely `i9n`.

## feature

- no need write i18n resource files, use `i9n.Printf` and generate them by one command.
- support [go-zero](https://github.com/tal-tech/go-zero), [gin](https://github.com/gin-gonic/gin.git) out of box, other frameworks by plugins

## example

```shell
→ go run cmd/main.go -l ch
用戶您好, 你要 1 个苹果还是 2 两个苹果?

→ go run cmd/main.go -l en
hi, customer. 1 apple or 2 apples?
```

## todo
go has built in support for i18n at https://github.com/golang/text.git,
the baisc idea is:
1. extract strings need to be translated in source code
2. generate resources and translate them by someone
3. load these resource
4. manually rewrite or use `gotext rewrite` to replace `fmt.Print` with `message.Printer`

see `gotext` branch, which works after build but has issue when run `go run main.go` directly

## thanks

- <https://xuanwo.io/2019/12/11/golang-i18n/>
- <https://github.com/nicksnyder/go-i18n>
- <https://github.com/kataras/i18n>
- <https://github.com/maximilien/i18n4go>
