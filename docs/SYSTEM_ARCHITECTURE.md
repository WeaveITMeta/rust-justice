# Justice System — Unified Rust Platform Architecture

## One Language. One Codebase. One Justice System.

> *The current justice system is fragmented across COBOL, Java, .NET, PHP, Python, and dozens of proprietary platforms that don't talk to each other. We unify under Rust — fast, safe, and built to last.*

---

## Why Rust

| Problem | How Rust Solves It |
|---|---|
| Memory safety bugs cause security vulnerabilities | Ownership model eliminates data races and buffer overflows at compile time |
| Performance — systems must handle millions of cases | Zero-cost abstractions; no GC; C-level speed |
| Reliability — downtime means delayed justice | Result error handling; no null pointers; if it compiles, it works |
| WASM — web interfaces must be fast and secure | First-class wasm32 target; Leptos for reactive web UIs |
| Concurrency — audio, AI, 3D, networking at once | tokio async; rayon parallelism; fearless concurrency |
| Longevity — government systems run for decades | No corporate owner; backwards compatibility; growing ecosystem |
| Auditability — public trust requires readable code | Strong types are self-documenting; clippy enforces idioms |

---

## High-Level Architecture

```
                          PUBLIC LAYER
  +---------------+  +---------------+  +---------------+
  |   Website     |  |  Mobile App   |  |  AI Hotline   |
  | (Leptos/WASM) |  |  (future)     |  | (Twilio+AI)   |
  +-------+-------+  +-------+-------+  +-------+-------+
          |                  |                   |
          v                  v                   v
                       API GATEWAY
              (justice-api - Axum - REST/GraphQL)
              JWT Auth - RBAC - Rate Limiting - TLS

                       SERVICE LAYER
  +------------+ +------------+ +------------+ +------------+
  |  Case Mgmt | |  Evidence  | |   Audio    | |  Agents    |
  |  Service   | |  Service   | |  Service   | |  Service   |
  +-----+------+ +-----+------+ +-----+------+ +-----+------+
        |              |              |              |
        +--------------+--------------+--------------+
                              |
                     MCP SERVER (eustress-mcp)
              Entity CRUD - Spaces - WebSocket - EEP Export

                       ENGINE LAYER
  +------------+ +------------+ +------------+ +------------+
  |  Eustress  | |  Eustress  | |  Justice   | |  Justice   |
  |  Engine    | |  Forge     | |  Eustress  | |  Core      |
  | (Bevy ECS) | | (Orchestr.)| | (Courtroom)| | (Types)    |
  +------------+ +------------+ +------------+ +------------+

                       DATA LAYER
  +------------+ +------------+ +------------+ +------------+
  | PostgreSQL | |   Redis    | |  Cardano   | |   IPFS     |
  | (Cases,    | | (Cache,    | | (Evidence  | | (Large     |
  |  Users)    | |  Sessions) | |  Chain)    | |  Files)    |
  +------------+ +------------+ +------------+ +------------+
```

---

## Crate Dependency Graph

```
justice-cli
  |-- justice-api
  |     |-- justice-core
  |     |-- justice-agents
  |     |     |-- justice-core
  |     |     +-- justice-mcp (client)
  |     |-- justice-audio
  |     |     |-- justice-core
  |     |     +-- justice-mcp (client)
  |     |-- justice-evidence
  |     |     |-- justice-core
  |     |     +-- justice-mcp (client)
  |     |-- justice-dashboard
  |     |     |-- justice-core
  |     |     +-- justice-mcp (client)
  |     +-- justice-map
  |           +-- justice-core
  |
  |-- justice-mcp (server)
  |     |-- eustress-mcp (upstream)
  |     +-- justice-core
  |
  |-- justice-usc
  |     +-- justice-core
  |
  +-- justice-eustress
        |-- justice-core
        +-- eustress (upstream, Bevy 0.18)

website (Leptos WASM - separate build target)
  +-- leptos, leptos_router, leptos_meta
```

---

## Crate Details

### justice-core

The foundational crate. Every other justice crate depends on it.

**Responsibilities:**
- Entity type definitions (Case, Participant, Court, Evidence, Statute)
- Error types via `thiserror`
- Trait definitions: `Searchable`, `Auditable`, `Exportable`, `Timestamped`
- TOML configuration loading via `serde` + `toml`
- Common utilities: hashing (SHA-256), UUID generation, timestamp formatting
- Constitutional compliance types and validation

