# Justice-Eustress

Justice System integration crate for the Eustress Engine - courtroom simulation, evidence visualization, and justice-centric 3D applications.

## Overview

This crate provides justice-specific components, systems, and resources for building 3D justice system simulations using the Eustress Engine (a Bevy fork).

**Key Design Principle**: This crate is intentionally separate from the Eustress Engine to enable clean upstream updates while maintaining justice-specific functionality.

## Features

| Feature | Description | Default |
|---------|-------------|---------|
| `courtroom` | Courtroom environments and proceedings | ✓ |
| `evidence` | Evidence management and visualization | ✓ |
| `training` | Training scenario management | |
| `networking` | Multiplayer courtroom sessions | |
| `full` | All features enabled | |

## Usage

```toml
[dependencies]
justice-eustress = "0.1"

# With all features
justice-eustress = { version = "0.1", features = ["full"] }
```

```rust
use justice_eustress::prelude::*;

// Create a federal district courtroom
let config = courtroom::presets::federal_district_court();
let mut session = CourtroomSession::new(config);

// Create a criminal case
let mut case = Case::new(
    "2026-CR-001",
    CaseType::Criminal,
    "United States v. Example"
);

// Add participants
case.add_participant(Participant::new("Hon. Smith", CourtroomRole::Judge));
case.add_participant(Participant::new("ADA Johnson", CourtroomRole::Prosecutor));
case.add_participant(Participant::new("Ms. Williams", CourtroomRole::DefenseAttorney));

// Start the session
session.start_session(case);

// Advance through phases
while session.advance_phase() {
    println!("Phase: {:?}", session.phase);
}
```

## Modules

### `courtroom`
Courtroom configuration, session management, and proceeding phases.

### `evidence`
Evidence types, chain of custody tracking, and 3D visualization configuration.

### `entities`
Core entity definitions: participants, cases, roles.

### `events`
Event types for courtroom actions: objections, rulings, verdicts.

### `resources`
Singleton resources: registries, configuration, simulation time.

### `training` (feature: `training`)
Training scenarios, learning objectives, and progress tracking.

### `networking` (feature: `networking`)
Multiplayer support: lobbies, state sync, network messages.

## License

MIT
