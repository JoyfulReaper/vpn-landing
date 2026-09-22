# vpn-landing

A small WireGuard-only landing page for the services, hosts, and admin tools available across my private VPN.

It acts as a quick network inventory and service directory so I do not have to remember which machine owns which address or port.

The page is intentionally simple: a tiny Go HTTP server serving static files, bound directly to the WireGuard interface.

## Network

The landing page is available only on the WireGuard network.

Current WireGuard ranges:

```text
10.99.0.0/24
fd42:42:42::/64
```

The server binds to:

```text
10.99.0.1:8081
```

There is no public listener by design.

## What it contains

The page documents things such as:

- WireGuard peers
- VPN IPv4 and IPv6 addresses
- selected routed IPv6 addresses
- public and private services
- admin interfaces
- development VMs
- infrastructure services
- protocol endpoints
- useful documentation and reference links

Examples include:

- Dozzle
- Dockge
- NATS monitoring
- Mission Control
- Random Steam
- Random GitHub
- Pi-hole
- PairDrop
- Scrutiny
- NetAlertX
- Uptime Kuma
- SSH-accessible hosts
- Gopher, Gemini, Finger, QOTD, and other small services

Direct WireGuard IP addresses are preferred for VPN-only links so the page still works for peers that are not using the internal Pi-hole DNS server.

## Running

Requirements:

- Go
- a host with `10.99.0.1` assigned to its WireGuard interface

Run directly:

```bash
go run .
```

Or build it:

```bash
go build
./vpn-landing
```

The server will listen on:

```text
http://10.99.0.1:8081
```

## Project structure

```text
.
├── main.go
├── static/
│   ├── index.html
│   ├── style.css
│   └── app.js
└── README.md
```

`main.go` is intentionally tiny and only serves the static site.

Most of the useful information lives in `static/index.html`.

## Design goals

This project is deliberately boring.

The goals are:

- work reliably from any WireGuard peer
- avoid unnecessary dependencies
- keep the network inventory easy to inspect and edit
- make common services reachable without remembering ports
- remain useful even if internal DNS is unavailable
- avoid turning a glorified bookmark page into Kubernetes somehow

## Planned improvements

Possible future improvements include:

- lightweight service reachability checks
- simple up/down/unknown indicators
- cached server-side health probes
- better automatic inventory generation
- links for Yggdrasil and DN42 infrastructure as those networks evolve

Health checks should remain lightweight and should not block normal page loads.

## License

See `LICENSE`.
