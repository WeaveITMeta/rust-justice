//! # Justice-Eustress Integration Crate
//!
//! This crate provides justice-centric additions for the Eustress Engine,
//! enabling 3D simulation of courtrooms, evidence visualization, and
//! training scenarios for the U.S. Justice System.
//!
//! ## Architecture
//!
//! The crate is designed to be **separate from the Eustress Engine** to:
//! - Receive upstream Eustress updates without conflicts
//! - Keep justice-specific logic modular and maintainable
//! - Allow independent versioning and releases
//!
//! ## Features
//!
//! - `courtroom` - Courtroom environment components and systems
//! - `evidence` - Evidence visualization and chain of custody
//! - `training` - Training scenario management
//! - `networking` - Multiplayer courtroom sessions
//! - `full` - All features enabled
//!
//! ## Usage
//!
//! ```rust,ignore
//! use justice_eustress::prelude::*;
//!
//! fn main() {
//!     App::new()
//!         .add_plugins(DefaultPlugins)
//!         .add_plugins(JusticePlugins)
//!         .run();
//! }
//! ```

pub mod courtroom;
pub mod evidence;
pub mod entities;
pub mod events;
pub mod resources;
pub mod systems;

#[cfg(feature = "training")]
pub mod training;

#[cfg(feature = "networking")]
pub mod networking;

pub mod prelude {
    //! Convenient re-exports for common justice-eustress types.
    
    pub use crate::courtroom::*;
    pub use crate::evidence::*;
    pub use crate::entities::*;
    pub use crate::events::*;
    pub use crate::resources::*;
    
    #[cfg(feature = "training")]
    pub use crate::training::*;
    
    #[cfg(feature = "networking")]
    pub use crate::networking::*;
}
