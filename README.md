# Justice System

**Transforming the U.S. Justice Branch through 3D Simulation and Advanced Technology**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)

## Overview

This repository contains the Justice System platform - an open-source framework combining 3D simulation, AI, blockchain, and advanced technologies to build a transparent, accountable, and evidence-based U.S. Justice System.

## Repository Structure

```
rust-justice/
├── website/              # Leptos + Trunk website with Tailwind CSS
├── crates/
│   └── justice-eustress/ # Eustress Engine integration crate
├── Conceptual/           # Upstream: Justice conceptual framework (16-category taxonomy)
└── Eustress/             # Upstream: Eustress Engine (Bevy-based game engine)
```

## Components

### Website (`website/`)

A modern Rust-based website built with:
- **Leptos** - Reactive web framework
- **Trunk** - WASM build tool
- **Tailwind CSS** - Utility-first styling

```bash
cd website
bun install
trunk serve
```

### Justice-Eustress Integration (`crates/justice-eustress/`)

A dedicated crate for justice-centric additions to the Eustress Engine:
- **Courtroom simulation** - Immersive 3D courtroom environments
- **Evidence visualization** - Chain of custody and 3D evidence display
- **Training scenarios** - Professional training for justice system roles
- **Networking** - Multiplayer courtroom sessions

This crate is intentionally **separate from the Eustress Engine** to:
- Receive upstream Eustress updates without conflicts
- Keep justice-specific logic modular
- Allow independent versioning

### Upstream Repositories

- **Conceptual/** - [WeaveITMeta/Justice](https://github.com/WeaveITMeta/Justice) - 16-category taxonomy covering the entire U.S. justice system
- **Eustress/** - [WeaveITMeta/EustressEngine](https://github.com/WeaveITMeta/EustressEngine) - Batteries-included Bevy fork

## Quick Start

### Prerequisites

- Rust (latest stable)
- Trunk (`cargo install trunk`)
- wasm32 target (`rustup target add wasm32-unknown-unknown`)
- Bun (for Tailwind CSS)

### Development

```bash
# Install dependencies
cd website && bun install && cd ..

# Run the website
cd website
trunk serve

# Build the justice-eustress crate
cargo build -p justice-eustress
```

### Using Justice-Eustress

```rust
use justice_eustress::prelude::*;

// Create a courtroom session
let config = courtroom::presets::federal_district_court();
let mut session = CourtroomSession::new(config);

// Create a case
let mut case = Case::new("2026-CR-001", CaseType::Criminal, "United States v. Example");
case.add_participant(Participant::new("Hon. Smith", CourtroomRole::Judge));

// Start the session
session.start_session(case);
```

## Architecture

```
┌─────────────────────────────────────────────────────────┐
│              JUSTICE SYSTEM PLATFORM                     │
├─────────────────────────────────────────────────────────┤
│  AI Hotline │ Sentinel │ Identity │ 3D Simulation       │
├─────────────────────────────────────────────────────────┤
│           INTEGRATION (justice-eustress)                 │
├─────────────────────────────────────────────────────────┤
│  AI Engine │ Blockchain │ Storage │ Network │ Physics   │
├─────────────────────────────────────────────────────────┤
│              EUSTRESS ENGINE (Bevy 0.18)                 │
└─────────────────────────────────────────────────────────┘
```

## Features

### Core Technology Pillars

1. **AI Legal Hotline** - 24/7 crisis support with GPT-4 and voice AI
2. **Sentinel Detection** - Preemptive risk detection using contrastive learning
3. **Identity Protection** - Multi-blockchain identity verification
4. **3D Simulation** - Immersive courtroom and training environments

### Justice-Eustress Crate Features

- `courtroom` - Courtroom environment components (default)
- `evidence` - Evidence visualization and chain of custody (default)
- `training` - Training scenario management
- `networking` - Multiplayer session support
- `full` - All features enabled

## Contributing

See [Conceptual/CONTRIBUTING.md](./Conceptual/CONTRIBUTING.md) for guidelines.

## License

MIT License - See [LICENSE](./LICENSE)

## Links

- [Justice Conceptual Framework](https://github.com/WeaveITMeta/Justice)
- [Eustress Engine](https://github.com/WeaveITMeta/EustressEngine)
- [Discord Community](https://discord.gg/gA3pspAAQV)
