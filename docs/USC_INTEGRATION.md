# Justice System — U.S. Code Integration Strategy

## The Law as Data. Searchable. Citable. Implementable.

> *Import the entire United States Code as a submodule. Use AI to parse, index, and connect statutes to live systems. Keep it updated. Make it accessible to everyone.*

---

## Why the U.S. Code as Data

The United States Code is the codification of all general and permanent federal statutes. It contains:

- **54 titles** covering everything from agriculture to war
- **Thousands of sections** defining crimes, rights, procedures, and agencies
- **Continuous amendments** through each session of Congress

Currently, legal professionals search the U.S.C. through fragmented tools — Westlaw, LexisNexis, Congress.gov — all proprietary, expensive, or difficult to integrate. By importing the U.S.C. as structured data into this codebase, we make it:

1. **Free** — Open source, no subscription required
2. **Searchable** — Full-text and semantic search in milliseconds
3. **Citable** — Proper citation generation and validation
4. **Implementable** — AI agents can read statutes and apply them to cases
5. **Connected** — Statutes link to court data, case law, and live proceedings
6. **Current** — Submodule tracks the latest official release

---

## Data Source

### Official Source: Office of the Law Revision Counsel

The U.S. Code is maintained by the **Office of the Law Revision Counsel** (OLRC) of the U.S. House of Representatives.

- **Website:** https://uscode.house.gov
- **Bulk Data:** https://uscode.house.gov/download/download.shtml
- **Format:** USLM XML (United States Legislative Markup)
- **License:** Public domain (U.S. government work)
- **Update Frequency:** Annual release points; supplements throughout the year

### XML Structure

The OLRC provides the U.S.C. in USLM XML format:

```xml
<usc>
  <title identifier="/us/usc/t18">
    <heading>Crimes and Criminal Procedure</heading>
    <part identifier="/us/usc/t18/ptI">
      <heading>Crimes</heading>
      <chapter identifier="/us/usc/t18/ptI/ch1">
        <heading>General Provisions</heading>
        <section identifier="/us/usc/t18/s1">
          <heading>Treason</heading>
          <content>
            Whoever, owing allegiance to the United States, levies war 
            against them or adheres to their enemies, giving them aid 
            and comfort within the United States or elsewhere, is guilty 
            of treason and shall suffer death, or shall be imprisoned 
            not less than five years...
          </content>
          <sourceCredit>(June 25, 1948, ch. 645, 62 Stat. 683...)</sourceCredit>
        </section>
      </chapter>
    </part>
  </title>
</usc>
```

---

## Submodule Strategy

### Repository Structure

```
rust-justice/
  usc/                          # Git submodule
    README.md
    raw/                        # Raw XML from OLRC
      titles/
        t01.xml                 # Title 1: General Provisions
        t02.xml                 # Title 2: The Congress
        ...
        t18.xml                 # Title 18: Crimes and Criminal Procedure
        t28.xml                 # Title 28: Judiciary and Judicial Procedure
        ...
        t54.xml                 # Title 54: National Park Service
    parsed/                     # Parsed TOML/JSON output
      titles/
        t18/
          index.toml            # Title index
          chapters/
            ch001.toml          # Chapter 1: General Provisions
            ch047.toml          # Chapter 47: Fraud
            ...
        t28/
          index.toml
          chapters/
            ch005.toml          # Chapter 5: District Courts
            ...
    index/                      # Search indexes
      full_text.tantivy/        # Tantivy full-text search index
      embeddings.bin            # Semantic embeddings (Nomic Atlas)
    metadata/
      version.toml              # Current USC release version
      changelog.toml            # Amendment tracking
      citations.toml            # Cross-reference map
```

### Git Submodule Setup

