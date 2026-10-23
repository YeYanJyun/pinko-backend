
FROM golang:1.22-alpine AS builder

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . .

# 診斷：確認 Go 原始碼有沒有進入 /app
RUN pwd && ls -la && find . -name '*.go' -type f

RUN go build -o app .

FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/app ./app

EXPOSE 8080

CMD ["./app"]

