FROM golang:1.23

RUN apt-get update && apt-get install -y bash

WORKDIR /usr/src/k8s-demo

COPY go.mod go.sum ./
RUN go mod download && go mod verify

COPY . .

RUN env GOOS=linux GOARCH=amd64 go build -v -o /usr/local/bin/k8s-demo-server ./...

CMD ["k8s-demo-server"]

EXPOSE 8080