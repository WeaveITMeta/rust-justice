//! Resource definitions for justice simulation.
//!
//! Resources are singleton data structures that can be accessed
//! by systems in the Bevy ECS.

use serde::{Deserialize, Serialize};
use std::collections::HashMap;
use crate::entities::{Case, JusticeEntityId};
use crate::courtroom::{CourtroomConfig, CourtroomSession};
use crate::evidence::EvidenceCollection;

/// Global configuration for the justice simulation.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct JusticeConfig {
    pub simulation_speed: f32,
    pub enable_recording: bool,
    pub enable_transcription: bool,
    pub enable_ai_assistance: bool,
    pub default_courtroom: CourtroomConfig,
}

impl Default for JusticeConfig {
    fn default() -> Self {
        Self {
            simulation_speed: 1.0,
            enable_recording: true,
            enable_transcription: true,
            enable_ai_assistance: false,
            default_courtroom: CourtroomConfig::default(),
        }
    }
}

/// Registry of all active courtroom sessions.
#[derive(Debug, Clone, Default)]
pub struct SessionRegistry {
    sessions: HashMap<JusticeEntityId, CourtroomSession>,
    active_session: Option<JusticeEntityId>,
}

impl SessionRegistry {
    pub fn new() -> Self {
        Self::default()
    }
    
    pub fn register(&mut self, session: CourtroomSession) -> JusticeEntityId {
        let id = session.id;
        self.sessions.insert(id, session);
        id
    }
    
    pub fn get(&self, id: &JusticeEntityId) -> Option<&CourtroomSession> {
        self.sessions.get(id)
    }
    
    pub fn get_mut(&mut self, id: &JusticeEntityId) -> Option<&mut CourtroomSession> {
        self.sessions.get_mut(id)
    }
    
    pub fn set_active(&mut self, id: JusticeEntityId) {
        if self.sessions.contains_key(&id) {
            self.active_session = Some(id);
        }
    }
    
    pub fn active(&self) -> Option<&CourtroomSession> {
        self.active_session.and_then(|id| self.sessions.get(&id))
    }
    
    pub fn active_mut(&mut self) -> Option<&mut CourtroomSession> {
        self.active_session.and_then(|id| self.sessions.get_mut(&id))
    }
    
    pub fn remove(&mut self, id: &JusticeEntityId) -> Option<CourtroomSession> {
        if self.active_session == Some(*id) {
            self.active_session = None;
        }
        self.sessions.remove(id)
    }
}

/// Registry of all cases.
#[derive(Debug, Clone, Default)]
pub struct CaseRegistry {
    cases: HashMap<JusticeEntityId, Case>,
}

impl CaseRegistry {
    pub fn new() -> Self {
        Self::default()
    }
    
    pub fn register(&mut self, case: Case) -> JusticeEntityId {
        let id = case.id;
        self.cases.insert(id, case);
        id
    }
    
    pub fn get(&self, id: &JusticeEntityId) -> Option<&Case> {
        self.cases.get(id)
    }
    
    pub fn get_mut(&mut self, id: &JusticeEntityId) -> Option<&mut Case> {
        self.cases.get_mut(id)
    }
    
    pub fn find_by_number(&self, case_number: &str) -> Option<&Case> {
        self.cases.values().find(|c| c.case_number == case_number)
    }
    
    pub fn all(&self) -> impl Iterator<Item = &Case> {
        self.cases.values()
    }
}

/// Registry of evidence collections by case.
#[derive(Debug, Clone, Default)]
pub struct EvidenceRegistry {
    collections: HashMap<JusticeEntityId, EvidenceCollection>,
}

impl EvidenceRegistry {
    pub fn new() -> Self {
        Self::default()
    }
    
    pub fn get_or_create(&mut self, case_id: JusticeEntityId) -> &mut EvidenceCollection {
        self.collections
            .entry(case_id)
            .or_insert_with(|| EvidenceCollection::for_case(case_id))
    }
    
    pub fn get(&self, case_id: &JusticeEntityId) -> Option<&EvidenceCollection> {
        self.collections.get(case_id)
    }
}

/// Simulation time tracking.
#[derive(Debug, Clone, Default)]
pub struct SimulationTime {
    pub elapsed: f64,
    pub delta: f64,
    pub paused: bool,
    pub speed: f32,
}

impl SimulationTime {
    pub fn new() -> Self {
        Self {
            speed: 1.0,
            ..Default::default()
        }
    }
    
    pub fn tick(&mut self, delta: f64) {
        if !self.paused {
            self.delta = delta * self.speed as f64;
            self.elapsed += self.delta;
        } else {
            self.delta = 0.0;
        }
    }
    
    pub fn pause(&mut self) {
        self.paused = true;
    }
    
    pub fn resume(&mut self) {
        self.paused = false;
    }
    
    pub fn set_speed(&mut self, speed: f32) {
        self.speed = speed.max(0.0);
    }
}
