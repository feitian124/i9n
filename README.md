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

## thanks

- <https://xuanwo.io/2019/12/11/golang-i18n/>
- https://phrase.com/blog/posts/internationalization-i18n-go/
- <https://github.com/nicksnyder/go-i18n>
- <https://github.com/kataras/i18n>
- <https://github.com/maximilien/i18n4go>
