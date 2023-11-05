# Build the application from source
FROM golang:latest AS builder

LABEL org.opencontainers.image.source https://github.com/varieget/derper

WORKDIR /app

ADD tailscale /app/tailscale

RUN cd /app/tailscale/cmd/derper && \
    CGO_ENABLED=0 GOOS=linux go build -o /app/derper && \
    cd /app && \
    rm -rf /app/tailscale

# Deploy the application binary
FROM alpine:latest

WORKDIR /app

ENV DERP_ADDR :443
ENV DERP_HTTP_PORT 80
ENV DERP_CERTS=/app/certs/
ENV DERP_HOST=127.0.0.1
ENV DERP_STUN true
ENV DERP_VERIFY_CLIENTS false

COPY --from=builder /app/derper /app/derper

CMD /app/derper --a=$DERP_ADDR \
    --certmode=manual \
    --certdir=$DERP_CERTS \
    --hostname=$DERP_HOST \
    --http-port=$DERP_HTTP_PORT \
    --stun=$DERP_STUN \
    --verify-clients=$DERP_VERIFY_CLIENTS