**Key Types:**
```rust
// justice-core/src/entities.rs
pub struct Case { .. }
pub struct Participant { .. }
pub struct Court { .. }
pub struct Evidence { .. }
pub struct Statute { .. }
pub struct Ruling { .. }
pub struct Proceeding { .. }

// justice-core/src/traits.rs
pub trait Auditable {
    fn audit_log(&self) -> Vec<AuditEntry>;
    fn last_modified_by(&self) -> &str;
}

pub trait Searchable {
    fn search_text(&self) -> String;
    fn search_tags(&self) -> Vec<String>;
}

pub trait Exportable {
    fn to_json(&self) -> serde_json::Value;
    fn to_toml(&self) -> String;
    fn content_hash(&self) -> String;
}
```

**Dependencies:** `serde`, `toml`, `uuid`, `chrono`, `thiserror`, `sha2`

---

### justice-mcp

Wraps `eustress-mcp` with justice-specific entity classes, access control, and audit logging.

**Responsibilities:**
- Justice-specific MCP entity classes (Case, Evidence, Testimony, Contradiction, Rating)
- Role-based access control on MCP operations
- Audit logging for every create/update/delete
- WebSocket subscriptions scoped by role
- Case space lifecycle management

**Architecture:**
```
justice-mcp server
  |
  |-- /justice/case/create      POST   Create case space
  |-- /justice/case/:id         GET    Get case details
  |-- /justice/evidence/submit  POST   Submit evidence (hashes + stores)
  |-- /justice/testimony/store  POST   Store transcript segment
  |-- /justice/query            POST   Role-scoped entity query
  |-- /justice/subscribe        WS     Real-time updates (role-filtered)
  |
  +-- Delegates to eustress-mcp for entity CRUD
```

**Dependencies:** `eustress-mcp`, `justice-core`, `axum`, `tokio`, `jsonwebtoken`

---

### justice-cli

The developer and operator interface. Wraps all services into a unified command-line tool.

**Subcommands:**
```
justice-cli
  case        Create, list, info, open, export cases
  evidence    Submit, list, rate, custody, visualize evidence
  agents      Start, stop, list, status, findings for AI agents
  audio       Start capture, live transcript, export, replay
  sim         Launch Eustress, load evidence, record, snapshot
  court       List courts, info, map data
  usc         Search U.S. Code, cite, section lookup
  state       Configure state, list courts, import statutes
  config      View/edit ~/.justice/config.toml
  serve       Start all services (MCP + API + dashboard)
```

**Dependencies:** `clap` (derive), `justice-core`, `justice-mcp` (client), `reqwest`, `tokio`

---

### justice-agents

The AI agent framework. Defines the agent lifecycle, TOML configuration, and MCP communication.

**Agent Trait:**
```rust
#[async_trait]
pub trait JusticeAgent: Send + Sync {
    /// Agent identity
    fn name(&self) -> &str;
    fn role(&self) -> AgentRole;

    /// Lifecycle
    async fn initialize(&mut self, config: &AgentConfig, mcp: McpClient) -> Result<()>;
    async fn shutdown(&mut self) -> Result<()>;

    /// Core loop
    async fn observe(&self) -> Result<Vec<Observation>>;
    async fn reason(&self, observations: &[Observation]) -> Result<Vec<Finding>>;
    async fn act(&self, findings: &[Finding]) -> Result<Vec<Action>>;

    /// Constraints
    fn permissions(&self) -> &Permissions;
    fn is_advisory_only(&self) -> bool { true }
}
```

**Agent Roles:**
- `CaseAnalyst` — Cross-references evidence and testimony
- `ProsecutorAssistant` — Scoped to prosecution data
- `DefenseAssistant` — Scoped to defense data
- `JudicialAssistant` — Full read access, advisory rulings
- `JuryInformation` — Read-only, facts-only, no opinions

**Dependencies:** `justice-core`, `justice-mcp` (client), `tokio`, `reqwest` (for AI API calls), `serde`

---

### justice-audio

Multi-channel courtroom audio capture with real-time transcription.

**Pipeline:**
```
Microphones (6 channels)
  --> Audio Capture (cpal/rodio)
    --> Speaker Router (channel -> role mapping)
      --> Ultravox API (real-time ASR)
        --> Transcript Segments (speaker-tagged, timestamped)
          --> MCP Storage (Testimony entities)
          --> Agent Notification Bus
          --> Blockchain Timestamp (SHA-256 hash)
```

