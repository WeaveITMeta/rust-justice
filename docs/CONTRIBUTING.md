# Contributing to the Justice System

## For Developers, Builders, and Dreamers

> *This project exists because people believe the justice system can be better. Whether you write Rust, study law, design interfaces, or simply care about fairness — there is a place for you here.*

---

## Quick Start

```bash
# Fork and clone
git clone https://github.com/YOUR_USERNAME/rust-justice.git
cd rust-justice

# Initialize submodules (upstream repos)
git submodule update --init --recursive

# Install Rust (if needed)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup target add wasm32-unknown-unknown

# Install tools
cargo install trunk
cargo install cargo-audit

# Build everything
cargo build --workspace

# Run tests
cargo test --workspace

# Run the website
cd website && bun install && trunk serve
```

---

## Who Can Contribute

### Developers

You write code. You solve problems. Here's where to start:

| Skill | Crate | First Issue |
|---|---|---|
| **Rust** | `justice-core`, `justice-cli`, `justice-mcp` | Core types, CLI commands, MCP endpoints |
| **Rust + WASM** | `website` | Leptos components, interactive map |
| **Rust + AI** | `justice-agents` | Agent implementations, prompt engineering |
| **Rust + Audio** | `justice-audio` | Audio capture, transcription integration |
| **Rust + Blockchain** | `justice-evidence` | Cardano anchoring, IPFS storage |
| **Rust + Bevy** | `justice-eustress` | 3D courtroom, evidence visualization |
| **Rust + Parsing** | `justice-usc` | XML parser, citation parser, search |
| **DevOps** | CI/CD | GitHub Actions, Docker, Kubernetes |
| **Testing** | All crates | Unit tests, integration tests, benchmarks |

**Start here:** Look for issues labeled `good-first-issue` or `help-wanted`.

### Legal Professionals

You understand the law. We need that understanding in the code:

- **Review TOML schemas** — Are court structures accurate? Are statute elements correct?
- **Validate AI output** — Do agent findings make legal sense?
- **Write test cases** — Real-world scenarios that the system should handle
- **Review constitutional compliance** — Does every feature respect due process?
- **Add state data** — Configure your state's court system and statutes
- **Draft content** — Plain-language legal explanations for the website

**Start here:** Review `docs/PHASES.md` Phase 0 (Constitutional Foundation) and `docs/USC_INTEGRATION.md`.

### Designers

You make things usable. Justice tools must be accessible to everyone:

- **Website UI/UX** — Navigation, court finder, legal resources
- **Dashboard design** — Judge's workstation, evidence ratings, transcript feed
- **3D courtroom** — Courtroom models, evidence display, participant indicators
- **Accessibility** — WCAG 2.1 AA compliance, screen reader testing
- **Icons and illustrations** — Court types, evidence types, process flows
- **Color systems** — Ensure color-blind safety, professional aesthetic

**Start here:** Open the website (`trunk serve`) and file issues for UX improvements.

### Researchers

You study justice systems. Your data drives better design:

- **Court data collection** — Gather accurate court locations and information
- **Effectiveness studies** — How do AI-assisted tools affect outcomes?
- **Bias auditing** — Test AI agents for disparate impact
- **Literature reviews** — What does existing research say about justice tech?
- **Cost-benefit analysis** — Quantify the value of automation

**Start here:** Review `Conceptual/11_Data_Infrastructure_and_Statistics/`.

### Advocates

You fight for justice. This platform amplifies that fight:

- **Content writing** — Know Your Rights guides, filing instructions
- **Community outreach** — Connect organizations to this project
- **Policy analysis** — How do these tools support legislation like the Take It Down Act?
- **Translation** — Make content accessible in Spanish and other languages
- **Testing** — Use the tools from a citizen's perspective; report friction

**Start here:** Review the website and ask: "Would a person in crisis find what they need?"

### Dreamers

You see what could be. That vision matters:

- **Feature proposals** — Open a Discussion with your idea
- **Use case stories** — Describe a scenario where this system helps someone
- **Architecture feedback** — Read the docs and ask "what if?"
- **Spread the word** — Star the repo, share it, talk about it

**Start here:** Read `docs/AUTOMATIONS.md` and imagine the possibilities.

---

## Contribution Workflow

### 1. Find or Create an Issue

```
Browse: github.com/WeaveITMeta/rust-justice/issues
Labels:
  good-first-issue    Easy entry points
  help-wanted         We need your help
  documentation       Writing and review
  bug                 Something broken
  enhancement         New feature
  legal-review        Needs legal expertise
  state-data          Court/statute data for a state
  accessibility       A11y improvements
```

