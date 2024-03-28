# kbot

## build

```bash
go get
go build -ldflags "-X="github.com/damevanderjahr/kbot/cmd.appVersion=v1.0.2
```

## run

```bash
read -s TELE_TOKEN
# paste token, press enter
export TELE_TOKEN
./kbot start
```