```bash
# Create the USC repository
git init usc-data
cd usc-data

# Download latest XML from OLRC
curl -O https://uscode.house.gov/download/releasepoints/us/usc-xml.zip
unzip usc-xml.zip -d raw/titles/

# Commit raw data
git add raw/
git commit -m "Import USC release point 2026-01"

# Add as submodule to rust-justice
cd ../rust-justice
git submodule add https://github.com/WeaveITMeta/usc-data.git usc
git commit -m "Add USC data as submodule"
```

### Updating the Submodule

```bash
# When OLRC releases new data:
cd rust-justice/usc
git fetch origin
git checkout latest-release

# Re-parse
cd ..
cargo run -p justice-usc -- parse --input usc/raw --output usc/parsed

# Re-index
cargo run -p justice-usc -- index --input usc/parsed --output usc/index

# Commit updated submodule reference
cd ..
git add usc
git commit -m "Update USC to 2026-Q2 release"
```

---

## Parser: XML to TOML

### justice-usc Crate: Parse Pipeline

```
OLRC XML --> quick-xml parser --> Rust structs --> TOML serialization
                                                --> Tantivy indexing
                                                --> Embedding generation
```

### Parsed TOML Output

```toml
# usc/parsed/titles/t18/chapters/ch047.toml

[chapter]
title = 18
part = "I"
chapter = 47
heading = "Fraud and False Statements"
sections = [1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010,
            1011, 1012, 1013, 1014, 1015, 1016, 1017, 1018, 1019, 1020,
            1021, 1022, 1023, 1024, 1025, 1026, 1027, 1028, 1029, 1030,
            1031, 1032, 1033, 1034, 1035, 1036, 1037, 1038, 1039, 1040]

[[sections]]
number = 1343
heading = "Fraud by wire, radio, or television"
citation = "18 U.S.C. section 1343"
text = """
Whoever, having devised or intending to devise any scheme or artifice to \
defraud, or for obtaining money or property by means of false or fraudulent \
pretenses, representations, or promises, transmits or causes to be \
transmitted by means of wire, radio, or television communication in \
interstate or foreign commerce, any writings, signs, signals, pictures, \
or sounds for the purpose of executing such scheme or artifice, shall be \
fined under this title or imprisoned not more than 20 years, or both. \
If the violation occurs in relation to, or involving any benefit authorized, \
transported, transmitted, transferred, disbursed, or paid in connection \
with, a presidentially declared major disaster or emergency, or affects \
a financial institution, such person shall be fined not more than \
$1,000,000 or imprisoned not more than 30 years, or both."""

[sections.penalties]
fine = "Under this title"
imprisonment_max_years = 20
imprisonment_max_years_aggravated = 30
fine_aggravated = 1_000_000
aggravating_factors = [
    "Presidentially declared major disaster or emergency",
    "Affects a financial institution"
]

[sections.elements]
# Elements the prosecution must prove
actus_reus = [
    "Devised or intended to devise a scheme to defraud",
    "Transmitted via wire, radio, or television",
    "In interstate or foreign commerce"
]
mens_rea = "Intent to defraud"
jurisdictional_element = "Interstate or foreign commerce"

[sections.source]
enacted = "1952-07-16"
statute = "Pub. L. 82-514"
last_amended = "2009-05-20"
amendment_history = [
    { date = "2002-07-30", public_law = "107-204", description = "Increased max imprisonment from 5 to 20 years" },
    { date = "2009-05-20", public_law = "111-21", description = "Added disaster/emergency aggravating factor" }
]

[sections.cross_references]
related_statutes = [
    "18 U.S.C. 1341",   # Mail fraud
    "18 U.S.C. 1344",   # Bank fraud
    "18 U.S.C. 1346",   # Honest services fraud
    "18 U.S.C. 1349",   # Attempt and conspiracy
]
sentencing_guidelines = "USSG 2B1.1"

[sections.tags]
categories = ["fraud", "wire-fraud", "financial-crime", "federal-crime"]
commonly_charged_with = ["1341", "1349", "1956", "1957"]
```

---

## AI Heuristics Engine

### How AI Uses the U.S. Code

