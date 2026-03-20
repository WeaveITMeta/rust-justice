//! Evidence management and visualization.
//!
//! This module handles digital evidence, chain of custody tracking,
//! and 3D visualization of evidence for courtroom presentation.

use serde::{Deserialize, Serialize};
use uuid::Uuid;
use crate::entities::JusticeEntityId;

/// Type of evidence.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, Serialize, Deserialize)]
pub enum EvidenceType {
    Physical,
    Documentary,
    Testimonial,
    Digital,
    Forensic,
    Demonstrative,
    RealEvidence,
}

/// Status of evidence in the chain of custody.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, Serialize, Deserialize, Default)]
pub enum EvidenceStatus {
    #[default]
    Collected,
    InCustody,
    Analyzed,
    Submitted,
    Admitted,
    Excluded,
    Returned,
}

/// A single entry in the chain of custody.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CustodyEntry {
    pub id: Uuid,
    pub timestamp: chrono::DateTime<chrono::Utc>,
    pub handler: String,
    pub action: String,
    pub location: String,
    pub notes: Option<String>,
    pub signature_hash: Option<String>,
}

impl CustodyEntry {
    pub fn new(handler: impl Into<String>, action: impl Into<String>, location: impl Into<String>) -> Self {
        Self {
            id: Uuid::new_v4(),
            timestamp: chrono::Utc::now(),
            handler: handler.into(),
            action: action.into(),
            location: location.into(),
            notes: None,
            signature_hash: None,
        }
    }
}

/// Chain of custody for a piece of evidence.
#[derive(Debug, Clone, Serialize, Deserialize, Default)]
pub struct ChainOfCustody {
    pub entries: Vec<CustodyEntry>,
}

impl ChainOfCustody {
    pub fn new() -> Self {
        Self { entries: Vec::new() }
    }
    
    pub fn add_entry(&mut self, entry: CustodyEntry) {
        self.entries.push(entry);
    }
    
    pub fn latest(&self) -> Option<&CustodyEntry> {
        self.entries.last()
    }
    
    pub fn is_valid(&self) -> bool {
        !self.entries.is_empty()
    }
}

/// A piece of evidence in the justice system.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Evidence {
    pub id: JusticeEntityId,
    pub exhibit_number: String,
    pub evidence_type: EvidenceType,
    pub status: EvidenceStatus,
    pub description: String,
    pub chain_of_custody: ChainOfCustody,
    pub metadata: EvidenceMetadata,
    pub visualization: Option<EvidenceVisualization>,
}

impl Evidence {
    pub fn new(exhibit_number: impl Into<String>, evidence_type: EvidenceType) -> Self {
        Self {
            id: JusticeEntityId::new(),
            exhibit_number: exhibit_number.into(),
            evidence_type,
            status: EvidenceStatus::Collected,
            description: String::new(),
            chain_of_custody: ChainOfCustody::new(),
            metadata: EvidenceMetadata::default(),
            visualization: None,
        }
    }
    
    pub fn with_description(mut self, description: impl Into<String>) -> Self {
        self.description = description.into();
        self
    }
    
    pub fn add_custody_entry(&mut self, entry: CustodyEntry) {
        self.chain_of_custody.add_entry(entry);
    }
    
    pub fn admit(&mut self) {
        self.status = EvidenceStatus::Admitted;
    }
    
    pub fn exclude(&mut self) {
        self.status = EvidenceStatus::Excluded;
    }
}

/// Metadata associated with evidence.
#[derive(Debug, Clone, Serialize, Deserialize, Default)]
pub struct EvidenceMetadata {
    pub collected_at: Option<chrono::DateTime<chrono::Utc>>,
    pub collected_by: Option<String>,
    pub location: Option<String>,
    pub case_number: Option<String>,
    pub tags: Vec<String>,
    pub file_hash: Option<String>,
    pub blockchain_tx: Option<String>,
}

/// 3D visualization configuration for evidence.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct EvidenceVisualization {
    pub model_path: Option<String>,
    pub texture_path: Option<String>,
    pub scale: (f32, f32, f32),
    pub position: (f32, f32, f32),
    pub rotation: (f32, f32, f32),
    pub is_interactive: bool,
    pub highlight_regions: Vec<HighlightRegion>,
}

impl Default for EvidenceVisualization {
    fn default() -> Self {
        Self {
            model_path: None,
            texture_path: None,
            scale: (1.0, 1.0, 1.0),
            position: (0.0, 0.0, 0.0),
            rotation: (0.0, 0.0, 0.0),
            is_interactive: true,
            highlight_regions: Vec::new(),
        }
    }
}

/// A highlighted region on evidence for presentation.
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct HighlightRegion {
    pub id: Uuid,
    pub name: String,
    pub description: String,
    pub bounds: (f32, f32, f32, f32, f32, f32), // min_x, min_y, min_z, max_x, max_y, max_z
    pub color: (f32, f32, f32, f32), // RGBA
}

/// Collection of evidence for a case.
#[derive(Debug, Clone, Serialize, Deserialize, Default)]
pub struct EvidenceCollection {
    pub case_id: Option<JusticeEntityId>,
    pub items: Vec<Evidence>,
}

impl EvidenceCollection {
    pub fn new() -> Self {
        Self::default()
    }
    
    pub fn for_case(case_id: JusticeEntityId) -> Self {
        Self {
            case_id: Some(case_id),
            items: Vec::new(),
        }
    }
    
    pub fn add(&mut self, evidence: Evidence) {
        self.items.push(evidence);
    }
    
    pub fn get_by_exhibit(&self, exhibit_number: &str) -> Option<&Evidence> {
        self.items.iter().find(|e| e.exhibit_number == exhibit_number)
    }
    
    pub fn admitted(&self) -> impl Iterator<Item = &Evidence> {
        self.items.iter().filter(|e| e.status == EvidenceStatus::Admitted)
    }
}