### 2. Fork and Branch

```bash
# Fork on GitHub, then:
git clone https://github.com/YOUR_USERNAME/rust-justice.git
cd rust-justice
git remote add upstream https://github.com/WeaveITMeta/rust-justice.git
git checkout -b feature/your-feature-name
```

### 3. Make Your Changes

Follow these guidelines:

**Code:**
- Run `cargo fmt` before committing
- Run `cargo clippy` and fix all warnings
- Add tests for new functionality
- Follow existing code style and patterns
- Use 4-space indentation (no tabs)
- Document public APIs with `///` doc comments

**Documentation:**
- Use Markdown
- Include examples where helpful
- Keep language clear and accessible
- Cite sources for legal claims
- Use TOML for configuration examples

**Data (courts, statutes):**
- Follow existing TOML schemas exactly
- Include source URL for verification
- Add "last verified" date
- Double-check coordinates (lat/lon)

### 4. Test

```bash
# Run all tests
cargo test --workspace

# Run specific crate tests
cargo test -p justice-core
cargo test -p justice-eustress --all-features

# Run clippy
cargo clippy --workspace -- -D warnings

# Format check
cargo fmt --check
```

### 5. Submit a Pull Request

```bash
git add .
git commit -m "feat(justice-core): add Statute entity type

- Define Statute struct with title, section, text, penalties
- Add CitationParser for standard legal citation formats
- Include unit tests for parsing edge cases
- Update docs with usage examples

Closes #42"
```

**Commit message format:**
```
type(scope): short description

- Bullet points explaining what and why
- Reference issues with "Closes #N" or "Relates to #N"
```

**Types:** `feat`, `fix`, `docs`, `test`, `refactor`, `ci`, `chore`

**Scopes:** Crate names (`justice-core`, `justice-cli`, `website`, etc.) or `docs`, `ci`

### 6. Code Review

- Every PR needs at least 1 approval
- Legal-sensitive PRs need legal review
- State data PRs need source verification
- CI must pass (fmt, clippy, test)
- Be responsive to feedback; iterate quickly

---

## Development Setup

### Prerequisites

| Tool | Version | Purpose |
|---|---|---|
| Rust | Latest stable | Core language |
| `wasm32-unknown-unknown` | (rustup target) | WASM compilation |
| Trunk | Latest | Website build tool |
| Bun | Latest | Package manager + Tailwind CSS build |
| Git | 2.30+ | Version control + submodules |

### Optional (for specific crates)

| Tool | Purpose |
|---|---|
| Docker | Container builds, local services |
| PostgreSQL 16 | Local database development |
| Redis 7 | Local cache/session development |
| `cargo-watch` | Auto-rebuild on file changes |
| `cargo-nextest` | Faster test runner |

### IDE Setup

**VS Code / Windsurf:**
```json
{
  "rust-analyzer.check.command": "clippy",
  "rust-analyzer.cargo.features": "all",
  "[rust]": {
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "rust-lang.rust-analyzer"
  },
  "css.validate": false  // Tailwind @apply directives
}
```

---

## Architecture Guide for New Contributors

### Where Things Live

```
rust-justice/
  docs/                  # You are here. Architecture, phases, specs.
  crates/
    justice-eustress/    # 3D simulation integration (exists)
    justice-core/        # Core types (to be created)
    justice-mcp/         # MCP server (to be created)
    justice-cli/         # CLI tool (to be created)
    justice-agents/      # AI agents (to be created)
    justice-audio/       # Audio pipeline (to be created)
    justice-evidence/    # Evidence + blockchain (to be created)
    justice-api/         # REST/GraphQL API (to be created)
    justice-dashboard/   # Dashboard backend (to be created)
    justice-map/         # Court map data (to be created)
    justice-usc/         # U.S. Code parser (to be created)
  website/               # Leptos + Tailwind public site (exists)
  Conceptual/            # Upstream: Justice taxonomy (read-only)
  Eustress/              # Upstream: Eustress Engine (read-only)
```

### Key Design Principles

1. **Everything is TOML** — Configuration, case definitions, court data, agent configs
2. **MCP is the backbone** — All entities live in MCP; services communicate through it
3. **AI is advisory** — Humans make every decision; AI surfaces information
4. **Both sides get equal tools** — Prosecution and defense have equivalent capabilities
5. **Audit everything** — Every action is logged, timestamped, and attributable
6. **Upstream stays separate** — Never modify `Conceptual/` or `Eustress/` directly

