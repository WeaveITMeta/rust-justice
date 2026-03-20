//! Event definitions for justice simulation.
//!
//! These events can be used with Bevy's event system to communicate
//! between systems in the justice simulation.

use serde::{Deserialize, Serialize};
use crate::entities::{JusticeEntityId, CourtroomRole};
use crate::courtroom::ProceedingPhase;
use crate::evidence::EvidenceStatus;

/// Event fired when a courtroom session starts.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SessionStarted {
    pub session_id: JusticeEntityId,
    pub case_id: JusticeEntityId,
}

/// Event fired when a courtroom session ends.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SessionEnded {
    pub session_id: JusticeEntityId,
    pub reason: SessionEndReason,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
pub enum SessionEndReason {
    Completed,
    Adjourned,
    Mistrial,
    Dismissed,
    Cancelled,
}

/// Event fired when the proceeding phase changes.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PhaseChanged {
    pub session_id: JusticeEntityId,
    pub previous_phase: ProceedingPhase,
    pub new_phase: ProceedingPhase,
}

/// Event fired when a participant speaks.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ParticipantSpoke {
    pub participant_id: JusticeEntityId,
    pub role: CourtroomRole,
    pub content: String,
    pub timestamp: chrono::DateTime<chrono::Utc>,
}

/// Event fired when evidence status changes.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct EvidenceStatusChanged {
    pub evidence_id: JusticeEntityId,
    pub exhibit_number: String,
    pub previous_status: EvidenceStatus,
    pub new_status: EvidenceStatus,
}

/// Event fired when evidence is presented.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct EvidencePresented {
    pub evidence_id: JusticeEntityId,
    pub exhibit_number: String,
    pub presented_by: JusticeEntityId,
}

/// Event fired when an objection is raised.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ObjectionRaised {
    pub objector_id: JusticeEntityId,
    pub objection_type: ObjectionType,
    pub target: Option<JusticeEntityId>,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
pub enum ObjectionType {
    Relevance,
    Hearsay,
    LeadingQuestion,
    Speculation,
    AskedAndAnswered,
    Argumentative,
    CompoundQuestion,
    AssumesFacts,
    BestEvidence,
    Prejudicial,
    Other,
}

impl ObjectionType {
    pub fn description(&self) -> &'static str {
        match self {
            Self::Relevance => "Objection: Relevance",
            Self::Hearsay => "Objection: Hearsay",
            Self::LeadingQuestion => "Objection: Leading the witness",
            Self::Speculation => "Objection: Calls for speculation",
            Self::AskedAndAnswered => "Objection: Asked and answered",
            Self::Argumentative => "Objection: Argumentative",
            Self::CompoundQuestion => "Objection: Compound question",
            Self::AssumesFacts => "Objection: Assumes facts not in evidence",
            Self::BestEvidence => "Objection: Best evidence rule",
            Self::Prejudicial => "Objection: More prejudicial than probative",
            Self::Other => "Objection",
        }
    }
}

/// Event fired when a ruling is made on an objection.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ObjectionRuled {
    pub objection_type: ObjectionType,
    pub ruling: ObjectionRuling,
    pub explanation: Option<String>,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
pub enum ObjectionRuling {
    Sustained,
    Overruled,
}

/// Event fired when a verdict is reached.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct VerdictReached {
    pub case_id: JusticeEntityId,
    pub verdict: Verdict,
    pub counts: Vec<VerdictCount>,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
pub enum Verdict {
    Guilty,
    NotGuilty,
    Liable,
    NotLiable,
    Hung,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct VerdictCount {
    pub count_number: u32,
    pub charge: String,
    pub verdict: Verdict,
}
