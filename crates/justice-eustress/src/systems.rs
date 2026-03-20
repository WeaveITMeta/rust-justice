//! System definitions for justice simulation.
//!
//! These are standalone functions that can be registered as Bevy systems
//! when integrating with the Eustress Engine.

use crate::resources::SimulationTime;

/// Updates the simulation time resource.
/// 
/// Register this system to run every frame:
/// ```rust,ignore
/// app.add_systems(Update, update_simulation_time);
/// ```
pub fn update_simulation_time(time: &mut SimulationTime, delta_seconds: f64) {
    time.tick(delta_seconds);
}

/// Example system for processing courtroom phase transitions.
/// 
/// This demonstrates how to structure systems for the justice simulation.
/// Actual Bevy integration would use proper system parameters.
pub mod courtroom_systems {
    use crate::courtroom::CourtroomSession;
    use crate::events::PhaseChanged;
    
    /// Checks if the current phase should advance based on conditions.
    pub fn check_phase_advancement(
        session: &mut CourtroomSession,
    ) -> Option<PhaseChanged> {
        let previous = session.phase;
        
        if session.advance_phase() {
            Some(PhaseChanged {
                session_id: session.id,
                previous_phase: previous,
                new_phase: session.phase,
            })
        } else {
            None
        }
    }
}

/// Example system for evidence management.
pub mod evidence_systems {
    use crate::evidence::{Evidence, CustodyEntry};
    use crate::events::EvidenceStatusChanged;
    
    /// Admits evidence and returns the status change event.
    pub fn admit_evidence(evidence: &mut Evidence) -> EvidenceStatusChanged {
        let previous = evidence.status;
        evidence.admit();
        
        EvidenceStatusChanged {
            evidence_id: evidence.id,
            exhibit_number: evidence.exhibit_number.clone(),
            previous_status: previous,
            new_status: evidence.status,
        }
    }
    
    /// Adds a custody entry to evidence.
    pub fn log_custody(
        evidence: &mut Evidence,
        handler: &str,
        action: &str,
        location: &str,
    ) {
        evidence.add_custody_entry(CustodyEntry::new(handler, action, location));
    }
}
