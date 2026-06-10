# VollaOS

**VollaOS** is the AOSP-based operating system that powers Volla devices.

It is fully open source, de-Googled, and built with privacy as a first principle. No Google services, no hidden telemetry, no proprietary tracking — the system ships clean and stays out of the user's way. Every line of the OS, and every modification we make on top of upstream Android, is published publicly so it can be inspected, audited, and verified by anyone.

## What this repository is

This repository is the **Volla-specific product layer** of VollaOS — the set of components that turn an upstream AOSP tree into a complete, shippable Volla device image. It sits alongside the rest of the VollaOS source tree (kernel, device trees, vendor blobs, AOSP itself) inside a full manifest-driven checkout, and is consumed by the build system when assembling a release.

## Branches

Branches track the VollaOS version they target — `volla-10.1`,`volla-11.1`, `volla-12.1`, `volla-13.0`, `volla-14.0`, `volla-15.0`, `volla-16.0`. Pick the branch that matches the VollaOS release you are interested in.

## License

Source under this repository is released under the **Volla Licence 1.0** (see [`LICENSE`](LICENSE)).

Copyright © Volla Systeme GmbH 2026.
Maintained by: Aryan Sinha <aryan.sinha@volla.online>
