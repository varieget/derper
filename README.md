# Custom DERP Servers

## Run your own DERP server

```bash
docker run \
  --restart=always -d \
  --name derper \
  -p 8443:443 \
  -p 3478:3478/udp \
  -e DERP_HTTP_PORT="-1" \
  -e DERP_HOST="127.0.0.1" \
  -e DERP_VERIFY_CLIENTS=true \
  -v /var/run/tailscale/tailscaled.sock:/var/run/tailscale/tailscaled.sock \
  -v /root/derp/:/app/certs/ \
  ghcr.io/varieget/derper:main
```

## Docs

Offical documentation: [Custom DERP Servers](https://tailscale.com/kb/1118/custom-derp-servers/)