The parsed, structured U.S.C. data enables AI agents to perform sophisticated legal analysis:

#### 1. Charge Element Matching

When an AI agent receives case evidence, it can match facts to statutory elements:

```
EVIDENCE: "Defendant sent email containing false financial statements
           to investor in another state"

AI ANALYSIS:
  Statute: 18 U.S.C. section 1343 (Wire Fraud)
  Element Check:
    [x] Scheme to defraud: False financial statements = scheme
    [x] Wire transmission: Email = wire communication
    [x] Interstate commerce: Different states = interstate
    [x] Intent to defraud: Sent to investor = purpose of obtaining money
  
  Match Confidence: 94%
  
  Related charges to consider:
    - 18 U.S.C. section 1341 (Mail fraud, if postal mail also used)
    - 18 U.S.C. section 1349 (Conspiracy, if multiple actors)
    - 15 U.S.C. section 78j (Securities fraud, if securities involved)
```

#### 2. Sentencing Guidelines Lookup

```
CONVICTION: 18 U.S.C. section 1343
LOSS AMOUNT: $2,500,000

AI ANALYSIS:
  Base Offense Level (USSG 2B1.1): 7
  Loss Enhancement ($2.5M = +16): 23
  Adjustments:
    - Sophisticated means: +2
    - Multiple victims: +2 (if applicable)
  
  Total Offense Level: 25-27
  Criminal History Category: I (first offense assumed)
  
  Sentencing Range: 57-71 months (Level 25, Cat I)
                    70-87 months (Level 27, Cat I)
  
  Fine Range: $15,000 - $150,000
  Restitution: Mandatory (18 U.S.C. section 3663A)
  
  Note: Statutory maximum is 20 years (240 months)
```

#### 3. Constitutional Compliance Check

```
PROPOSED ACTION: Warrantless search of defendant's email records

AI ANALYSIS:
  4th Amendment: "The right of the people to be secure in their
                  persons, houses, papers, and effects, against
                  unreasonable searches and seizures"
  
  Relevant Case Law:
    - Carpenter v. United States, 585 U.S. 296 (2018)
      "Individuals have a reasonable expectation of privacy
       in cell-site location information"
    - Riley v. California, 573 U.S. 373 (2014)
      "Police generally need a warrant to search a cell phone"
    - United States v. Warshak, 631 F.3d 266 (6th Cir. 2010)
      "Email has equivalent 4th Amendment protection as
       traditional mail"
  
  FINDING: Warrant required. Warrantless search would likely
           violate 4th Amendment. Obtain warrant supported by
           probable cause per 18 U.S.C. section 2703.
  
  Exceptions to consider:
    - Exigent circumstances
    - Consent
    - Third-party doctrine (limited post-Carpenter)
```

#### 4. Statute Comparison: Federal vs. State

```
QUERY: "Compare federal wire fraud with Arizona fraud statutes"

AI ANALYSIS:
  Federal: 18 U.S.C. section 1343 - Wire Fraud
    - Max: 20 years imprisonment
    - Requires interstate wire communication
    - Federal jurisdiction
  
  Arizona: ARS 13-2310 - Fraudulent Schemes and Artifices
    - Class 2 Felony
    - Max: 12.5 years imprisonment
    - No interstate element required
    - State jurisdiction
  
  Key Differences:
    1. Jurisdictional element (interstate vs. intrastate)
    2. Penalty range (federal more severe)
    3. Federal requires specific "wire" communication
    4. Arizona broader: "any" scheme or artifice
  
  Prosecution Strategy Note:
    If conduct is purely intrastate, state charges may be easier.
    If interstate wire used, federal charges carry higher penalties.
    Dual sovereignty: both can prosecute (Gamble v. U.S., 2019).
```

---

## Search Implementation

### Full-Text Search (Tantivy)

