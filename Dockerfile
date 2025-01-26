FROM golang:1.23-alpine AS builder

ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o /todo_backend ./cmd/main.go

FROM alpine:latest 

WORKDIR /

COPY --from=builder /todo_backend /todo_backend

EXPOSE 8080

CMD ["/todo_backend"]