# Pi hole Network DNS Sinkhole

This repository contains the documentation, configuration details, and automation scripts for a network wide DNS sinkhole deployed on a Raspberry Pi. This project intercepts and blocks telemetry tracking, advertisements, and malicious domains across all connected devices on a local network.

## Technical Environment Model B
* **Hardware:** Raspberry Pi 3
* **Hostname:** akwabot
* **Network Interface:** Wired Ethernet eth0
* **Static IPv4 Assignment:** 10.0.0.16
* **Upstream DNS Resolver:** Google ECS DNSSEC

## Deployment and Configuration
The deployment utilized the official automated installation script. During the initial system update, a directory lock conflict occurred at /var/lib/apt/lists/lock. The terminal indicated the lock was held by a background process named packagekitd. I manually terminated this process to release the directory lock and successfully execute the update commands.

The server was bound strictly to the eth0 interface to ensure maximum stability and assigned a permanent static IP address of 10.0.0.16.

## Network Routing and DHCP Management
Because the ISP provided Xfinity gateway restricts custom DNS modifications, I engineered a DHCP handover. I configured the Pi hole to act as the primary DHCP server, distributing a designated IP pool from 10.0.0.50 to 10.0.0.250.

To prevent modern devices from bypassing the DNS filtering protocols via IPv6, both Stateless and Stateful DHCPv6 options were completely disabled within the Xfinity gateway. This forced all local network traffic to route strictly through the managed IPv4 DNS sinkhole.

## Traffic Monitoring and Advanced Filtering
The baseline installation utilized a standard blocklist comprising 75,994 known tracking domains. To enhance network defenses, I integrated community curated blocklists including OISD and HaGezi via the Group Management Adlists interface.

Granular query inspection allowed for the enforcement of custom access policies. Live logs for specific clients displayed continuous outbound telemetry requests to multiple destinations. I manually isolated domains like www.google.com from the live feed and appended them to the domain management directory as exact deny rules.
