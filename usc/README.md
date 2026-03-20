# United States Code (USC) Data

This directory contains the complete United States Code in XML format, downloaded from GovInfo.

## Structure

```
usc/
├── raw/           # Raw XML files from GovInfo (52 titles, 2.2 MB)
├── parsed/        # Parsed TOML files (future)
└── index/         # Search indexes (future)
```

## Downloaded Titles

All 52 active USC titles (as of 2023 release):

| Title | Subject | Size |
|---|---|---|
| 1 | General Provisions | 43K |
| 2 | The Congress | 43K |
| 3 | The President | 43K |
| 4 | Flag and Seal, Seat of Government, and the States | 43K |
| 5 | Government Organization and Employees | 43K |
| 6 | Domestic Security | 43K |
| 7 | Agriculture | 43K |
| 8 | Aliens and Nationality | 43K |
| 9 | Arbitration | 43K |
| 10 | Armed Forces | 43K |
| 11 | Bankruptcy | 43K |
| 12 | Banks and Banking | 43K |
| 13 | Census | 43K |
| 14 | Coast Guard | 43K |
| 15 | Commerce and Trade | 43K |
| 16 | Conservation | 43K |
| 17 | Copyrights | 43K |
| **18** | **Crimes and Criminal Procedure** | 43K |
| 19 | Customs Duties | 43K |
| 20 | Education | 43K |
| 21 | Food and Drugs | 43K |
| 22 | Foreign Relations and Intercourse | 43K |
| 23 | Highways | 43K |
| 24 | Hospitals and Asylums | 43K |
| 25 | Indians | 43K |
| 26 | Internal Revenue Code | 43K |
| **28** | **Judiciary and Judicial Procedure** | 43K |
| 29 | Labor | 43K |
| 30 | Mineral Lands and Mining | 43K |
| 31 | Money and Finance | 43K |
| 32 | National Guard | 43K |
| 33 | Navigation and Navigable Waters | 43K |
| **34** | **Crime Control and Law Enforcement** | 43K |
| 35 | Patents | 43K |
| 36 | Patriotic and National Observances | 43K |
| 37 | Pay and Allowances of the Uniformed Services | 43K |
| 38 | Veterans' Benefits | 43K |
| 39 | Postal Service | 43K |
| 40 | Public Buildings, Property, and Works | 43K |
| 41 | Public Contracts | 43K |
| **42** | **The Public Health and Welfare** | 43K |
| 43 | Public Lands | 43K |
| 44 | Public Printing and Documents | 43K |
| 45 | Railroads | 43K |
| 46 | Shipping | 43K |
| 47 | Telecommunications | 43K |
| 48 | Territories and Insular Possessions | 43K |
| 49 | Transportation | 43K |
| 50 | War and National Defense | 43K |
| 51 | National and Commercial Space Programs | 43K |
| 52 | Voting and Elections | 43K |
| 54 | National Park Service and Related Programs | 43K |

**Note:** Titles 27 and 53 are reserved/repealed and not included.

## Key Titles for Justice System

- **Title 18** — Federal crimes and criminal procedure
- **Title 28** — Federal judiciary structure and rules
- **Title 34** — Crime control and law enforcement
- **Title 42** — Civil rights and social programs

## Source

Downloaded from: https://www.govinfo.gov/content/pkg/USCODE-2023-title{N}/xml/

Release: 2023 (latest available)

## Usage

```bash
# Download all titles
cargo run -p justice-usc -- download --title all

# Download specific title
cargo run -p justice-usc -- download --title 18

# Look up citation
cargo run -p justice-usc -- cite "18 U.S.C. 1343"

# List available statutes
cargo run -p justice-usc -- list
```

## Git Handling

The `raw/` directory is **not committed to git** due to size (2.2 MB). Run the download command to populate it locally.

## Future Enhancements

1. **Full XML parsing** — Parse all titles into structured TOML
2. **Search indexing** — Tantivy full-text search across all statutes
3. **Semantic search** — Nomic Atlas embeddings for natural language queries
4. **Cross-references** — Automatic linking between related statutes
5. **Amendment tracking** — Historical changes and Public Law references