**Dependencies:** `justice-core`, `justice-mcp` (client), `cpal`, `tokio`, `reqwest`, `sha2`

---

### justice-evidence

Evidence ingestion, hashing, chain of custody, and blockchain anchoring.

**Pipeline:**
```
Evidence File/Stream
  --> SHA-256 Hash
    --> Metadata Extraction
      --> Classification (AI-assisted)
        --> MCP Storage (Evidence entity)
          --> Cardano Anchor (hash + metadata on-chain)
            --> IPFS Pin (large files)
```

**Chain of Custody Model:**
```rust
pub struct CustodyTransfer {
    pub from: String,
    pub to: String,
    pub timestamp: DateTime<Utc>,
    pub location: String,
    pub action: CustodyAction,
    pub evidence_hash: String,
    pub blockchain_tx: Option<String>,
    pub signature: Vec<u8>,
}
```

**Dependencies:** `justice-core`, `justice-mcp` (client), `sha2`, `reqwest`, `cardano-sdk` (or Blockfrost API)

---

### justice-dashboard

Real-time dashboard backend serving data to the judge's workstation UI.

**WebSocket Channels:**
```
/ws/case/:id/transcript    Live transcript feed
/ws/case/:id/findings      AI agent findings (contradictions, ratings)
/ws/case/:id/evidence      Evidence updates (new submissions, status changes)
/ws/case/:id/reasoning     Abductive reasoning tree updates
/ws/case/:id/status        Case phase and status changes
```

**REST Endpoints:**
```
GET  /dashboard/case/:id/summary        Case overview
GET  /dashboard/case/:id/evidence       Evidence list with ratings
GET  /dashboard/case/:id/contradictions Contradiction list
GET  /dashboard/case/:id/timeline       Event timeline
GET  /dashboard/case/:id/reasoning      Current reasoning tree
POST /dashboard/case/:id/annotate       Judge annotation
```

**Dependencies:** `justice-core`, `justice-mcp` (client), `axum`, `tokio-tungstenite`

---

### justice-map

Interactive court location data and geographic search.

**Data Model:**
```rust
pub struct CourtLocation {
    pub id: CourtId,
    pub name: String,
    pub court_type: CourtType,       // Federal, State, Municipal, etc.
    pub jurisdiction: Jurisdiction,
    pub address: Address,
    pub coordinates: (f64, f64),     // lat, lon
    pub phone: String,
    pub hours: BusinessHours,
    pub website: Option<String>,
    pub case_types: Vec<CaseType>,   // Criminal, Civil, Family, etc.
    pub services: Vec<CourtService>, // Filing, mediation, interpreter, etc.
    pub accessibility: AccessibilityInfo,
}
```

**Data Sources:**
- Federal courts: uscourts.gov (94 districts, 13 circuits, Supreme Court)
- State courts: State-specific judicial branch websites
- GeoJSON format for map rendering
- TOML configuration per state for court hierarchy

**Dependencies:** `justice-core`, `serde`, `geojson`

---

### justice-usc

U.S. Code parser, indexer, and semantic search.

**Data Pipeline:**
```
uscode.house.gov (XML)
  --> XML Parser (quick-xml)
    --> Structured Sections (Title, Chapter, Section, Subsection)
      --> Full-Text Index (tantivy)
        --> Embedding Generation (Nomic Atlas)
          --> Semantic Search Index
```

**Query Interface:**
```rust
pub trait LegalSearch {
    /// Full-text search
    fn search(&self, query: &str, limit: usize) -> Vec<StatuteResult>;
    
    /// Citation lookup: "18 U.S.C. 1343"
    fn cite(&self, citation: &str) -> Option<Statute>;
    
    /// Semantic search: "laws about wire fraud"
    fn semantic_search(&self, query: &str, limit: usize) -> Vec<StatuteResult>;
    
    /// AI plain-language explanation
    async fn explain(&self, citation: &str) -> String;
    
    /// Related statutes
    fn related(&self, citation: &str, limit: usize) -> Vec<StatuteResult>;
}
```

**Dependencies:** `justice-core`, `quick-xml`, `tantivy`, `reqwest` (Nomic API), `serde`

---

