//! Training scenario management.
//!
//! This module provides structures for creating and managing
//! training scenarios for justice system professionals.

use serde::{Deserialize, Serialize};
use crate::entities::JusticeEntityId;
use crate::courtroom::CourtroomConfig;

/// Type of training scenario.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, Serialize, Deserialize)]
pub enum ScenarioType {
    JudgeTraining,
    AttorneyTraining,
    WitnessExamination,
    JurySelection,
    EvidencePresentation,
    ObjectionPractice,
    SentencingGuidelines,
    DeEscalation,
    CourtProcedure,
    Custom,
}

/// Difficulty level for training scenarios.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, Serialize, Deserialize, Default)]
pub enum Difficulty {
    Beginner,
    #[default]
    Intermediate,
    Advanced,
    Expert,
}

/// A training scenario configuration.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TrainingScenario {
    pub id: JusticeEntityId,
    pub name: String,
    pub description: String,
    pub scenario_type: ScenarioType,
    pub difficulty: Difficulty,
    pub duration_minutes: u32,
    pub courtroom_config: CourtroomConfig,
    pub objectives: Vec<LearningObjective>,
    pub checkpoints: Vec<Checkpoint>,
}

impl TrainingScenario {
    pub fn new(name: impl Into<String>, scenario_type: ScenarioType) -> Self {
        Self {
            id: JusticeEntityId::new(),
            name: name.into(),
            description: String::new(),
            scenario_type,
            difficulty: Difficulty::default(),
            duration_minutes: 30,
            courtroom_config: CourtroomConfig::default(),
            objectives: Vec::new(),
            checkpoints: Vec::new(),
        }
    }
}

/// A learning objective for a training scenario.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct LearningObjective {
    pub id: JusticeEntityId,
    pub description: String,
    pub is_required: bool,
    pub completed: bool,
}

/// A checkpoint in a training scenario.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Checkpoint {
    pub id: JusticeEntityId,
    pub name: String,
    pub description: String,
    pub trigger_condition: String,
    pub feedback: String,
}

/// Progress tracking for a training session.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TrainingProgress {
    pub scenario_id: JusticeEntityId,
    pub user_id: String,
    pub started_at: chrono::DateTime<chrono::Utc>,
    pub completed_at: Option<chrono::DateTime<chrono::Utc>>,
    pub objectives_completed: Vec<JusticeEntityId>,
    pub checkpoints_reached: Vec<JusticeEntityId>,
    pub score: Option<u32>,
    pub feedback: Vec<String>,
}

impl TrainingProgress {
    pub fn new(scenario_id: JusticeEntityId, user_id: impl Into<String>) -> Self {
        Self {
            scenario_id,
            user_id: user_id.into(),
            started_at: chrono::Utc::now(),
            completed_at: None,
            objectives_completed: Vec::new(),
            checkpoints_reached: Vec::new(),
            score: None,
            feedback: Vec::new(),
        }
    }
    
    pub fn complete_objective(&mut self, objective_id: JusticeEntityId) {
        if !self.objectives_completed.contains(&objective_id) {
            self.objectives_completed.push(objective_id);
        }
    }
    
    pub fn reach_checkpoint(&mut self, checkpoint_id: JusticeEntityId) {
        if !self.checkpoints_reached.contains(&checkpoint_id) {
            self.checkpoints_reached.push(checkpoint_id);
        }
    }
    
    pub fn finish(&mut self, score: u32) {
        self.completed_at = Some(chrono::Utc::now());
        self.score = Some(score);
    }
}
