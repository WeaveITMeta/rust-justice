use thiserror::Error;

#[derive(Error, Debug)]
pub enum UscError {
    #[error("XML parsing error: {0}")]
    XmlError(#[from] quick_xml::Error),

    #[error("IO error: {0}")]
    IoError(#[from] std::io::Error),

    #[error("TOML serialization error: {0}")]
    TomlError(#[from] toml::ser::Error),

    #[error("Invalid citation format: {0}")]
    InvalidCitation(String),

    #[error("Statute not found: {0}")]
    StatuteNotFound(String),

    #[error("Invalid title number: {0}")]
    InvalidTitle(u32),

    #[error("Invalid section number: {0}")]
    InvalidSection(u32),
}

pub type Result<T> = std::result::Result<T, UscError>;
