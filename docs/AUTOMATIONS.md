# Justice System Automations

## AI Agents + MCP Servers + APIs + CLI Tools + Eustress Integration

> *Automating the tedious. Amplifying the human. Delivering justice at the speed it deserves.*

---

## Executive Summary

The U.S. Justice System processes over **100 million cases annually** across federal, state, and municipal courts. The current infrastructure is fragmented across dozens of programming languages, incompatible databases, and paper-based workflows that create bottlenecks at every stage — from filing to verdict.

This document describes a unified automation architecture built in **Rust**, powered by **AI Agents** communicating through **MCP (Model Control Protocol) Servers**, orchestrated via **APIs and CLI tools**, and visualized through **Eustress Engine** — a Bevy-based 3D simulation platform.

The result: a justice system where every participant — judge, prosecutor, defense attorney, jury member — has AI-augmented tools that surface contradictions, rate evidence, track chain of custody, and support better **abductive reasoning** for ultimate judgment.

---

## Architecture Overview

```
┌──────────────────────────────────────────────────────────────────────┐
│                        JUSTICE AUTOMATION LAYER                      │
├──────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐              │
│  │  AI Agents   │  │  AI Agents   │  │  AI Agents   │              │
│  │ (Prosecutor) │  │  (Defense)   │  │   (Judge)    │              │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘              │
│         │                 │                  │                       │
│         ▼                 ▼                  ▼                       │
│  ┌─────────────────────────────────────────────────────┐            │
│  │              MCP SERVER (eustress-mcp)               │            │
│  │  HTTP/WebSocket APIs · Entity CRUD · Batch Ops      │            │
│  │  Rate Limiting · Auth (JWT) · CORS · Export (EEP)   │            │
│  └──────────────────────┬──────────────────────────────┘            │
│                         │                                            │
│         ┌───────────────┼───────────────┐                           │
│         ▼               ▼               ▼                           │
│  ┌────────────┐  ┌────────────┐  ┌────────────┐                    │
│  │  Eustress  │  │  Justice   │  │  External  │                    │
│  │   Forge    │  │   APIs     │  │   APIs     │                    │
│  │ (3D World) │  │ (Case Mgmt)│  │ (AI/Legal) │                    │
│  └────────────┘  └────────────┘  └────────────┘                    │
│                                                                      │
├──────────────────────────────────────────────────────────────────────┤
│                     EUSTRESS ENGINE (Bevy 0.18)                      │
│  3D Courtroom · Evidence Visualization · Physics · Networking       │
└──────────────────────────────────────────────────────────────────────┘
```

---

## 1. AI Agents

### What They Are

AI Agents are autonomous software entities that observe, reason, and act within the justice system. Each agent specializes in a role and communicates with the MCP Server to read case data, analyze evidence, detect contradictions, and present findings.

### Agent Roles

#### 1.1 Case Analyst Agent

Monitors all case data in real-time. Identifies patterns, contradictions, and gaps.

```toml
# agents/case_analyst.toml

[agent]
name = "case-analyst"
role = "analysis"
model = "gpt-4"
temperature = 0.2  # Low creativity, high precision

[agent.capabilities]
evidence_rating = true
contradiction_detection = true
timeline_construction = true
witness_consistency = true

[agent.mcp]
server = "http://localhost:8090"
space_id = "case-2026-CR-001"
poll_interval_secs = 5

[agent.triggers]
on_new_evidence = "analyze_and_rate"
on_testimony = "check_consistency"
on_phase_change = "generate_summary"
```

#### 1.2 Prosecutor Assistant Agent

Supports the prosecution by organizing evidence, suggesting examination questions, and flagging weaknesses in the case.

```toml
# agents/prosecutor_assistant.toml

[agent]
name = "prosecutor-assistant"
role = "prosecution-support"
model = "gpt-4"
temperature = 0.3

[agent.capabilities]
evidence_organization = true
question_suggestion = true
case_law_research = true
weakness_identification = true

[agent.audio]
enabled = true
source = "prosecution-mic"
transcription = "ultravox"
real_time = true

[agent.mcp]
server = "http://localhost:8090"
space_id = "case-2026-CR-001"
entity_tags = ["prosecution", "evidence", "witness"]
```

#### 1.3 Defense Assistant Agent

Supports the defense by identifying exculpatory evidence, inconsistencies in prosecution arguments, and relevant precedents.