```rust
// justice-usc/src/search.rs

use tantivy::{Index, schema::*, collector::TopDocs, query::QueryParser};

pub struct UscSearchEngine {
    index: Index,
    reader: IndexReader,
}

impl UscSearchEngine {
    /// Search across all titles
    pub fn search(&self, query: &str, limit: usize) -> Vec<StatuteResult> {
        let searcher = self.reader.searcher();
        let query_parser = QueryParser::for_index(
            &self.index,
            vec![
                self.index.schema().get_field("heading").unwrap(),
                self.index.schema().get_field("text").unwrap(),
                self.index.schema().get_field("tags").unwrap(),
            ],
        );
        let query = query_parser.parse_query(query).unwrap();
        let top_docs = searcher.search(&query, &TopDocs::with_limit(limit)).unwrap();
        // ... convert to StatuteResult
        todo!()
    }

    /// Exact citation lookup: "18 U.S.C. 1343"
    pub fn cite(&self, citation: &str) -> Option<Statute> {
        let parsed = CitationParser::parse(citation)?;
        // Direct lookup by title + section
        todo!()
    }
}
```

### Semantic Search (Nomic Atlas Embeddings)

```rust
// justice-usc/src/semantic.rs

pub struct SemanticSearch {
    embeddings: Vec<(String, Vec<f32>)>,  // (citation, embedding)
    nomic_client: NomicClient,
}

impl SemanticSearch {
    /// "laws about identity theft" -> most relevant statutes
    pub async fn search(&self, query: &str, limit: usize) -> Vec<StatuteResult> {
        // 1. Generate query embedding via Nomic API
        let query_embedding = self.nomic_client.embed(query).await;

        // 2. Cosine similarity against all statute embeddings
        let mut scored: Vec<_> = self.embeddings.iter()
            .map(|(citation, emb)| {
                let score = cosine_similarity(&query_embedding, emb);
                (citation.clone(), score)
            })
            .collect();

        // 3. Sort by score descending, take top N
        scored.sort_by(|a, b| b.1.partial_cmp(&a.1).unwrap());
        scored.truncate(limit);

        // 4. Fetch full statute data for top results
        todo!()
    }
}
```

### Citation Parser

```rust
// justice-usc/src/citation.rs

/// Parses legal citations into structured form
pub struct CitationParser;

impl CitationParser {
    /// Parse various citation formats:
    /// - "18 U.S.C. section 1343"
    /// - "18 USC 1343"
    /// - "18 U.S.C. 1343(a)(1)"
    /// - "Title 18, Section 1343"
    pub fn parse(input: &str) -> Option<Citation> {
        // Regex-based parser for standard citation formats
        todo!()
    }
}

pub struct Citation {
    pub title: u32,
    pub section: u32,
    pub subsection: Option<String>,  // "(a)(1)"
    pub canonical: String,           // "18 U.S.C. section 1343(a)(1)"
}
```

---

## CLI Interface

```bash
# Search for statutes
justice-cli usc search "wire fraud"
# Output:
#   18 U.S.C. section 1343 - Fraud by wire, radio, or television
#   18 U.S.C. section 1349 - Attempt and conspiracy (fraud)
#   18 U.S.C. section 1341 - Frauds and swindles (mail fraud)

# Look up a specific citation
justice-cli usc cite "18 USC 1343"
# Output: Full statute text, elements, penalties, cross-references

# Get AI explanation in plain language
justice-cli usc explain "18 USC 1343"
# Output: "Wire fraud is a federal crime that makes it illegal to use
#          electronic communications (phone, email, internet) as part
#          of a scheme to defraud someone of money or property..."

# Find related statutes
justice-cli usc related "18 USC 1343" --limit 5

# Compare federal and state
justice-cli usc compare "18 USC 1343" "ARS 13-2310"

# Search by topic using AI
justice-cli usc semantic "laws protecting children from online exploitation"
```

---

## Key Titles for Justice System

