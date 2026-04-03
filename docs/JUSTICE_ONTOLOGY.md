# Justice System Ontology
## Conceptual Model for Integrated Justice Crates with Eustress Engine

**Date:** March 2026
**Status:** Architecture & Design (Planning Phase)
**Scope:** Ontology, crate structure, integration patterns, and data flow for Justice ecosystem

---

## Table of Contents

1. [Core Ontology](#core-ontology)
2. [Entity Relationships](#entity-relationships)
3. [Crate Architecture](#crate-architecture)
4. [Eustress Integration Points](#eustress-integration-points)
5. [Data Flow Architecture](#data-flow-architecture)
6. [Module Structure](#module-structure)
7. [Integration Patterns](#integration-patterns)

---

## Core Ontology

### Top-Level Concepts

```
┌─────────────────────────────────────────────────────────────┐
│                    JUSTICE SYSTEM                           │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌──────────────────────────────────────────────────────┐  │
│  │ LEGAL FRAMEWORK (justice-usc)                        │  │
│  │ - Title (54 total, focus on Title 28)                │  │
│  │ - Section (e.g., § 1983, § 3621)                     │  │
│  │ - Citation (parsed references)                       │  │
│  │ - Compliance Rules                                   │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                             │
│  ┌──────────────────────────────────────────────────────┐  │
│  │ JUSTICE OUTCOMES (karbuche integration)              │  │
│  │ - Outcome Type (Punitive, Corrective, Restorative)  │  │
│  │ - Classification (ML-based behavior analysis)        │  │
│  │ - Confidence Score                                   │  │
│  │ - Relevant USC Sections                              │  │
│  │ - Audit Trail (immutable)                            │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                             │
│  ┌──────────────────────────────────────────────────────┐  │
│  │ FACILITY ENTITIES (justice-eustress)                 │  │
│  │ - Inmates (individuals with rights, history)         │  │
│  │ - Staff (roles, supervision, interventions)          │  │
│  │ - Locations (cells, corridors, programs)             │  │
│  │ - Events (incidents, programs, medical)              │  │
│  │ - Resources (programs, medical, counseling)          │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                             │
│  ┌──────────────────────────────────────────────────────┐  │
│  │ SIMULATION STATE (eustress-engine)                   │  │
│  │ - Digital Twin (3D facility model)                   │  │
│  │ - Entity State (position, behavior, health)          │  │
│  │ - Event Queue (incidents, programs, updates)         │  │
│  │ - Physics (crowd dynamics, interactions)             │  │
│  │ - Scenario (live vs. what-if)                        │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Concept Definitions

#### LEGAL_FRAMEWORK
**Purpose:** Authoritative source of U.S. Code and legal requirements

**Key Entities:**
- **Title** — One of 54 USC titles (focus: Title 28 Judiciary)
- **Section** — Specific law (e.g., 28 U.S.C. § 1983 civil rights)
- **Subsection** — Detailed requirements
- **Citation** — Parsed reference format
- **Compliance_Rule** — Enforceable requirement derived from section

**Properties:**
- `title_number: u32` (1-54)
- `section_number: String` (e.g., "1983")
- `full_text: String`
- `effective_date: DateTime`
- `repealed: bool`
- `related_sections: Vec<Citation>`

**Constraints:**
- Each section is unique (title + section number)
- Repealed sections are marked but retained for historical audit
- All sections must have full text and effective date

---

#### JUSTICE_OUTCOME
**Purpose:** Auditable classification of inmate behavior and recommended action

**Key Entities:**
- **Outcome_Type** — Punitive, Corrective, or Restorative
- **Classification** — ML-derived behavior pattern
- **Confidence** — Model certainty (0-1)
- **Relevant_Sections** — USC sections that apply
- **Audit_Record** — Immutable proof of outcome

**Properties:**
- `outcome_id: UUID`
- `inmate_id: String`
- `timestamp: DateTime`
- `outcome_type: OutcomeType`
- `classification: String` (e.g., "violent_behavior", "cooperative")
- `confidence: f32`
- `behavior_signals: Vec<String>` (what drove the classification)
- `relevant_usc_sections: Vec<Citation>`
- `recommended_intervention: String`
- `audit_hash: String` (SHA-256 of immutable data)

**Constraints:**
- Confidence must be 0-1
- Outcome type must be one of three types
- All outcomes must have at least one relevant USC section
- Audit hash is immutable once created

---

#### FACILITY_ENTITY
**Purpose:** Represents actors and locations within a correctional facility

**Subtypes:**

**Inmate**
- `inmate_id: String`
- `name: String` (optional, for privacy)
- `cohort: String` (K-Means cluster from Karbuche)
- `location: Location`
- `health_state: HealthState`
- `rehabilitation_progress: f32` (0-1)
- `rights_status: Vec<RightStatus>` (Title 28 § 1983, § 1997)
- `recent_outcomes: Vec<JusticeOutcome>`

**Staff**
- `staff_id: String`
- `role: StaffRole` (Officer, Counselor, Medical, Admin)
- `location: Location`
- `supervision_area: Vec<Location>`
- `current_task: Option<Task>`
- `intervention_capability: Vec<InterventionType>`

**Location**
- `location_id: String`
- `name: String` (e.g., "Cell Block A", "Yard")
- `capacity: u32`
- `current_occupancy: u32`
- `type: LocationType` (Cell, Corridor, Common, Medical, Program)
- `risk_level: RiskLevel` (Low, Medium, High)
- `supervision_points: Vec<Point3D>`

**Event**
- `event_id: UUID`
- `event_type: EventType` (Incident, Program, Medical, Administrative)
- `timestamp: DateTime`
- `location: Location`
- `involved_entities: Vec<EntityReference>`
- `description: String`
- `outcome: Option<JusticeOutcome>`

---

#### SIMULATION_STATE
**Purpose:** Real-time state of the digital twin in EustressEngine

**Key Entities:**
- **Digital_Twin** — 3D model of facility
- **Entity_State** — Current state of each inmate/staff
- **Event_Queue** — Pending events to process
- **Physics_State** — Crowd dynamics, interactions
- **Scenario_Context** — Live vs. what-if mode

**Properties:**
- `simulation_id: UUID`
- `facility_id: String`
- `current_time: DateTime` (or simulation time)
- `scenario_mode: ScenarioMode` (Live, WhatIf)
- `entity_states: HashMap<EntityId, EntityState>`
- `event_queue: VecDeque<Event>`
- `physics_state: PhysicsState`
- `performance_metrics: PerformanceMetrics`

**Constraints:**
- Only one Live scenario per facility at a time
- What-If scenarios are isolated (don't affect Live)
- All entities in simulation must have valid location
- Event queue is ordered by timestamp

---

## Entity Relationships

### Relationship Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                    JUSTICE SYSTEM                           │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  LEGAL_FRAMEWORK                                            │
│      ↓ (governs)                                            │
│  JUSTICE_OUTCOME ←→ FACILITY_ENTITY                         │
│      ↓ (informs)      ↓ (simulated in)                      │
│  SIMULATION_STATE ←→ EUSTRESS_ENGINE                        │
│      ↓ (visualized in)                                      │
│  SUPERVISED_DASHBOARD                                       │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Key Relationships

**1. LEGAL_FRAMEWORK → JUSTICE_OUTCOME**
- **Type:** Governance
- **Direction:** One-to-Many (one section governs many outcomes)
- **Constraint:** Every outcome must reference at least one section
- **Example:** § 1983 governs all civil rights outcomes

**2. JUSTICE_OUTCOME → FACILITY_ENTITY (Inmate)**
- **Type:** Classification
- **Direction:** One-to-Many (one inmate has many outcomes)
- **Constraint:** Outcome must reference valid inmate
- **Temporal:** Outcomes are timestamped (audit trail)

**3. FACILITY_ENTITY → SIMULATION_STATE**
- **Type:** Representation
- **Direction:** One-to-One (each entity has state in simulation)
- **Constraint:** All entities in simulation must exist in facility
- **Sync:** State updates bidirectionally (Live mode)

**4. JUSTICE_OUTCOME → SIMULATION_STATE**
- **Type:** Influence
- **Direction:** One-to-Many (outcomes drive simulation updates)
- **Constraint:** Outcomes from Karbuche feed into simulation
- **Latency:** Sub-100ms (real-time)

**5. SIMULATION_STATE → SUPERVISED_DASHBOARD**
- **Type:** Visualization
- **Direction:** One-to-One (simulation state displayed)
- **Constraint:** Dashboard reflects current simulation state
- **Refresh:** 30 FPS (human perception)

---

## Crate Architecture

### Current Crates

```
/Justice/crates/
├── justice-usc/
│   ├── Purpose: Legal framework (all 54 USC titles)
│   ├── Modules:
│   │   ├── types.rs (Title, Section, Citation)
│   │   ├── parser.rs (XML → Rust types)
│   │   ├── citation.rs (Citation lookup & parsing)
│   │   ├── downloader.rs (Fetch from Cornell Law)
│   │   └── error.rs (Error types)
│   └── Exports: Title, Section, Citation, ComplianceRule
│
└── justice-eustress/
    ├── Purpose: Eustress integration (facility simulation)
    ├── Modules:
    │   ├── courtroom.rs (Courtroom entities & systems)
    │   ├── evidence.rs (Evidence visualization)
    │   ├── entities.rs (Inmate, Staff, Location, Event)
    │   ├── events.rs (Event types & handlers)
    │   ├── resources.rs (Shared resources)
    │   ├── systems.rs (Eustress systems)
    │   ├── training.rs (Training scenarios) [feature-gated]
    │   └── networking.rs (Multiplayer) [feature-gated]
    └── Exports: All above via prelude
```

### Proposed New Crates

```
/Justice/crates/
├── justice-core/
│   ├── Purpose: Shared types & traits (ontology)
│   ├── Modules:
│   │   ├── entity.rs (Entity trait, EntityId, EntityState)
│   │   ├── outcome.rs (JusticeOutcome, OutcomeType)
│   │   ├── facility.rs (Facility, Location, RiskLevel)
│   │   ├── event.rs (Event, EventType, EventHandler)
│   │   ├── rights.rs (InmateRights, Title 28 § 1983/1997)
│   │   └── error.rs (Unified error types)
│   └── Dependencies: serde, chrono, uuid, thiserror
│
├── justice-karbuche/
│   ├── Purpose: Karbuche integration (behavior classification)
│   ├── Modules:
│   │   ├── classifier.rs (Behavior classification)
│   │   ├── outcome.rs (JusticeOutcome generation)
│   │   ├── stream.rs (Real-time outcome stream via Eustress Streams)
│   │   ├── fairness.rs (Bias detection & auditing)
│   │   └── audit.rs (Immutable audit trail)
│   └── Dependencies: justice-core, justice-usc, karbuche, eustress-streams
│
├── justice-streams/
│   ├── Purpose: Real-time data streaming (Eustress Streams backbone)
│   ├── Modules:
│   │   ├── stream_node.rs (StreamNode client for Eustress Streams)
│   │   ├── topics.rs (Topic definitions: outcomes, events, predictions)
│   │   ├── pipeline.rs (Data pipeline orchestration via Eustress Streams)
│   │   ├── serialization.rs (Message serialization)
│   │   ├── monitoring.rs (Stream health & metrics)
│   │   └── distributed.rs (Distributed processing across stream nodes)
│   └── Dependencies: justice-core, eustress-streams, tokio
│
├── justice-simulation/
│   ├── Purpose: Simulation state & logic (Eustress integration)
│   ├── Modules:
│   │   ├── state.rs (SimulationState, EntityState)
│   │   ├── physics.rs (Crowd dynamics, interactions)
│   │   ├── behavior.rs (Behavior trees, decision logic)
│   │   ├── scenario.rs (Live vs. What-If modes)
│   │   ├── prediction.rs (Predictive models)
│   │   └── eustress_bridge.rs (Eustress integration)
│   └── Dependencies: justice-core, justice-karbuche, justice-streams, eustress
│
├── justice-dashboard/
│   ├── Purpose: Supervised dashboard (Egui/Slint UI)
│   ├── Modules:
│   │   ├── ui.rs (UI components)
│   │   ├── visualization.rs (3D facility view)
│   │   ├── alerts.rs (Alert display & management)
│   │   ├── analytics.rs (Data visualization)
│   │   └── state.rs (Dashboard state management)
│   └── Dependencies: justice-core, justice-simulation, justice-streams, egui/slint
│
└── justice-compliance/
    ├── Purpose: Title 28 compliance checking & reporting
    ├── Modules:
    │   ├── checker.rs (Compliance rule evaluation)
    │   ├── reporter.rs (Compliance report generation)
    │   ├── audit.rs (Audit trail management)
    │   ├── rights.rs (Inmate rights verification)
    │   └── doj.rs (DOJ reporting format)
    └── Dependencies: justice-core, justice-usc, justice-karbuche, justice-streams
```

---

## Eustress Integration Points

### Integration Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    EUSTRESS STREAMS                         │
│         (Unified Real-Time Processing Backbone)             │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌──────────────────────────────────────────────────────┐  │
│  │ STREAM NODES (Distributed Processing)                │  │
│  │ - Outcome ingestion (Karbuche → stream)              │  │
│  │ - Depth data processing (cameras → stream)           │  │
│  │ - Event generation (simulation → stream)             │  │
│  │ - Prediction computation (ensemble models)           │  │
│  │ - Compliance checking (Title 28 validation)          │  │
│  └──────────────────────────────────────────────────────┘  │
│                      ↕                                      │
│  ┌──────────────────────────────────────────────────────┐  │
│  │ EUSTRESS ENGINE (ECS + Simulation)                   │  │
│  │ - Entities: Inmates, Staff, Locations               │  │
│  │ - Components: Position, Health, Behavior, Rights    │  │
│  │ - Systems: Movement, Interaction, Event Processing  │  │
│  │ - Consumes from Eustress Streams                     │  │
│  └──────────────────────────────────────────────────────┘  │
│                      ↕                                      │
│  ┌──────────────────────────────────────────────────────┐  │
│  │ JUSTICE INTEGRATION LAYER                            │  │
│  │ - justice-eustress plugin                            │  │
│  │ - justice-simulation bridge                          │  │
│  │ - Event handlers for outcomes                        │  │
│  │ - Publishes results back to Eustress Streams         │  │
│  └──────────────────────────────────────────────────────┘  │
│                      ↕                                      │
│  ┌──────────────────────────────────────────────────────┐  │
│  │ DATA SOURCES & SINKS                                 │  │
│  │ Sources:                                             │  │
│  │ - Karbuche (real-time outcomes)                      │  │
│  │ - Depth cameras (3D position data)                   │  │
│  │ - Facility database (static layout)                  │  │
│  │ Sinks:                                               │  │
│  │ - Supervised Dashboard (visualization)               │  │
│  │ - Audit Trail (immutable log)                        │  │
│  │ - Compliance Reports (DOJ)                           │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Integration Points

**1. Entity Synchronization**

```rust
// Eustress Entity ←→ Justice Entity
pub trait EntitySync {
    fn from_eustress_entity(eustress_entity: &EustressEntity) -> JusticeEntity;
    fn to_eustress_entity(&self) -> EustressEntity;
    fn sync_state(&mut self, eustress_state: &EntityState);
}

// Example: Inmate
impl EntitySync for Inmate {
    fn sync_state(&mut self, eustress_state: &EntityState) {
        self.location = eustress_state.position.to_location();
        self.health_state = eustress_state.health.clone();
        self.behavior = eustress_state.behavior.clone();
    }
}
```

**2. Event Propagation**

```rust
// Justice Outcome → Eustress Event
pub trait OutcomeToEvent {
    fn to_eustress_event(&self) -> EustressEvent;
}

// Example: Violence outcome triggers intervention event
impl OutcomeToEvent for JusticeOutcome {
    fn to_eustress_event(&self) -> EustressEvent {
        match self.outcome_type {
            OutcomeType::Punitive => {
                EustressEvent::IncidentDetected {
                    location: self.location,
                    severity: self.confidence,
                    recommended_action: self.recommended_intervention.clone(),
                }
            },
            OutcomeType::Corrective => {
                EustressEvent::InterventionNeeded {
                    inmate_id: self.inmate_id.clone(),
                    intervention_type: self.recommended_intervention.clone(),
                }
            },
            OutcomeType::Restorative => {
                EustressEvent::ProgramAssignment {
                    inmate_id: self.inmate_id.clone(),
                    program: self.recommended_intervention.clone(),
                }
            },
        }
    }
}
```

**3. System Scheduling**

```rust
// Eustress system scheduling with justice constraints
pub fn schedule_justice_systems(app: &mut App) {
    app
        // Read outcomes from Karbuche stream
        .add_systems(
            Update,
            justice_outcome_ingestion_system
                .in_set(JusticeSet::IngestOutcomes)
        )
        // Update entity state based on outcomes
        .add_systems(
            Update,
            entity_state_update_system
                .in_set(JusticeSet::UpdateState)
                .after(JusticeSet::IngestOutcomes)
        )
        // Generate events for interventions
        .add_systems(
            Update,
            intervention_event_system
                .in_set(JusticeSet::GenerateEvents)
                .after(JusticeSet::UpdateState)
        )
        // Standard Eustress physics/movement
        .add_systems(
            Update,
            eustress_movement_system
                .in_set(EustressSet::Movement)
                .after(JusticeSet::GenerateEvents)
        )
        // Compliance checking
        .add_systems(
            Update,
            compliance_check_system
                .in_set(JusticeSet::CheckCompliance)
                .after(EustressSet::Movement)
        );
}
```

---

## Data Flow Architecture

### Real-Time Flow (Live Facility)

```
Physical Facility
    ↓
Depth Cameras (60 FPS) + Inmate Tablets
    ↓
Karbuche (Classification)
    ↓ (JusticeOutcome)
Eustress Streams
    ↓
justice-karbuche (Outcome ingestion)
    ↓
justice-simulation (Update entity state)
    ↓
EustressEngine (Update 3D positions, behaviors)
    ↓
justice-dashboard (Visualize)
    ↓
Administrator (Make decision)
    ↓
Staff (Implement intervention)
    ↓
Physical Facility (Behavior changes)
    ↓
[Loop back to Depth Cameras]
```

### Scenario Testing Flow (What-If)

```
Administrator (Proposes scenario)
    ↓
justice-simulation (Load facility model)
    ↓
Karbuche (Provide outcome distribution)
    ↓
justice-streams (Synthetic outcome stream)
    ↓
EustressEngine (Run scenario with synthetic data)
    ↓
justice-dashboard (Show predicted results)
    ↓
Administrator (Evaluate impact)
    ↓
Decision (Implement or modify)
```

---

## Module Structure

### justice-core (Foundation)

```rust
// entity.rs
pub trait Entity {
    fn id(&self) -> EntityId;
    fn entity_type(&self) -> EntityType;
    fn location(&self) -> Location;
}

pub struct EntityId(pub UUID);
pub enum EntityType { Inmate, Staff, Location }

// outcome.rs
pub struct JusticeOutcome {
    pub outcome_id: UUID,
    pub inmate_id: String,
    pub timestamp: DateTime<Utc>,
    pub outcome_type: OutcomeType,
    pub classification: String,
    pub confidence: f32,
    pub relevant_usc_sections: Vec<Citation>,
    pub recommended_intervention: String,
    pub audit_hash: String,
}

pub enum OutcomeType {
    Punitive,
    Corrective,
    Restorative,
}

// facility.rs
pub struct Facility {
    pub facility_id: String,
    pub name: String,
    pub locations: HashMap<String, Location>,
    pub inmates: HashMap<String, Inmate>,
    pub staff: HashMap<String, Staff>,
}

pub struct Location {
    pub location_id: String,
    pub name: String,
    pub capacity: u32,
    pub current_occupancy: u32,
    pub risk_level: RiskLevel,
}

pub enum RiskLevel { Low, Medium, High }

// rights.rs
pub struct InmateRights {
    pub civil_rights: bool,        // § 1983
    pub litigation_access: bool,   // § 1997e
    pub rehabilitation_access: bool, // § 1997
    pub due_process: bool,         // § 1983
}
```

### justice-karbuche (Behavior Classification)

```rust
// classifier.rs
pub struct BehaviorClassifier {
    model: KarbucheModel,
}

impl BehaviorClassifier {
    pub fn classify(&self, signals: &[BehaviorSignal]) -> Classification {
        // Calls Karbuche ML model
        // Returns behavior classification with confidence
    }
}

// outcome.rs
pub struct OutcomeGenerator {
    classifier: BehaviorClassifier,
    usc_mapper: USCMapper,
}

impl OutcomeGenerator {
    pub fn generate(&self, inmate_id: &str, signals: &[BehaviorSignal]) -> JusticeOutcome {
        let classification = self.classifier.classify(signals);
        let usc_sections = self.usc_mapper.map_to_sections(&classification);
        let intervention = self.recommend_intervention(&classification);
        
        JusticeOutcome {
            outcome_id: UUID::new_v4(),
            inmate_id: inmate_id.to_string(),
            timestamp: Utc::now(),
            outcome_type: self.classify_outcome_type(&classification),
            classification: classification.label,
            confidence: classification.confidence,
            relevant_usc_sections: usc_sections,
            recommended_intervention: intervention,
            audit_hash: self.compute_hash(...),
        }
    }
}

// stream.rs
pub struct OutcomeStream {
    kafka_consumer: KafkaConsumer,
}

impl OutcomeStream {
    pub async fn next_outcome(&mut self) -> Option<JusticeOutcome> {
        // Consume from Kafka topic
        // Deserialize and return
    }
}
```

### justice-simulation (Simulation State)

```rust
// state.rs
pub struct SimulationState {
    pub simulation_id: UUID,
    pub facility: Facility,
    pub entity_states: HashMap<EntityId, EntityState>,
    pub event_queue: VecDeque<Event>,
    pub scenario_mode: ScenarioMode,
}

pub struct EntityState {
    pub entity_id: EntityId,
    pub position: Vec3,
    pub velocity: Vec3,
    pub behavior: Behavior,
    pub health: HealthState,
}

pub enum ScenarioMode {
    Live,
    WhatIf { name: String },
}

// behavior.rs
pub struct BehaviorTree {
    root: BehaviorNode,
}

pub enum BehaviorNode {
    Sequence(Vec<BehaviorNode>),
    Selector(Vec<BehaviorNode>),
    Action(Box<dyn Action>),
    Condition(Box<dyn Condition>),
}

// prediction.rs
pub struct PredictiveModel {
    ensemble: EnsembleModel,
}

impl PredictiveModel {
    pub fn predict_next_incident(&self, state: &SimulationState) -> PredictiveAlert {
        // Predict incident type, probability, location, ETA
    }
}
```

### justice-eustress (Eustress Bridge)

```rust
// eustress_bridge.rs
pub struct JusticeEustressPlugin;

impl Plugin for JusticeEustressPlugin {
    fn build(&self, app: &mut App) {
        app
            .add_systems(Update, outcome_ingestion_system)
            .add_systems(Update, entity_sync_system)
            .add_systems(Update, intervention_event_system)
            .add_systems(Update, compliance_check_system);
    }
}

pub fn outcome_ingestion_system(
    mut outcome_stream: ResMut<OutcomeStream>,
    mut simulation_state: ResMut<SimulationState>,
) {
    while let Some(outcome) = outcome_stream.next_outcome() {
        // Update simulation based on outcome
        simulation_state.process_outcome(outcome);
    }
}

pub fn entity_sync_system(
    query: Query<(&Transform, &Inmate), Changed<Transform>>,
    mut simulation_state: ResMut<SimulationState>,
) {
    for (transform, inmate) in query.iter() {
        // Sync Eustress entity state to justice simulation
        simulation_state.update_entity_state(&inmate.id(), transform);
    }
}
```

---

## Integration Patterns

### Pattern 1: Outcome-Driven State Updates

```rust
// When Karbuche generates an outcome:
// 1. Outcome is published to Eustress Streams
// 2. justice-karbuche consumes and validates
// 3. justice-simulation updates entity state
// 4. EustressEngine reflects changes in 3D
// 5. Dashboard visualizes

pub async fn outcome_pipeline(
    outcome: JusticeOutcome,
    stream_client: &StreamNodeClient,
    simulation: &mut SimulationState,
) {
    // Publish to Eustress Streams
    stream_client.publish("justice-outcomes", &outcome).await;
    
    // Update simulation
    simulation.apply_outcome(&outcome);
    
    // Eustress will automatically reflect via ECS
}
```

### Pattern 2: Event-Driven Interventions

```rust
// When an intervention is needed:
// 1. justice-simulation generates intervention event
// 2. EustressEngine processes event
// 3. Staff entity receives task
// 4. Movement/behavior systems execute task
// 5. Outcome is recorded

pub fn intervention_event_system(
    mut events: EventReader<InterventionEvent>,
    mut commands: Commands,
) {
    for event in events.iter() {
        // Create task for staff
        let task = Task {
            task_type: event.intervention_type.clone(),
            target: event.inmate_id.clone(),
            priority: event.priority,
        };
        
        // Assign to nearest available staff
        // Eustress movement system will handle pathfinding
        commands.spawn(task);
    }
}
```

### Pattern 3: Compliance Checking

```rust
// Continuous compliance verification:
// 1. Every outcome is checked against Title 28
// 2. Every action is verified for constitutional validity
// 3. Violations trigger alerts and audit trail

pub fn compliance_check_system(
    outcomes: Query<&JusticeOutcome, Added<JusticeOutcome>>,
    usc: Res<USCFramework>,
    mut audit_trail: ResMut<AuditTrail>,
) {
    for outcome in outcomes.iter() {
        let compliance = usc.check_compliance(&outcome);
        
        if !compliance.is_compliant {
            audit_trail.log_violation(&outcome, &compliance);
            // Trigger alert to administrator
        }
    }
}
```

### Pattern 4: Scenario Testing

```rust
// What-If analysis:
// 1. Clone current facility state
// 2. Run simulation with synthetic outcomes
// 3. Predict impact
// 4. Display results without affecting Live

pub fn create_what_if_scenario(
    live_state: &SimulationState,
    scenario_name: &str,
    synthetic_outcomes: Vec<JusticeOutcome>,
) -> SimulationState {
    let mut what_if = live_state.clone();
    what_if.scenario_mode = ScenarioMode::WhatIf {
        name: scenario_name.to_string(),
    };
    
    // Apply synthetic outcomes
    for outcome in synthetic_outcomes {
        what_if.apply_outcome(&outcome);
    }
    
    what_if
}
```

---

## Dependency Graph

```
justice-core (foundation)
    ↑
    ├── justice-usc
    ├── justice-karbuche
    ├── justice-simulation
    ├── justice-compliance
    └── justice-eustress

justice-karbuche
    ├── depends on: justice-core, justice-usc
    └── provides: JusticeOutcome, OutcomeStream

justice-streams
    ├── depends on: justice-core
    └── provides: Eustress Streams infrastructure

justice-simulation
    ├── depends on: justice-core, justice-karbuche
    └── provides: SimulationState, PredictiveModel

justice-eustress
    ├── depends on: justice-core, justice-simulation, eustress-engine
    └── provides: EustressPlugin, EntitySync, EventHandlers

justice-dashboard
    ├── depends on: justice-core, justice-simulation
    └── provides: UI, Visualization, Analytics

justice-compliance
    ├── depends on: justice-core, justice-usc, justice-karbuche
    └── provides: ComplianceChecker, AuditTrail, Reporting
```

---

## Summary

This ontology provides:

1. **Clear Concepts** — Legal framework, outcomes, entities, simulation state
2. **Strong Relationships** — How concepts interact and constrain each other
3. **Modular Crates** — Each crate has a single responsibility
4. **Integration Points** — How Eustress connects to Justice system
5. **Data Flow** — Real-time and scenario testing flows
6. **Patterns** — Reusable integration patterns

The system is designed to be:
- **Extensible** — New crates can be added without breaking existing ones
- **Testable** — Each crate can be tested independently
- **Auditable** — Every action is logged and traceable
- **Compliant** — All actions verified against Title 28 USC
- **Just** — Rehabilitation-focused, rights-preserving, transparent

---

*Status: Ontology Design (Planning Phase)*
*Next Step: Implement crate structure and integration layer*