```toml
# agents/defense_assistant.toml

[agent]
name = "defense-assistant"
role = "defense-support"
model = "gpt-4"
temperature = 0.3

[agent.capabilities]
exculpatory_search = true
prosecution_weakness = true
precedent_research = true
rights_monitoring = true

[agent.audio]
enabled = true
source = "defense-mic"
transcription = "ultravox"
real_time = true

[agent.mcp]
server = "http://localhost:8090"
space_id = "case-2026-CR-001"
entity_tags = ["defense", "evidence", "witness"]
```

#### 1.4 Judicial Assistant Agent

Supports the judge with legal research, procedural compliance, sentencing guidelines, and real-time objection analysis.

```toml
# agents/judicial_assistant.toml

[agent]
name = "judicial-assistant"
role = "judicial-support"
model = "gpt-4"
temperature = 0.1  # Highest precision

[agent.capabilities]
objection_analysis = true
sentencing_guidelines = true
procedural_compliance = true
jury_instruction_drafting = true
constitutional_review = true

[agent.audio]
enabled = true
sources = ["judge-mic", "courtroom-ambient"]
transcription = "ultravox"
real_time = true

[agent.mcp]
server = "http://localhost:8090"
space_id = "case-2026-CR-001"
entity_tags = ["judicial", "ruling", "procedure"]
```

#### 1.5 Jury Information Agent

Provides the jury with organized evidence summaries, timeline visualizations, and exhibits — never opinions. Pure information delivery.

```toml
# agents/jury_information.toml

[agent]
name = "jury-information"
role = "jury-support"
model = "gpt-4"
temperature = 0.0  # Zero creativity — facts only

[agent.capabilities]
evidence_summary = true
timeline_visualization = true
exhibit_retrieval = true
legal_term_definitions = true

[agent.constraints]
no_opinions = true
no_recommendations = true
no_verdict_suggestions = true
factual_only = true

[agent.mcp]
server = "http://localhost:8090"
space_id = "case-2026-CR-001"
entity_tags = ["exhibit", "timeline", "summary"]
read_only = true  # Jury agent cannot modify case data
```

---

## 2. MCP Server Integration

### How Eustress MCP Powers Justice

The Eustress MCP Server (`eustress-mcp`) provides the communication backbone. Originally designed for AI-controllable 3D worlds, it maps perfectly to justice system automation:

| MCP Concept | Justice Application |
|---|---|
| **Space** | A case (universe) containing all entities |
| **Entity** | Evidence, testimony, documents, participants |
| **Properties** | Metadata: timestamps, custody chain, ratings |
| **Tags** | Classification: `prosecution`, `defense`, `exhibit-A` |
| **AI flag** | Mark entities for AI agent processing |
| **EEP Export** | Audit trail for blockchain evidence preservation |

### Creating a Case Universe

When a new case is filed, the system creates an Eustress space:

```bash
# CLI: Create a new case universe
justice-cli case create \
  --number "2026-CR-001" \
  --type criminal \
  --title "State of Arizona v. Example" \
  --court "Maricopa County Superior Court" \
  --judge "Hon. Smith"
```

This translates to MCP calls:

```json
POST /mcp/create
{
  "space_id": "case-2026-CR-001",
  "class": "CaseEnvironment",
  "name": "State of Arizona v. Example",
  "properties": {
    "case_number": "2026-CR-001",
    "case_type": "criminal",
    "court": "Maricopa County Superior Court",
    "judge": "Hon. Smith",
    "filed_date": "2026-03-19T00:00:00Z",
    "status": "pre-trial"
  },
  "tags": ["active", "criminal", "arizona", "maricopa"],
  "ai": true
}
```

### Evidence Submission via MCP

```json
POST /mcp/create
{
  "space_id": "case-2026-CR-001",
  "class": "Evidence",
  "name": "Exhibit A - Surveillance Footage",
  "properties": {
    "exhibit_number": "A",
    "type": "digital",
    "format": "video/mp4",
    "duration_seconds": 3600,
    "hash_sha256": "a1b2c3...",
    "chain_of_custody": [
      {
        "handler": "Det. Johnson",
        "action": "collected",
        "location": "123 Main St",
        "timestamp": "2026-01-15T14:30:00Z"
      }
    ],
    "ai_rating": null,
    "contradictions": []
  },
  "tags": ["prosecution", "digital", "video", "exhibit-a"],
  "ai": true
}
```

### Real-Time Query: AI Agent Checking Contradictions

