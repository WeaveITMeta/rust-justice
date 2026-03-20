//! Networking support for multiplayer courtroom sessions.
//!
//! This module provides structures for synchronizing courtroom
//! state across multiple participants in networked sessions.

use serde::{Deserialize, Serialize};
use crate::entities::{JusticeEntityId, CourtroomRole};

/// Network message types for courtroom synchronization.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum CourtroomMessage {
    /// Player joined the session
    PlayerJoined(PlayerInfo),
    /// Player left the session
    PlayerLeft(JusticeEntityId),
    /// Player assigned to a role
    RoleAssigned { player_id: JusticeEntityId, role: CourtroomRole },
    /// Speech/dialogue from a participant
    Speech { speaker_id: JusticeEntityId, content: String },
    /// Phase transition
    PhaseChange(crate::courtroom::ProceedingPhase),
    /// Evidence presented
    EvidenceAction(EvidenceNetworkAction),
    /// Objection raised
    Objection(crate::events::ObjectionType),
    /// Ruling made
    Ruling(crate::events::ObjectionRuling),
    /// Session state sync
    StateSync(SessionState),
}

/// Information about a connected player.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PlayerInfo {
    pub id: JusticeEntityId,
    pub name: String,
    pub role: Option<CourtroomRole>,
    pub is_host: bool,
    pub joined_at: chrono::DateTime<chrono::Utc>,
}

impl PlayerInfo {
    pub fn new(name: impl Into<String>) -> Self {
        Self {
            id: JusticeEntityId::new(),
            name: name.into(),
            role: None,
            is_host: false,
            joined_at: chrono::Utc::now(),
        }
    }
    
    pub fn as_host(mut self) -> Self {
        self.is_host = true;
        self
    }
}

/// Network actions for evidence.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum EvidenceNetworkAction {
    Present { exhibit_number: String },
    Highlight { exhibit_number: String, region_id: uuid::Uuid },
    Admit { exhibit_number: String },
    Exclude { exhibit_number: String },
}

/// Serializable session state for network sync.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SessionState {
    pub session_id: JusticeEntityId,
    pub phase: crate::courtroom::ProceedingPhase,
    pub players: Vec<PlayerInfo>,
    pub current_speaker: Option<JusticeEntityId>,
    pub presented_evidence: Vec<String>,
}

/// Configuration for a networked courtroom session.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct NetworkSessionConfig {
    pub max_players: u8,
    pub require_all_roles: bool,
    pub allow_spectators: bool,
    pub host_controls_phase: bool,
    pub sync_rate_hz: u32,
}

impl Default for NetworkSessionConfig {
    fn default() -> Self {
        Self {
            max_players: 16,
            require_all_roles: false,
            allow_spectators: true,
            host_controls_phase: true,
            sync_rate_hz: 20,
        }
    }
}

/// Lobby for players waiting to join a session.
#[derive(Debug, Clone, Default)]
pub struct SessionLobby {
    pub players: Vec<PlayerInfo>,
    pub available_roles: Vec<CourtroomRole>,
    pub config: NetworkSessionConfig,
}

impl SessionLobby {
    pub fn new(config: NetworkSessionConfig) -> Self {
        Self {
            players: Vec::new(),
            available_roles: vec![
                CourtroomRole::Judge,
                CourtroomRole::Prosecutor,
                CourtroomRole::DefenseAttorney,
                CourtroomRole::Witness,
                CourtroomRole::JuryMember,
            ],
            config,
        }
    }
    
    pub fn add_player(&mut self, player: PlayerInfo) -> bool {
        if self.players.len() < self.config.max_players as usize {
            self.players.push(player);
            true
        } else {
            false
        }
    }
    
    pub fn remove_player(&mut self, player_id: &JusticeEntityId) {
        self.players.retain(|p| &p.id != player_id);
    }
    
    pub fn assign_role(&mut self, player_id: &JusticeEntityId, role: CourtroomRole) -> bool {
        if let Some(player) = self.players.iter_mut().find(|p| &p.id == player_id) {
            player.role = Some(role);
            true
        } else {
            false
        }
    }
    
    pub fn is_ready(&self) -> bool {
        if self.config.require_all_roles {
            let assigned_roles: Vec<_> = self.players.iter().filter_map(|p| p.role).collect();
            self.available_roles.iter().all(|r| assigned_roles.contains(r))
        } else {
            !self.players.is_empty() && self.players.iter().any(|p| p.is_host)
        }
    }
}