| Title | Subject | Relevance |
|---|---|---|
| **Title 5** | Government Organization | Federal agency structure |
| **Title 10** | Armed Forces | Military justice (UCMJ) |
| **Title 15** | Commerce and Trade | Securities fraud, consumer protection |
| **Title 18** | Crimes and Criminal Procedure | **Primary criminal law** |
| **Title 21** | Food and Drugs | Drug offenses (DEA) |
| **Title 26** | Internal Revenue Code | Tax fraud |
| **Title 28** | Judiciary and Judicial Procedure | **Court structure and rules** |
| **Title 34** | Crime Control and Law Enforcement | OJP, BJA, victims rights |
| **Title 42** | Public Health and Welfare | Civil rights, social programs |
| **Title 47** | Telecommunications | FCC, communications law |
| **Title 52** | Voting and Elections | Election crimes |

### Priority Parse Order

1. **Title 18** — All federal crimes and criminal procedure
2. **Title 28** — Federal judiciary structure and rules
3. **Title 42** — Civil rights provisions
4. **Title 34** — Crime control and law enforcement
5. All remaining titles

---

## State Code Integration

The same architecture extends to state codes. Starting with Arizona:

### Arizona Revised Statutes (ARS)

```
usc/
  states/
    arizona/
      raw/                    # Source data from azleg.gov
      parsed/
        titles/
          t13/                # Title 13: Criminal Code
            index.toml
            chapters/
              ch01.toml       # General provisions
              ch11.toml       # Homicide
              ch14.toml       # Sexual offenses
              ch23.toml       # Fraud
              ...
          t12/                # Title 12: Courts and Civil Proceedings
          t28/                # Title 28: Transportation
          ...
      index/
        full_text.tantivy/
        embeddings.bin
```

### State Code Sources

| State | Source | Format |
|---|---|---|
| Arizona | azleg.gov | HTML (scraping required) |
| California | leginfo.legislature.ca.gov | XML |
| Texas | statutes.capitol.texas.gov | XML |
| New York | nysenate.gov/legislation/laws | HTML/API |
| Florida | leg.state.fl.us | HTML |

Each state has different data formats. The `justice-usc` crate will have state-specific parsers:

```rust
pub trait StatuteParser {
    fn parse_title(&self, raw: &[u8]) -> Result<Title>;
    fn parse_section(&self, raw: &[u8]) -> Result<Section>;
    fn source_format(&self) -> DataFormat;
}

pub enum DataFormat {
    UslmXml,     // Federal USC
    GenericXml,  // CA, TX
    Html,        // AZ, NY, FL
    Json,        // Some modern states
}
```

---

## Update Automation

### Automated USC Updates via CI

```yaml
# .github/workflows/usc-update.yml
name: Update U.S. Code

on:
  schedule:
    - cron: '0 6 1 * *'  # First of each month at 6 AM UTC
  workflow_dispatch:       # Manual trigger

jobs:
  update-usc:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          submodules: true

      - name: Check for OLRC updates
        run: |
          # Check OLRC release page for new data
          # Compare with current version in usc/metadata/version.toml

      - name: Download if updated
        run: |
          # Download new XML
          # Update raw/ directory

      - name: Parse
        run: cargo run -p justice-usc -- parse

      - name: Index
        run: cargo run -p justice-usc -- index

      - name: Test
        run: cargo test -p justice-usc

      - name: Create PR
        run: |
          # Commit changes
          # Create PR with changelog
```

---

## Metrics

| Metric | Target |
|---|---|
| All 54 titles parsed | 100% |
| Full-text search latency | < 50ms |
| Semantic search latency | < 500ms (includes API call) |
| Citation parse accuracy | 99%+ |
| Update lag behind OLRC | < 30 days |
| Arizona statutes parsed | 100% of criminal code (Title 13) |
| States with parsed codes | 10+ by Phase 9 |

---

*Document Version: 1.0.0*
*Last Updated: March 2026*
*Part of the Justice System Open-Source Framework*