```json
POST /mcp/query
{
  "space_id": "case-2026-CR-001",
  "classes": ["Evidence", "Testimony"],
  "tags": ["prosecution"],
  "ai_only": true,
  "limit": 500
}
```

The Case Analyst Agent processes the response, cross-references testimony timestamps with evidence timestamps, and flags contradictions:

```json
POST /mcp/create
{
  "space_id": "case-2026-CR-001",
  "class": "Contradiction",
  "name": "Timeline conflict: Witness B vs Exhibit A",
  "properties": {
    "severity": "high",
    "description": "Witness B claims defendant was at location X at 14:30, but Exhibit A surveillance shows defendant at location Y at 14:25. Travel time between X and Y is 45 minutes.",
    "entities_involved": ["witness-b-testimony", "exhibit-a"],
    "confidence": 0.94,
    "detected_by": "case-analyst-agent",
    "detected_at": "2026-03-19T10:15:00Z"
  },
  "tags": ["contradiction", "timeline", "high-severity"],
  "ai": true
}
```

---

## 3. Live Audio Integration

### Architecture

```
┌─────────────────────────────────────────────────────┐
│                   COURTROOM AUDIO                    │
├─────────────────────────────────────────────────────┤
│                                                      │
│  🎙️ Judge Mic ──────┐                               │
│  🎙️ Prosecutor Mic ─┤                               │
│  🎙️ Defense Mic ────┼──→ Audio Mixer / Router       │
│  🎙️ Witness Mic ────┤         │                     │
│  🎙️ Ambient Mic ────┘         │                     │
│                                ▼                     │
│                     ┌──────────────────┐             │
│                     │  Ultravox + GPT-4│             │
│                     │  Real-Time ASR   │             │
│                     └────────┬─────────┘             │
│                              │                       │
│                    ┌─────────▼──────────┐            │
│                    │ Transcript Stream  │            │
│                    │ (speaker-tagged)   │            │
│                    └─────────┬──────────┘            │
│                              │                       │
│              ┌───────────────┼───────────────┐       │
│              ▼               ▼               ▼       │
│     ┌──────────────┐ ┌────────────┐ ┌────────────┐  │
│     │ MCP Server   │ │ AI Agents  │ │ Blockchain │  │
│     │ (store as    │ │ (real-time │ │ (evidence  │  │
│     │  testimony)  │ │  analysis) │ │  preserve) │  │
│     └──────────────┘ └────────────┘ └────────────┘  │
│                                                      │
└─────────────────────────────────────────────────────┘
```

### Audio Processing TOML Configuration

```toml
# config/audio.toml

[audio]
sample_rate = 48000
channels = 6  # One per mic source
format = "f32le"
buffer_size_ms = 100

[audio.sources]
judge = { device = "mic-judge", channel = 0, role = "judge" }
prosecutor = { device = "mic-prosecutor", channel = 1, role = "prosecutor" }
defense = { device = "mic-defense", channel = 2, role = "defense" }
witness = { device = "mic-witness", channel = 3, role = "witness" }
defendant = { device = "mic-defendant", channel = 4, role = "defendant" }
ambient = { device = "mic-ambient", channel = 5, role = "ambient" }

[transcription]
engine = "ultravox"
model = "ultravox-large-v2"
language = "en"
speaker_diarization = true
real_time = true
punctuation = true
profanity_filter = false  # Legal proceedings require exact transcription

[transcription.export]
format = "json"
include_timestamps = true
include_confidence = true
include_speaker_id = true

[analysis]
engine = "gpt-4"
check_contradictions = true
rate_evidence_relevance = true
flag_objectionable_content = true
track_emotional_tone = true
```

### How Audio Feeds the System

1. **Capture**: Each participant's mic feeds a dedicated audio channel
2. **Transcribe**: Ultravox provides real-time, speaker-tagged transcription
3. **Store**: Transcripts are stored as MCP entities with full metadata
4. **Analyze**: AI agents receive transcript streams and cross-reference against evidence
5. **Preserve**: Blockchain timestamping for chain of custody

