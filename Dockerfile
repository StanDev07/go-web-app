FROM golang:1.22-alpine AS builder

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o go-web-app .

FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/go-web-app /app/go-web-app
COPY --from=builder /app/static /app/static

EXPOSE 8080

CMD ["./go-web-app"]