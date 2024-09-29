# Construcció
FROM golang:1.23.1 AS builder
WORKDIR /app
COPY server.go .
RUN go build -o golang-server server.go

# Imatge mínima per si es vol fer més petita
# FROM scratch
# COPY --from=builder /app/golang-server /golang-server
CMD ["/golang-server"]