```rust
// Pseudocode: Audio processing pipeline
async fn process_audio_stream(
    audio_rx: AudioReceiver,
    mcp_client: McpClient,
    agents: Vec<AgentHandle>,
) {
    while let Some(segment) = audio_rx.recv().await {
        // Transcribe with speaker identification
        let transcript = ultravox::transcribe(&segment).await;

        // Store in MCP as testimony entity
        let entity = mcp_client.create(CreateEntity {
            space_id: case_id.clone(),
            class: "Testimony".into(),
            name: format!("{} - {}", transcript.speaker, transcript.timestamp),
            properties: serde_json::json!({
                "speaker": transcript.speaker,
                "role": transcript.role,
                "text": transcript.text,
                "timestamp": transcript.timestamp,
                "confidence": transcript.confidence,
                "audio_hash": segment.hash(),
            }),
            tags: vec![transcript.role.clone(), "testimony".into()],
            ai: true,
        }).await;

        // Notify all agents
        for agent in &agents {
            agent.notify(AgentEvent::NewTestimony(entity.clone())).await;
        }
    }
}
```

---

## 4. CLI Tools

### `justice-cli` — The Justice System Command Line

A Rust-built CLI tool that wraps MCP Server calls, Eustress Forge operations, and agent management into a unified interface.

```bash
# Install
cargo install justice-cli
```

### Case Management

```bash
# Create a new case
justice-cli case create --number "2026-CR-001" --type criminal \
  --title "State of Arizona v. Example" --court "maricopa-superior"

# List active cases
justice-cli case list --status active --court "maricopa-superior"

# Get case details
justice-cli case info "2026-CR-001"

# Open case in Eustress (launches 3D environment)
justice-cli case open "2026-CR-001" --with-eustress

# Export case data
justice-cli case export "2026-CR-001" --format json --output ./exports/
```

### Evidence Management

```bash
# Submit evidence
justice-cli evidence submit "2026-CR-001" \
  --exhibit "A" \
  --type digital \
  --file ./surveillance.mp4 \
  --collected-by "Det. Johnson" \
  --location "123 Main St" \
  --blockchain-preserve

# List evidence for a case
justice-cli evidence list "2026-CR-001" --side prosecution

# Rate evidence (AI-assisted)
justice-cli evidence rate "2026-CR-001" --exhibit "A" --agent case-analyst

# Check chain of custody
justice-cli evidence custody "2026-CR-001" --exhibit "A"

# Visualize evidence in Eustress
justice-cli evidence visualize "2026-CR-001" --exhibit "A" --3d
```

### Agent Management

```bash
# Start agents for a case
justice-cli agents start "2026-CR-001" --config agents/

# List running agents
justice-cli agents list

# Get agent status
justice-cli agents status case-analyst

# View agent findings
justice-cli agents findings "2026-CR-001" --type contradictions

# Stop all agents
justice-cli agents stop "2026-CR-001"
```

### Audio Management

```bash
# Start audio capture
justice-cli audio start "2026-CR-001" --config config/audio.toml

# View live transcript
justice-cli audio transcript "2026-CR-001" --live

# Export transcript
justice-cli audio export "2026-CR-001" --format pdf --output ./transcripts/

# Replay audio segment
justice-cli audio replay "2026-CR-001" --from "14:30:00" --to "14:35:00"
```

### Simulation Management

```bash
# Launch Eustress courtroom
justice-cli sim launch "2026-CR-001" --courtroom federal-district

# Load evidence into 3D space
justice-cli sim load-evidence "2026-CR-001" --all

# Start recording session
justice-cli sim record "2026-CR-001" --start

# Take snapshot
justice-cli sim snapshot "2026-CR-001" --name "closing-arguments"
```

---

## 5. Eustress Integration

### The Universe-as-a-Case Model

Every case in the justice system maps to an **Eustress Universe** — a persistent 3D space containing:

```
Case Universe: "2026-CR-001"
├── Courtroom Environment
│   ├── Judge's Bench
│   ├── Prosecution Table
│   ├── Defense Table
│   ├── Witness Stand
│   ├── Jury Box (12 seats)
│   ├── Gallery
│   └── Court Reporter Station
│
├── Evidence Room
│   ├── Physical Evidence (3D models)
│   ├── Digital Evidence (screens, projections)
│   ├── Documentary Evidence (floating documents)
│   └── Timeline Wall (interactive chronology)
│
├── Simulation Space
│   ├── Crime Scene Reconstruction
│   ├── Witness Perspective Views
│   └── Expert Demonstration Area
│
├── AI Dashboard
│   ├── Contradiction Panel
│   ├── Evidence Rating Board
│   ├── Live Transcript Feed
│   ├── Sentiment Analysis
│   └── Abductive Reasoning Tree
│
└── Participant Spaces
    ├── Judge's Chambers (private AI assistant)
    ├── Prosecution War Room (private analysis)
    ├── Defense War Room (private analysis)
    └── Jury Deliberation Room
```