### justice-eustress (exists)

Already created. Provides courtroom simulation, evidence visualization, and training scenarios. See `crates/justice-eustress/README.md`.

---

### website (exists)

Already created. Leptos + Trunk + Tailwind public-facing website. See `website/README.md`.

---

## Data Flow: Case Lifecycle

```
1. CASE CREATION
   User/CLI --> justice-api --> justice-mcp --> Eustress Space created
                                           --> PostgreSQL record
                                           --> TOML config generated

2. EVIDENCE SUBMISSION  
   User/CLI --> justice-api --> justice-evidence --> SHA-256 hash
                                                --> justice-mcp (store)
                                                --> Cardano (anchor)
                                                --> IPFS (large files)
                                                --> justice-agents (notify)

3. TRIAL AUDIO
   Microphones --> justice-audio --> Ultravox (transcribe)
                                --> justice-mcp (store testimony)
                                --> justice-agents (analyze)
                                --> Cardano (timestamp hash)
                                --> justice-dashboard (live feed)

4. AI ANALYSIS
   justice-agents --> observe (query MCP for new data)
                  --> reason (cross-reference, detect contradictions)
                  --> act (store findings in MCP)
                  --> justice-dashboard (push updates)

5. 3D VISUALIZATION
   justice-eustress --> reads case TOML
                    --> builds courtroom from config
                    --> loads evidence as 3D entities
                    --> displays dashboard in-world
                    --> multiplayer sync via Lightyear

6. VERDICT & ARCHIVE
   justice-mcp --> record verdict entity
              --> Cardano (immutable case record)
              --> justice-api (export complete case)
              --> IPFS (archive all artifacts)
```

---

## Security Architecture

### Defense in Depth

```
Layer 1: Network
  - TLS 1.3 everywhere
  - Firewall rules per service
  - DDoS protection

Layer 2: Authentication
  - JWT tokens with short expiry
  - Multi-factor authentication for privileged roles
  - API key rotation

Layer 3: Authorization
  - Role-Based Access Control (RBAC)
  - Case-scoped permissions (judge sees all; attorneys see their side)
  - Jury agent is read-only, facts-only

Layer 4: Data Protection
  - AES-256-GCM encryption at rest
  - SHA-256 content hashing
  - Blockchain immutability for evidence
  - Attorney-client privilege exclusion zones

Layer 5: Audit
  - Every MCP operation logged with actor, timestamp, action
  - Audit logs are append-only, blockchain-anchored
  - 7-year retention per federal records requirements
```

### Constitutional Safeguards

| Amendment | Safeguard |
|---|---|
| **4th** (Search & Seizure) | Evidence must have documented legal basis for collection |
| **5th** (Due Process, Self-Incrimination) | AI is advisory only; cannot compel testimony; defendant audio opt-in |
| **6th** (Speedy Trial, Counsel, Confrontation) | System accelerates trials; AI assists both sides equally; no AI witness replacement |
| **7th** (Jury Trial) | Jury Information Agent provides facts only, never opinions or recommendations |
| **8th** (Cruel & Unusual) | Sentencing guidelines show ranges and alternatives; flag outliers |
| **14th** (Equal Protection) | Same tools for prosecution and defense; bias auditing on all AI models |

---

## Deployment Models

### Model A: Cloud-Hosted (Recommended for pilot)

```
GCP / AWS
  +-- Kubernetes Cluster
        +-- justice-api (3 replicas)
        +-- justice-mcp (3 replicas)
        +-- justice-agents (per-case scaling)
        +-- justice-audio (per-courtroom)
        +-- justice-dashboard (3 replicas)
        +-- PostgreSQL (managed, HA)
        +-- Redis (managed, HA)
        +-- Eustress Forge (GPU nodes for 3D)
```

### Model B: On-Premises (For courts with data sovereignty requirements)

```
Court Data Center
  +-- Docker Compose or bare metal
        +-- All services self-hosted
        +-- Air-gapped option available
        +-- Local PostgreSQL + Redis
        +-- Cardano node (optional, can use API)
```

### Model C: Hybrid (Production target)

```
Cloud: API gateway, AI services, blockchain anchoring
On-Prem: MCP server, audio capture, evidence storage, dashboards
Sync: Encrypted replication between cloud and on-prem
```

---

## Performance Targets

