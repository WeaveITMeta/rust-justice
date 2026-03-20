//! Courtroom environment and simulation components.
//!
//! This module provides the building blocks for creating immersive
//! courtroom environments for training, evidence presentation, and
//! procedural simulation.

use serde::{Deserialize, Serialize};
use crate::entities::{Case, JusticeEntityId};

/// Type of courtroom layout.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, Serialize, Deserialize, Default)]
pub enum CourtroomType {
    #[default]
    Federal,
    State,
    Municipal,
    Appellate,
    SupremeCourt,
    MootCourt,
    Custom,
}

/// Configuration for a courtroom environment.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CourtroomConfig {
    pub id: JusticeEntityId,
    pub name: String,
    pub courtroom_type: CourtroomType,
    pub has_jury_box: bool,
    pub jury_size: u8,
    pub has_gallery: bool,
    pub gallery_capacity: u32,
    pub has_witness_stand: bool,
    pub has_court_reporter: bool,
    pub dimensions: CourtroomDimensions,
}

impl Default for CourtroomConfig {
    fn default() -> Self {
        Self {
            id: JusticeEntityId::new(),
            name: "Default Courtroom".to_string(),
            courtroom_type: CourtroomType::Federal,
            has_jury_box: true,
            jury_size: 12,
            has_gallery: true,
            gallery_capacity: 50,
            has_witness_stand: true,
            has_court_reporter: true,
            dimensions: CourtroomDimensions::default(),
        }
    }
}

/// Physical dimensions of the courtroom.
#[derive(Debug, Clone, Copy, Serialize, Deserialize)]
pub struct CourtroomDimensions {
    pub width: f32,
    pub length: f32,
    pub height: f32,
}

impl Default for CourtroomDimensions {
    fn default() -> Self {
        Self {
            width: 20.0,
            length: 30.0,
            height: 6.0,
        }
    }
}

/// Current phase of courtroom proceedings.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, Serialize, Deserialize, Default)]
pub enum ProceedingPhase {
    #[default]
    PreTrial,
    JurySelection,
    OpeningStatements,
    ProsecutionCase,
    DefenseCase,
    Rebuttal,
    ClosingArguments,
    JuryInstructions,
    JuryDeliberation,
    Verdict,
    Sentencing,
    Adjournment,
}

impl ProceedingPhase {
    /// Returns the next phase in typical criminal trial order.
    pub fn next(&self) -> Option<Self> {
        match self {
            Self::PreTrial => Some(Self::JurySelection),
            Self::JurySelection => Some(Self::OpeningStatements),
            Self::OpeningStatements => Some(Self::ProsecutionCase),
            Self::ProsecutionCase => Some(Self::DefenseCase),
            Self::DefenseCase => Some(Self::Rebuttal),
            Self::Rebuttal => Some(Self::ClosingArguments),
            Self::ClosingArguments => Some(Self::JuryInstructions),
            Self::JuryInstructions => Some(Self::JuryDeliberation),
            Self::JuryDeliberation => Some(Self::Verdict),
            Self::Verdict => Some(Self::Sentencing),
            Self::Sentencing => Some(Self::Adjournment),
            Self::Adjournment => None,
        }
    }
    
    /// Human-readable description of the phase.
    pub fn description(&self) -> &'static str {
        match self {
            Self::PreTrial => "Pre-trial motions and preparation",
            Self::JurySelection => "Voir dire - jury selection process",
            Self::OpeningStatements => "Opening statements by both parties",
            Self::ProsecutionCase => "Prosecution presents evidence and witnesses",
            Self::DefenseCase => "Defense presents evidence and witnesses",
            Self::Rebuttal => "Rebuttal evidence and testimony",
            Self::ClosingArguments => "Closing arguments by both parties",
            Self::JuryInstructions => "Judge instructs jury on the law",
            Self::JuryDeliberation => "Jury deliberates on verdict",
            Self::Verdict => "Verdict is announced",
            Self::Sentencing => "Sentencing phase",
            Self::Adjournment => "Court is adjourned",
        }
    }
}

/// State of an active courtroom session.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CourtroomSession {
    pub id: JusticeEntityId,
    pub config: CourtroomConfig,
    pub case: Option<Case>,
    pub phase: ProceedingPhase,
    pub is_in_session: bool,
    pub is_recording: bool,
    pub started_at: Option<chrono::DateTime<chrono::Utc>>,
}

impl CourtroomSession {
    pub fn new(config: CourtroomConfig) -> Self {
        Self {
            id: JusticeEntityId::new(),
            config,
            case: None,
            phase: ProceedingPhase::PreTrial,
            is_in_session: false,
            is_recording: false,
            started_at: None,
        }
    }
    
    pub fn start_session(&mut self, case: Case) {
        self.case = Some(case);
        self.is_in_session = true;
        self.started_at = Some(chrono::Utc::now());
    }
    
    pub fn advance_phase(&mut self) -> bool {
        if let Some(next) = self.phase.next() {
            self.phase = next;
            true
        } else {
            false
        }
    }
    
    pub fn end_session(&mut self) {
        self.is_in_session = false;
        self.phase = ProceedingPhase::Adjournment;
    }
}

/// Preset courtroom configurations for common scenarios.
pub mod presets {
    use super::*;
    
    pub fn federal_district_court() -> CourtroomConfig {
        CourtroomConfig {
            name: "Federal District Court".to_string(),
            courtroom_type: CourtroomType::Federal,
            jury_size: 12,
            gallery_capacity: 100,
            dimensions: CourtroomDimensions {
                width: 25.0,
                length: 40.0,
                height: 8.0,
            },
            ..Default::default()
        }
    }
    
    pub fn state_trial_court() -> CourtroomConfig {
        CourtroomConfig {
            name: "State Trial Court".to_string(),
            courtroom_type: CourtroomType::State,
            jury_size: 12,
            gallery_capacity: 60,
            ..Default::default()
        }
    }
    
    pub fn municipal_court() -> CourtroomConfig {
        CourtroomConfig {
            name: "Municipal Court".to_string(),
            courtroom_type: CourtroomType::Municipal,
            has_jury_box: false,
            jury_size: 0,
            gallery_capacity: 30,
            dimensions: CourtroomDimensions {
                width: 15.0,
                length: 20.0,
                height: 4.0,
            },
            ..Default::default()
        }
    }
    
    pub fn moot_court() -> CourtroomConfig {
        CourtroomConfig {
            name: "Moot Court".to_string(),
            courtroom_type: CourtroomType::MootCourt,
            has_jury_box: false,
            jury_size: 0,
            gallery_capacity: 40,
            ..Default::default()
        }
    }
}