### TOML System Definitions

The entire case environment is defined in TOML files that Eustress reads to construct the 3D world:

```toml
# cases/2026-CR-001/case.toml

[case]
number = "2026-CR-001"
type = "criminal"
title = "State of Arizona v. Example"
status = "in-trial"
filed = "2026-01-20"
court = "maricopa-county-superior"

[case.judge]
name = "Hon. Patricia Smith"
courtroom = "Room 301"

[case.prosecution]
lead = "ADA Michael Johnson"
office = "Maricopa County Attorney"

[case.defense]
lead = "Sarah Williams, Esq."
firm = "Williams & Associates"

[case.charges]
count_1 = { statute = "ARS 13-1105", description = "First Degree Murder", class = "Class 1 Felony" }
count_2 = { statute = "ARS 13-1204", description = "Aggravated Assault", class = "Class 3 Felony" }
```

```toml
# cases/2026-CR-001/courtroom.toml

[courtroom]
type = "federal-district"
preset = "standard"

[courtroom.environment]
lighting = "formal"
time_of_day = "morning"
ambient_audio = false

[courtroom.layout]
jury_size = 12
gallery_capacity = 50
has_witness_stand = true
has_court_reporter = true
has_bailiff = true

[courtroom.displays]
evidence_screen = { position = [0, 3, -8], size = [4, 3] }
timeline_wall = { position = [-10, 2, -5], size = [8, 4] }
transcript_feed = { position = [10, 2, -5], size = [3, 6] }
```

```toml
# cases/2026-CR-001/agents.toml

[agents]
auto_start = true
mcp_server = "http://localhost:8090"

[agents.case_analyst]
enabled = true
config = "agents/case_analyst.toml"
priority = "high"

[agents.prosecutor_assistant]
enabled = true
config = "agents/prosecutor_assistant.toml"
access = "prosecution-only"

[agents.defense_assistant]
enabled = true
config = "agents/defense_assistant.toml"
access = "defense-only"

[agents.judicial_assistant]
enabled = true
config = "agents/judicial_assistant.toml"
access = "judge-only"

[agents.jury_information]
enabled = true
config = "agents/jury_information.toml"
access = "jury-only"
constraints = "read-only,factual-only"
```

```toml
# cases/2026-CR-001/audio.toml

[audio]
enabled = true
sources = ["judge", "prosecutor", "defense", "witness", "defendant"]

[audio.transcription]
engine = "ultravox"
real_time = true
store_in_mcp = true
blockchain_timestamp = true

[audio.analysis]
contradiction_detection = true
emotional_tone_tracking = true
objection_flagging = true
```

### The Judge's Dashboard

When a judge opens their workstation, they see:

```
┌──────────────────────────────────────────────────────────────────┐
│  JUSTICE DASHBOARD — Case 2026-CR-001                    [⚖️]    │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌─ CASE STATUS ──────────────────┐ ┌─ AI FINDINGS ──────────┐  │
│  │ Phase: Prosecution Case        │ │ ⚠️  3 Contradictions    │  │
│  │ Day: 4 of estimated 12        │ │ 📊 14 Evidence Items    │  │
│  │ Witnesses: 6/11 examined      │ │ 📝 47 Testimony Segs   │  │
│  │ Exhibits: A-N admitted        │ │ 🔍 2 New Findings       │  │
│  └────────────────────────────────┘ └────────────────────────┘  │
│                                                                  │
│  ┌─ LIVE TRANSCRIPT ─────────────────────────────────────────┐  │
│  │ [14:32:15] PROSECUTOR: And what did you observe at that   │  │
│  │            time?                                           │  │
│  │ [14:32:22] WITNESS 3:  I saw the defendant exit the       │  │
│  │            building around 2:30 PM.                        │  │
│  │ ⚠️ AI NOTE: Witness 1 testified defendant was at          │  │
│  │    location B at 2:25 PM (45 min travel time)             │  │
│  └───────────────────────────────────────────────────────────┘  │
│                                                                  │
│  ┌─ EVIDENCE RATINGS ──────────┐ ┌─ EUSTRESS 3D VIEW ───────┐  │
│  │ Exhibit A: ████████░░ 8.2   │ │                           │  │
│  │ Exhibit B: ██████░░░░ 6.1   │ │  [Live 3D Courtroom]     │  │
│  │ Exhibit C: █████████░ 9.0   │ │                           │  │
│  │ Exhibit D: ███░░░░░░░ 3.4   │ │  Evidence Exhibit A      │  │
│  │                              │ │  currently displayed      │  │
│  └──────────────────────────────┘ └───────────────────────────┘  │
│                                                                  │
│  ┌─ ABDUCTIVE REASONING TREE ────────────────────────────────┐  │
│  │                                                            │  │
│  │  Hypothesis A (Prosecution): 72% evidence support          │  │
│  │  ├── Supporting: Exhibits A, C, E, G (strong)              │  │
│  │  ├── Neutral: Exhibits B, F, H                             │  │
│  │  └── Contradicting: Witness 1 vs Witness 3 timeline        │  │
│  │                                                            │  │
│  │  Hypothesis B (Defense): 58% evidence support              │  │
│  │  ├── Supporting: Exhibits D, I, J                          │  │
│  │  ├── Neutral: Exhibits B, F                                │  │
│  │  └── Weaknesses: No alibi corroboration                    │  │
│  │                                                            │  │
│  └────────────────────────────────────────────────────────────┘  │
│                                                                  │
│  [Sentencing Guidelines] [Case Law Search] [Jury Instructions]   │
└──────────────────────────────────────────────────────────────────┘
```

