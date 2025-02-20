# CONTAINER FOR BUILDING BINARY
FROM golang:1.22 AS build

WORKDIR $GOPATH/src/github.com/0xPolygon/cdk-data-availability

# INSTALL DEPENDENCIES
COPY go.mod go.sum ./
RUN go mod download

# BUILD BINARY
COPY . .
RUN make build

# CONTAINER FOR RUNNING BINARY
FROM alpine:3.16.0

COPY --from=build /go/src/github.com/0xPolygon/cdk-data-availability/dist/xlayer-data-availability /app/xlayer-data-availability

EXPOSE 8444

CMD ["/bin/sh", "-c", "/app/xlayer-data-availability run"]