### How to Add a New Crate

```bash
# 1. Create the crate
mkdir -p crates/justice-new
cd crates/justice-new
cargo init --lib --name justice-new

# 2. Add to workspace Cargo.toml
# Add "crates/justice-new" to workspace members

# 3. Add common dependencies
# In crates/justice-new/Cargo.toml:
# [dependencies]
# justice-core = { path = "../justice-core" }
# serde = { workspace = true }

# 4. Create module structure
# src/lib.rs, src/types.rs, src/error.rs, etc.

# 5. Add tests
# tests/integration_test.rs

# 6. Document
# README.md with usage examples
```

### How to Add a State

```bash
# 1. Create state directory
mkdir -p states/california

# 2. Copy template
cp templates/state.toml states/california/state.toml

# 3. Fill in court data
# Edit state.toml with accurate court information
# Add court locations with coordinates
# Add links to state statutes

# 4. Add GeoJSON
# Create states/california/courts.geojson from TOML data

# 5. Add tests
# Validate TOML schema
# Verify coordinates are in the correct state

# 6. Submit PR with sources
# Include URLs where you verified each data point
```

---

## Code of Conduct

### Our Pledge

We are committed to making participation in this project a welcoming, inclusive, and harassment-free experience for everyone, regardless of age, body size, disability, ethnicity, sex characteristics, gender identity, level of experience, education, socio-economic status, nationality, personal appearance, race, religion, or sexual identity and orientation.

### Our Standards

**Expected behavior:**
- Use welcoming and inclusive language
- Be respectful of differing viewpoints and experiences
- Gracefully accept constructive criticism
- Focus on what is best for the community and for justice
- Show empathy towards other community members

**Unacceptable behavior:**
- Trolling, insulting/derogatory comments, and personal attacks
- Public or private harassment
- Publishing others' private information without consent
- Other conduct which could reasonably be considered inappropriate

### Enforcement

Instances of abusive, harassing, or otherwise unacceptable behavior may be reported to the project maintainers. All complaints will be reviewed and investigated promptly and fairly.

---

## Recognition

We believe in recognizing every contribution:

- **All Contributors** bot tracks contributions of all types
- **Monthly shoutouts** in project updates
- **Core Contributor** status for sustained, significant contributions
- **Legal Review Board** membership for qualified legal professionals
- **State Champion** recognition for completing a state's court data

---

## Communication

| Channel | Purpose |
|---|---|
| **GitHub Issues** | Bug reports, feature requests, tasks |
| **GitHub Discussions** | Questions, ideas, general conversation |
| **Discord** | Real-time chat, pair programming, community |
| **Pull Requests** | Code review, collaboration |

**Discord:** [Metaverse Bill](https://discord.gg/gA3pspAAQV)

---

## License

By contributing, you agree that your contributions will be licensed under the **MIT License**.

All contributions must:
- Be your original work (or properly attributed)
- Not include proprietary or copyrighted code
- Respect the ethical use requirements in the LICENSE file

---

## FAQ

**Q: I'm not a programmer. Can I still contribute?**
A: Absolutely. We need legal reviewers, court data collectors, content writers, accessibility testers, translators, and advocates. See the roles above.

**Q: I know a different programming language. Is Rust required?**
A: The core system is Rust. However, documentation, data collection, legal review, and testing don't require Rust knowledge. If you want to write code, learning Rust is a great investment — the [Rust Book](https://doc.rust-lang.org/book/) is excellent.

**Q: How do I add my state's court data?**
A: See "How to Add a State" above. Start with your state's supreme court and trial courts. We provide templates.

**Q: Can I use this commercially?**
A: Yes. MIT license. We encourage commercial deployment that improves justice access.

**Q: Is this affiliated with any government agency?**
A: No. This is an independent, community-driven open source project. We aim to build tools that government agencies can adopt.

**Q: How do I report a security vulnerability?**
A: Do NOT open a public issue. Email security concerns to the maintainers directly. See SECURITY.md.

---

## Thank You

Every contribution — a typo fix, a court address, a new crate, a legal review — moves us closer to a justice system that works for everyone. 

The quality of justice in a society reflects the quality of its people's efforts to improve it. Thank you for being part of that effort.

---

*Document Version: 1.0.0*
*Last Updated: March 2026*
*Part of the Justice System Open-Source Framework*