---

## 6. TOML-Driven System Creation

### Philosophy

Every aspect of the justice automation system is **declarative** and defined in TOML. This means:

- **Non-programmers** can configure systems by editing text files
- **Version control** tracks every change to system configuration
- **AI agents** can read and modify TOML to adapt systems dynamically
- **Reproducibility** — any case can be reconstructed from its TOML definitions
- **Auditing** — every configuration change is logged and attributable

### System Definition Schema

```toml
# systems/evidence_rating.toml

[system]
name = "evidence-rating"
version = "1.0.0"
description = "AI-powered evidence rating and relevance scoring"

[system.inputs]
evidence = { source = "mcp", query = "class=Evidence", watch = true }
testimony = { source = "mcp", query = "class=Testimony", watch = true }
case_law = { source = "api", endpoint = "/case-law/relevant", cache = true }

[system.processing]
engine = "gpt-4"
method = "structured-analysis"
criteria = [
    "relevance_to_charges",
    "reliability_of_source",
    "chain_of_custody_integrity",
    "corroboration_strength",
    "prejudicial_vs_probative"
]
scale = { min = 0.0, max = 10.0, precision = 1 }

[system.outputs]
mcp_entity = { class = "EvidenceRating", space = "case-{case_number}" }
dashboard_update = { widget = "evidence-ratings", real_time = true }
notification = { threshold = 8.0, recipients = ["judge", "both-counsel"] }

[system.constraints]
requires_human_review = true
cannot_determine_admissibility = true
advisory_only = true
```

```toml
# systems/contradiction_detector.toml

[system]
name = "contradiction-detector"
version = "1.0.0"
description = "Real-time detection of contradictions across testimony and evidence"

[system.inputs]
testimony_stream = { source = "audio", real_time = true }
evidence = { source = "mcp", query = "class=Evidence", preload = true }
prior_testimony = { source = "mcp", query = "class=Testimony", preload = true }

[system.processing]
engine = "gpt-4"
method = "cross-reference-analysis"
checks = [
    "timeline_consistency",
    "location_feasibility",
    "statement_self_contradiction",
    "statement_cross_contradiction",
    "evidence_contradiction",
    "physical_impossibility"
]

[system.outputs]
mcp_entity = { class = "Contradiction", space = "case-{case_number}" }
alert = { severity_threshold = "medium", recipients = ["judge"] }
visualization = { type = "highlight", target = "timeline_wall" }

[system.constraints]
confidence_threshold = 0.7
requires_human_verification = true
log_all_checks = true
```

