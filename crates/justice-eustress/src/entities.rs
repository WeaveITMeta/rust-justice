//! Entity definitions for justice simulation.
//!
//! These components can be attached to Bevy entities to represent
//! participants and objects in the justice system simulation.

use serde::{Deserialize, Serialize};
use uuid::Uuid;

/// Unique identifier for justice system entities.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, Serialize, Deserialize)]
pub struct JusticeEntityId(pub Uuid);

impl JusticeEntityId {
    pub fn new() -> Self {
        Self(Uuid::new_v4())
    }
}

impl Default for JusticeEntityId {
    fn default() -> Self {
        Self::new()
    }
}

/// Role of a participant in the courtroom.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, Serialize, Deserialize)]
pub enum CourtroomRole {
    Judge,
    Prosecutor,
    DefenseAttorney,
    Defendant,
    Plaintiff,
    Witness,
    JuryMember,
    CourtClerk,
    CourtReporter,
    Bailiff,
    Spectator,
}

impl CourtroomRole {
    /// Returns the typical position in a standard courtroom layout.
    pub fn default_position(&self) -> (f32, f32, f32) {
        match self {
            Self::Judge => (0.0, 2.0, -8.0),
            Self::Prosecutor => (-4.0, 0.0, -2.0),
            Self::DefenseAttorney => (4.0, 0.0, -2.0),
            Self::Defendant => (5.0, 0.0, -2.0),
            Self::Plaintiff => (-5.0, 0.0, -2.0),
            Self::Witness => (0.0, 0.5, -5.0),
            Self::JuryMember => (-8.0, 0.5, -4.0),
            Self::CourtClerk => (-2.0, 1.5, -7.0),
            Self::CourtReporter => (2.0, 0.0, -6.0),
            Self::Bailiff => (8.0, 0.0, -6.0),
            Self::Spectator => (0.0, 0.0, 4.0),
        }
    }
}

/// A participant in the courtroom simulation.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Participant {
    pub id: JusticeEntityId,
    pub name: String,
    pub role: CourtroomRole,
    pub is_speaking: bool,
    pub is_active: bool,
}

impl Participant {
    pub fn new(name: impl Into<String>, role: CourtroomRole) -> Self {
        Self {
            id: JusticeEntityId::new(),
            name: name.into(),
            role,
            is_speaking: false,
            is_active: true,
        }
    }
}

/// Type of legal case being simulated.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, Serialize, Deserialize)]
pub enum CaseType {
    Criminal,
    Civil,
    Family,
    Juvenile,
    Traffic,
    SmallClaims,
    Appellate,
    Administrative,
}

/// A legal case in the simulation.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Case {
    pub id: JusticeEntityId,
    pub case_number: String,
    pub case_type: CaseType,
    pub title: String,
    pub description: String,
    pub participants: Vec<Participant>,
    pub created_at: chrono::DateTime<chrono::Utc>,
}

impl Case {
    pub fn new(case_number: impl Into<String>, case_type: CaseType, title: impl Into<String>) -> Self {
        Self {
            id: JusticeEntityId::new(),
            case_number: case_number.into(),
            case_type,
            title: title.into(),
            description: String::new(),
            participants: Vec::new(),
            created_at: chrono::Utc::now(),
        }
    }
    
    pub fn add_participant(&mut self, participant: Participant) {
        self.participants.push(participant);
    }
}
