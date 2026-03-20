use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Title {
    pub number: u32,
    pub heading: String,
    pub chapters: Vec<Chapter>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Chapter {
    pub number: u32,
    pub heading: String,
    pub sections: Vec<Section>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Section {
    pub number: u32,
    pub heading: String,
    pub text: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub subsections: Option<Vec<Subsection>>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub source_credit: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub notes: Option<Vec<String>>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Subsection {
    pub designation: String,
    pub text: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Citation {
    pub title: u32,
    pub section: u32,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub subsection: Option<String>,
    pub canonical: String,
}

impl Citation {
    pub fn new(title: u32, section: u32, subsection: Option<String>) -> Self {
        let canonical = if let Some(ref sub) = subsection {
            format!("{} U.S.C. § {}({})", title, section, sub)
        } else {
            format!("{} U.S.C. § {}", title, section)
        };
        
        Self {
            title,
            section,
            subsection,
            canonical,
        }
    }
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct StatuteResult {
    pub citation: Citation,
    pub heading: String,
    pub text: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub score: Option<f32>,
}
