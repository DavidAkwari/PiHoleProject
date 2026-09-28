# Pi-hole Network DNS Sinkhole

A network-wide DNS sinkhole running on a Raspberry Pi. It intercepts and blocks ads, telemetry, tracking, and malicious domains for every device on my home network.

## Why I built this

Ads and promotions were getting annoying on my home network — a Roku TV, a few other devices, YouTube. I wanted one point of control instead of ad-blockers on every device.

## The interesting part

My ISP-provided Xfinity gateway doesn't allow custom DNS settings. So instead of giving up, I made the Pi-hole the network's primary DHCP server, handing out IPs in the 10.0.0.50–10.0.250 range. Then I disabled both stateless and stateful DHCPv6 on the gateway, because modern devices will happily bypass your DNS filter over IPv6 if you let them. Now all local traffic is forced through the managed IPv4 DNS sinkhole.

## Setup

- **Hardware:** Raspberry Pi 3 (Model B), hostname `akwabot`
- **Network:** WiFi (wireless) with a static IP assignment
- **Upstream DNS:** Google ECS with DNSSEC
- **Install:** Official Pi-hole automated installer

One hiccup during setup: the initial system update failed because `packagekitd` was holding the lock at `/var/lib/apt/lists/lock`. Killed the process, re-ran the update, moved on.

## Filtering

- Base blocklist: **75,994** known tracking domains
- Added community lists: OISD and HaGeZi via Group Management → Adlists
- Granular per-device policies and custom exact-deny rules, built by watching live query logs and isolating outbound telemetry to specific destinations

## Results

- Covers **6 devices**
- First sample: **10 of 858** queries blocked (1.2%)
- Roku promotions: gone
- YouTube ads: **not blocked** — Pi-hole works at the DNS level, and YouTube serves ads from the same domains as its content. Honest limitation, worth knowing before you deploy one.

## What's in this repo

- `configs/` — Pi-hole configuration exports
- `scripts/` — automation scripts

## What I'd do differently

Add a second Pi as failover so DNS doesn't die when I reboot the thing. Also considering DNS-over-HTTPS for upstream queries so my ISP can't see them either.