| Metric | Target | Rationale |
|---|---|---|
| API response time (p95) | < 100ms | Real-time dashboard updates |
| Audio transcription latency | < 2 seconds | Near-real-time for live proceedings |
| Evidence submission to blockchain | < 60 seconds | Must complete before next action |
| AI agent observation cycle | < 5 seconds | Timely contradiction detection |
| MCP entity creation | < 10ms | High-throughput evidence intake |
| 3D courtroom load time | < 5 seconds | Acceptable startup for sessions |
| Website page load (Lighthouse) | > 90 score | Accessibility and performance |
| Concurrent cases per instance | > 100 | Single cluster serves a county |
| Concurrent audio channels | > 50 | Multiple courtrooms simultaneously |

---

## Technology Choices

| Component | Choice | Why |
|---|---|---|
| **Language** | Rust | Safety, performance, WASM, longevity |
| **Web Framework** | Leptos | Rust-native, reactive, SSR + CSR |
| **API Framework** | Axum | Tokio-native, tower middleware, fast |
| **3D Engine** | Eustress (Bevy fork) | Rust ECS, MCP server, Forge orchestration |
| **Database** | PostgreSQL | Battle-tested, JSON support, full-text search |
| **Cache** | Redis | Sessions, real-time pub/sub, rate limiting |
| **Blockchain** | Cardano | Formal verification, low energy, identity layer |
| **AI/LLM** | GPT-4 / Grok 4 | Reasoning for agents; case law for research |
| **Transcription** | Ultravox | Real-time, high accuracy, speaker diarization |
| **Search** | Tantivy | Rust-native full-text search (Lucene equivalent) |
| **Embeddings** | Nomic Atlas | Semantic search across legal documents |
| **CLI** | Clap (derive) | Rust-native, auto-generated help, completions |
| **Config** | TOML | Human-readable, Rust-native serde support |
| **Build (WASM)** | Trunk | Leptos-native, asset pipeline, dev server |
| **CSS** | Tailwind CSS | Utility-first, purged for production, fast iteration |
| **Networking** | Lightyear | Bevy-native, QUIC, multiplayer sync |
| **Physics** | Avian3D | Bevy-native, 3D physics for evidence interaction |
| **Orchestration** | Eustress Forge | Game server orchestration, scaling |

---

## Integration Points

### External Systems (Future)

| System | Integration | Priority |
|---|---|---|
| **PACER** (federal court records) | Read-only API consumer | Phase 3 |
| **State court e-filing** | Adapter per state | Phase 9 |
| **NCIC** (criminal records) | Law enforcement only, air-gapped | Phase 9 |
| **DMV** (identity verification) | Read-only for identity protection | Phase 7 |
| **FBI CJIS** | Compliance standards, not direct integration | Phase 10 |
| **State bar associations** | Attorney verification | Phase 3 |

### Internal APIs

| API | Protocol | Auth | Purpose |
|---|---|---|---|
| justice-api | REST/GraphQL | JWT | Primary external API |
| justice-mcp | HTTP/WebSocket | JWT + API Key | Entity CRUD, real-time |
| justice-dashboard | WebSocket | JWT | Real-time dashboard updates |
| Eustress Forge | HTTP/WebSocket | API Key | 3D world orchestration |
| AI providers | HTTPS | Bearer token | LLM inference |
| Cardano | HTTPS | Project ID | Blockchain anchoring |
| Ultravox | HTTPS/WebSocket | Bearer token | Audio transcription |

---

## Open Source Architecture Principles

1. **Modularity** — Each crate has a single responsibility and clear API boundary
2. **No vendor lock-in** — AI providers, databases, and blockchains are abstracted behind traits
3. **Configuration over code** — TOML files define behavior; code provides the engine
4. **Offline-capable** — Core functionality works without internet; AI and blockchain are additive
5. **Transparent** — Every algorithm is open source; every decision is logged
6. **Testable** — Each crate has unit tests; integration tests cover cross-crate flows
7. **Documented** — Rustdoc on every public API; architecture docs in `docs/`
8. **Accessible** — Website meets WCAG 2.1 AA; CLI has `--help` everywhere
9. **Secure by default** — Encryption, auth, and audit logging are not optional
10. **Community-driven** — PRs welcome; governance is documented; decisions are public

---

*Document Version: 1.0.0*
*Last Updated: March 2026*
*Part of the Justice System Open-Source Framework*
