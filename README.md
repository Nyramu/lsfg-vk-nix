# lsfg-vk-nix

[![NixOS unstable](https://img.shields.io/badge/NixOS-unstable-78C0E8?logo=nixos&logoColor=white)](https://nixos.org)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](./LICENSE)

Nix flake for [lsfg-vk](https://git.lsfg-vk.dev/lsfg-vk).

> **Disclaimer:** This repository does not contain any source code or binaries, original or modified, of the upstream project. It only provides build instructions.

## Upstream

|             |                                                         |
| ----------- | ------------------------------------------------------- |
| **Project** | [PancakeTAS/lsfg-vk](https://git.lsfg-vk.dev/lsfg-vk) |
| **License** | CC BY-NC-ND 4.0                                       |

## What is this?

A Nix flake that provides a derivation of lsfg-vk's latest git commit.

## Installation

Add this flake input:

```nix
{
  inputs = {
    lsfg-vk-nix.url = "github:Nyramu/lsfg-vk-nix";
  };
}
```

Then install the packages:

```nix
{ inputs, pkgs, ... }:
{
  environment.systemPackages = with inputs.lsfg-vk-nix.packages.${pkgs.stdenv.hostPlatform.system} [
    lsfg-vk
    lsfg-vk-ui
  ];
}
```

They will build locally on your machine.

## License

This flake (the packaging instructions) is [CC BY-NC-ND 4.0](./LICENSE) licensed (matches
upstream). Upstream lsfg-vk is
[CC BY-NC-ND 4.0](https://git.lsfg-vk.dev/lsfg-vk/tree/LICENSE.txt).