```toml
# systems/abductive_reasoner.toml

[system]
name = "abductive-reasoner"
version = "1.0.0"
description = "Builds and maintains hypothesis trees using abductive reasoning"

[system.inputs]
evidence = { source = "mcp", query = "class=Evidence AND status=admitted" }
testimony = { source = "mcp", query = "class=Testimony" }
contradictions = { source = "mcp", query = "class=Contradiction" }
ratings = { source = "mcp", query = "class=EvidenceRating" }

[system.processing]
engine = "gpt-4"
method = "inference-to-best-explanation"
update_frequency = "on-new-input"

[system.processing.hypotheses]
generate_from = ["charges", "defense_theory"]
max_hypotheses = 5
require_evidence_basis = true

[system.processing.scoring]
evidence_weight = 0.4
testimony_weight = 0.3
consistency_weight = 0.2
parsimony_weight = 0.1

[system.outputs]
mcp_entity = { class = "ReasoningTree", space = "case-{case_number}" }
dashboard_widget = { type = "reasoning-tree", interactive = true }
export = { format = "json", on_phase_change = true }

[system.constraints]
no_verdict_recommendation = true
advisory_only = true
transparent_reasoning = true
show_confidence_intervals = true
```

---

## 7. API Integration Layer

### Justice API Gateway

A unified Rust API gateway that connects all external services:

```toml
# config/apis.toml

[gateway]
host = "0.0.0.0"
port = 8080
tls = true
rate_limit = 1000

[apis.case_law]
provider = "grok-4"
endpoint = "https://api.x.ai/v1/chat/completions"
model = "grok-4"
auth_type = "bearer"
env_key = "GROK_API_KEY"
cache_ttl_secs = 3600
purpose = "Case law research and citation"

[apis.transcription]
provider = "ultravox"
endpoint = "https://api.ultravox.ai/v1/transcribe"
auth_type = "bearer"
env_key = "ULTRAVOX_API_KEY"
streaming = true
purpose = "Real-time courtroom transcription"

[apis.voice_synthesis]
provider = "elevenlabs"
endpoint = "https://api.elevenlabs.io/v1/text-to-speech"
auth_type = "bearer"
env_key = "ELEVENLABS_API_KEY"
purpose = "Accessible audio output for documents"

[apis.nlp]
provider = "openai"
endpoint = "https://api.openai.com/v1/chat/completions"
model = "gpt-4"
auth_type = "bearer"
env_key = "OPENAI_API_KEY"
purpose = "Natural language analysis and reasoning"

[apis.blockchain]
provider = "cardano"
endpoint = "https://cardano-mainnet.blockfrost.io/api/v0"
auth_type = "project-id"
env_key = "BLOCKFROST_PROJECT_ID"
purpose = "Evidence preservation and chain of custody"

[apis.embeddings]
provider = "nomic"
endpoint = "https://api-atlas.nomic.ai/v1/embedding/text"
auth_type = "bearer"
env_key = "NOMIC_API_KEY"
purpose = "Semantic search across case documents"

[apis.telephony]
provider = "twilio"
account_sid_env = "TWILIO_ACCOUNT_SID"
auth_token_env = "TWILIO_AUTH_TOKEN"
purpose = "AI Legal Hotline (999-999-9999)"
```

---

## 8. Workflow: A Case from Filing to Verdict

### Step-by-Step Automation Flow

```
1. CASE FILED
   └─→ justice-cli case create ... 
   └─→ MCP: Create space "case-2026-CR-001"
   └─→ Eustress: Initialize courtroom universe
   └─→ TOML: Generate case.toml, courtroom.toml, agents.toml

2. EVIDENCE COLLECTED
   └─→ justice-cli evidence submit ...
   └─→ MCP: Create evidence entities
   └─→ Blockchain: Hash and timestamp each item
   └─→ AI Agent: Auto-classify and rate
   └─→ Eustress: Position evidence in 3D evidence room

3. PRE-TRIAL
   └─→ AI Agents: Research relevant case law
   └─→ AI Agents: Identify key issues and potential motions
   └─→ Eustress: Generate courtroom layout from TOML
   └─→ Dashboard: Pre-trial summary for judge

4. TRIAL BEGINS
   └─→ justice-cli audio start ...
   └─→ Real-time transcription: All participants
   └─→ AI Agents: Activate all role-specific agents
   └─→ Contradiction detector: Monitoring
   └─→ Evidence rater: Updating scores
   └─→ Eustress: Live 3D courtroom with evidence display

5. TESTIMONY & EVIDENCE PRESENTATION
   └─→ Audio: Speaker-tagged transcription
   └─→ MCP: Store testimony as entities
   └─→ AI: Cross-reference against all evidence
   └─→ AI: Detect contradictions in real-time
   └─→ Dashboard: Live updates for judge
   └─→ Eustress: Evidence visualization on courtroom displays

6. CLOSING ARGUMENTS
   └─→ AI: Generate case summary for jury
   └─→ AI: Build abductive reasoning tree
   └─→ Eustress: Timeline visualization for jury
   └─→ Dashboard: Complete evidence ratings

7. JURY DELIBERATION
   └─→ Jury Information Agent: Fact-only evidence access
   └─→ Eustress: Interactive evidence review in jury room
   └─→ Timeline: Interactive chronology
   └─→ Exhibits: On-demand retrieval

8. VERDICT & SENTENCING
   └─→ AI: Sentencing guidelines analysis (if applicable)
   └─→ MCP: Record verdict as entity
   └─→ Blockchain: Immutable case record
   └─→ Export: Complete case archive
```

