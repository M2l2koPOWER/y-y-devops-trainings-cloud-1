FROM golang:1.21 as build

WORKDIR /catgpt
COPY . .

RUN go mod download
RUN CGO_ENABLED=0 go build -o /catgpt

FROM gcr.io/distroless/static-debian12:latest-amd64
COPY --from=build /catgpt /
CMD ["/catgpt"]