use crate::{Citation, UscError, Result};
use std::collections::HashMap;

pub struct CitationParser;

impl CitationParser {
    pub fn parse(input: &str) -> Result<Citation> {
        let input = input.trim();
        
        let patterns = [
            r"(\d+)\s+U\.?S\.?C\.?\s+§?\s*(\d+)(?:\(([a-z0-9]+)\))?",
            r"(\d+)\s+USC\s+§?\s*(\d+)(?:\(([a-z0-9]+)\))?",
            r"Title\s+(\d+),?\s+Section\s+(\d+)(?:\(([a-z0-9]+)\))?",
        ];
        
        for pattern in &patterns {
            if let Some(caps) = regex::Regex::new(pattern)
                .ok()
                .and_then(|re| re.captures(input))
            {
                let title: u32 = caps.get(1)
                    .and_then(|m| m.as_str().parse().ok())
                    .ok_or_else(|| UscError::InvalidCitation(input.to_string()))?;
                
                let section: u32 = caps.get(2)
                    .and_then(|m| m.as_str().parse().ok())
                    .ok_or_else(|| UscError::InvalidCitation(input.to_string()))?;
                
                let subsection = caps.get(3).map(|m| m.as_str().to_string());
                
                return Ok(Citation::new(title, section, subsection));
            }
        }
        
        Err(UscError::InvalidCitation(input.to_string()))
    }
}

pub struct StatuteIndex {
    statutes: HashMap<String, String>,
}

impl StatuteIndex {
    pub fn new() -> Self {
        let mut statutes = HashMap::new();
        
        statutes.insert(
            "18-1343".to_string(),
            include_str!("../data/18-1343.toml").to_string(),
        );
        
        statutes.insert(
            "18-1341".to_string(),
            include_str!("../data/18-1341.toml").to_string(),
        );
        
        Self { statutes }
    }
    
    pub fn lookup(&self, citation: &Citation) -> Result<String> {
        let key = format!("{}-{}", citation.title, citation.section);
        self.statutes
            .get(&key)
            .cloned()
            .ok_or_else(|| UscError::StatuteNotFound(citation.canonical.clone()))
    }
}

impl Default for StatuteIndex {
    fn default() -> Self {
        Self::new()
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_parse_standard_format() {
        let citation = CitationParser::parse("18 U.S.C. § 1343").unwrap();
        assert_eq!(citation.title, 18);
        assert_eq!(citation.section, 1343);
        assert_eq!(citation.subsection, None);
    }

    #[test]
    fn test_parse_with_subsection() {
        let citation = CitationParser::parse("18 U.S.C. § 1343(a)").unwrap();
        assert_eq!(citation.title, 18);
        assert_eq!(citation.section, 1343);
        assert_eq!(citation.subsection, Some("a".to_string()));
    }

    #[test]
    fn test_parse_short_format() {
        let citation = CitationParser::parse("18 USC 1343").unwrap();
        assert_eq!(citation.title, 18);
        assert_eq!(citation.section, 1343);
    }
}
