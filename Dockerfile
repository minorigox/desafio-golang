FROM golang:1.20 AS builder

WORKDIR /app

COPY go.mod .
COPY main.go .

RUN go mod tidy && CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

FROM scratch

COPY --from=builder /app/main /main

CMD ["/main"]