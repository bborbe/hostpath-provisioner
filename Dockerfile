FROM golang:1.11.0 AS build
COPY . /go/src/github.com/bborbe/hostpath-provisioner
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags "-s" -a -installsuffix cgo -o /main ./src/github.com/bborbe/hostpath-provisioner
CMD ["/bin/bash"]

FROM scratch
COPY --from=build /main /main
ADD https://curl.haxx.se/ca/cacert.pem /etc/ssl/certs/ca-certificates.crt
ENTRYPOINT ["/main"]