---

## 9. Security and Constitutional Compliance

### Principles

1. **Due Process** — AI is advisory only; humans make all decisions
2. **Equal Protection** — Same tools available to prosecution and defense
3. **Right to Confrontation** — AI cannot replace witness examination
4. **Privilege** — Attorney-client communications are never processed
5. **Transparency** — All AI reasoning is explainable and auditable
6. **Consent** — Audio processing requires informed consent of all parties

### Access Control

```toml
# config/security.toml

[access_control]
model = "role-based"
audit_all_access = true
log_retention_days = 2555  # 7 years per federal records requirements

[roles.judge]
access = ["all-evidence", "all-testimony", "all-agents", "sentencing-guidelines"]
can_modify = ["rulings", "jury-instructions", "case-status"]
private_agents = ["judicial-assistant"]

[roles.prosecution]
access = ["prosecution-evidence", "public-testimony", "prosecution-agents"]
cannot_access = ["defense-work-product", "jury-deliberation"]
private_agents = ["prosecutor-assistant"]

[roles.defense]
access = ["defense-evidence", "public-testimony", "defense-agents"]
cannot_access = ["prosecution-work-product", "jury-deliberation"]
private_agents = ["defense-assistant"]

[roles.jury]
access = ["admitted-evidence", "jury-instructions", "jury-information-agent"]
cannot_access = ["excluded-evidence", "attorney-work-product", "agent-findings"]
read_only = true

[encryption]
at_rest = "AES-256-GCM"
in_transit = "TLS-1.3"
evidence_hashing = "SHA-256"
blockchain = "cardano"
```

---

## 10. What This Enables

### For Judges
- **Real-time contradiction alerts** during testimony
- **Evidence ratings** based on reliability, relevance, and chain of custody
- **Abductive reasoning trees** showing hypothesis strength
- **Sentencing guidelines** with case law precedent search
- **3D evidence visualization** for complex physical evidence

### For Attorneys
- **AI-assisted case preparation** with relevant case law
- **Real-time transcript analysis** during proceedings
- **Evidence organization** with automatic classification
- **Witness preparation** with anticipated cross-examination points

### For Juries
- **Organized evidence summaries** (facts only, no opinions)
- **Interactive timelines** of events
- **3D evidence examination** for physical items
- **Legal term definitions** on demand

### For the Public
- **Transparency** — open source, auditable algorithms
- **Speed** — faster case resolution through automation
- **Accuracy** — fewer errors through AI-assisted analysis
- **Fairness** — same tools for both sides
- **Access** — unified web portal for all justice services

---

## Getting Started

```bash
# Clone the repository
git clone https://github.com/WeaveITMeta/rust-justice.git
cd rust-justice

# Build the CLI
cargo build -p justice-cli

# Install Eustress tools
cd Eustress && cargo build -p eustress-mcp -p eustress-forge

# Configure your case
cp templates/case.toml cases/my-case/case.toml
# Edit cases/my-case/case.toml

# Launch
justice-cli case open "my-case" --with-eustress
```

---

## Future: From Arizona to All 50 States

This system is designed to be **state-configurable**. Each state's specific statutes, court structures, and procedures are defined in TOML:

```toml
# states/arizona.toml
[state]
name = "Arizona"
abbreviation = "AZ"
code = "ARS"  # Arizona Revised Statutes
courts = ["supreme", "appeals", "superior", "justice", "municipal"]

# states/california.toml
[state]
name = "California"
abbreviation = "CA"
code = "CPC"  # California Penal Code
courts = ["supreme", "appeals", "superior"]
```

One codebase. Fifty configurations. One unified justice system.

---

*Document Version: 1.0.0*
*Last Updated: March 2026*
*Part of the Justice System Open-Source Framework*
