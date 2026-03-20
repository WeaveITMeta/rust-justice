# Justice System — Interactive Court Map

## Every Court. Every Jurisdiction. One Map.

> *Citizens shouldn't have to guess where to go. An interactive map of every federal, state, and municipal court in the United States — searchable by location, case type, and jurisdiction — built in Rust/WASM.*

---

## Overview

The Interactive Court Map is a core public-facing feature of the Justice website. It provides:

1. **Visual discovery** — See all courts on a map, zoom to your area
2. **Search** — Find courts by address, zip code, county, or case type
3. **Information** — Hours, phone, filing instructions, fee schedules, services
4. **Navigation** — Constitutional grounding for each court level
5. **Accessibility** — Screen-reader friendly, keyboard navigable, multi-language

---

## Constitutional Foundation

### Article III — The Judicial Power

The U.S. court system exists because of Article III, Section 1 of the Constitution:

> *"The judicial Power of the United States, shall be vested in one supreme Court, and in such inferior Courts as the Congress may from time to time ordain and establish."*

This creates the federal judiciary. State courts derive authority from their respective state constitutions, operating in parallel with the federal system.

### Court Hierarchy

```
FEDERAL SYSTEM                          STATE SYSTEM (per state)
                                        
U.S. Supreme Court (1)                  State Supreme Court (1)
        |                                       |
U.S. Courts of Appeals (13 circuits)    State Appellate Courts
        |                                       |
U.S. District Courts (94 districts)     Trial Courts (Superior/Circuit/District)
        |                                       |
U.S. Bankruptcy Courts                  Specialized Courts
U.S. Magistrate Courts                    - Family Court
                                          - Juvenile Court
Specialized Federal Courts                - Probate Court
  - U.S. Tax Court                        - Drug Court
  - U.S. Court of Federal Claims          - Mental Health Court
  - U.S. Court of International Trade     |
  - U.S. Court of Appeals (Fed Circuit)  Municipal/Justice Courts
  - Military Courts                       - Traffic Court
                                          - Small Claims Court
```

---

## Map Data Model

### Court Location Schema

```toml
# courts/federal/districts/az.toml

[[courts]]
id = "azd"
name = "United States District Court for the District of Arizona"
type = "federal-district"
circuit = "9th"

[courts.jurisdiction]
geographic = "State of Arizona"
subject_matter = ["federal-criminal", "federal-civil", "bankruptcy", "immigration"]

[[courts.locations]]
name = "Phoenix Courthouse"
address = "401 W. Washington St., Phoenix, AZ 85003"
coordinates = { lat = 33.4484, lon = -112.0773 }
phone = "(602) 322-7200"
fax = "(602) 322-7201"
website = "https://www.azd.uscourts.gov"

[courts.locations.hours]
weekdays = "8:00 AM - 5:00 PM"
weekends = "Closed"
holidays = "Federal holidays closed"

[courts.locations.services]
filing = true
clerk_office = true
self_help_center = true
interpreter = true
ada_accessible = true
parking = "Underground garage, metered street"
public_transit = "Valley Metro Light Rail - Washington/Central station"

[[courts.locations]]
name = "Tucson Courthouse"
address = "405 W. Congress St., Tucson, AZ 85701"
coordinates = { lat = 32.2217, lon = -110.9747 }
phone = "(520) 205-4200"
website = "https://www.azd.uscourts.gov"

[courts.locations.hours]
weekdays = "8:00 AM - 5:00 PM"
weekends = "Closed"

[courts.locations.services]
filing = true
clerk_office = true
self_help_center = false
interpreter = true
ada_accessible = true
```

```toml
# courts/states/arizona/superior/maricopa.toml

[[courts]]
id = "az-maricopa-superior"
name = "Maricopa County Superior Court"
type = "state-superior"
state = "AZ"
county = "Maricopa"

[courts.jurisdiction]
geographic = "Maricopa County"
subject_matter = [
    "criminal-felony",
    "civil-unlimited",
    "family",
    "juvenile",
    "probate",
    "tax",
    "mental-health"
]
population_served = 4_420_568

[[courts.locations]]
name = "Central Court Building"
address = "201 W. Jefferson St., Phoenix, AZ 85003"
coordinates = { lat = 33.4469, lon = -112.0774 }
phone = "(602) 506-3204"
website = "https://superiorcourt.maricopa.gov"

[courts.locations.hours]
weekdays = "8:00 AM - 5:00 PM"
weekends = "Closed"

[courts.locations.services]
filing = true
clerk_office = true
self_help_center = true
law_library = true
interpreter = true
ada_accessible = true
mediation = true
parking = "Garage at 1st Ave and Jefferson"

[courts.locations.filing]
electronic = true
e_filing_url = "https://www.turbocourt.com/go.jsp?act=actTCIndex&tmstp=&id=48002"
paper_filing = true
filing_fees = "https://superiorcourt.maricopa.gov/clerk-of-court/filing-fees/"

[[courts.locations]]
name = "Southeast Facility"
address = "222 E. Javelina Ave., Mesa, AZ 85210"
coordinates = { lat = 33.3943, lon = -111.8315 }
phone = "(602) 506-2222"

[courts.locations.hours]
weekdays = "8:00 AM - 5:00 PM"

[[courts.locations]]
name = "Northwest Facility"
address = "14264 W. Tierra Buena Ln., Surprise, AZ 85374"
coordinates = { lat = 33.6292, lon = -112.3680 }
phone = "(602) 506-2222"

[courts.locations.hours]
weekdays = "8:00 AM - 5:00 PM"
```

### GeoJSON Export

TOML court data is compiled into GeoJSON for map rendering:

```json
{
  "type": "FeatureCollection",
  "features": [
    {
      "type": "Feature",
      "geometry": {
        "type": "Point",
        "coordinates": [-112.0773, 33.4484]
      },
      "properties": {
        "id": "azd-phoenix",
        "name": "U.S. District Court - Phoenix",
        "court_type": "federal-district",
        "circuit": "9th",
        "address": "401 W. Washington St., Phoenix, AZ 85003",
        "phone": "(602) 322-7200",
        "case_types": ["federal-criminal", "federal-civil"],
        "services": ["filing", "self-help", "interpreter"],
        "ada_accessible": true
      }
    }
  ]
}
```

---

## Federal Court Coverage

### Supreme Court (1)

```toml
# courts/federal/supreme.toml

[court]
id = "scotus"
name = "Supreme Court of the United States"
type = "federal-supreme"
address = "1 First Street NE, Washington, DC 20543"
coordinates = { lat = 38.8907, lon = -77.0044 }
phone = "(202) 479-3000"
website = "https://www.supremecourt.gov"
justices = 9
term = "First Monday in October through June/July"
```

### Circuit Courts of Appeals (13)

| Circuit | States Covered | Headquarters |
|---|---|---|
| 1st | ME, MA, NH, PR, RI | Boston, MA |
| 2nd | CT, NY, VT | New York, NY |
| 3rd | DE, NJ, PA, USVI | Philadelphia, PA |
| 4th | MD, NC, SC, VA, WV | Richmond, VA |
| 5th | LA, MS, TX | New Orleans, LA |
| 6th | KY, MI, OH, TN | Cincinnati, OH |
| 7th | IL, IN, WI | Chicago, IL |
| 8th | AR, IA, MN, MO, NE, ND, SD | St. Louis, MO |
| 9th | AK, AZ, CA, HI, ID, MT, NV, OR, WA, Guam, CNMI | San Francisco, CA |
| 10th | CO, KS, NM, OK, UT, WY | Denver, CO |
| 11th | AL, FL, GA | Atlanta, GA |
| D.C. | District of Columbia | Washington, DC |
| Federal | Nationwide (specialized) | Washington, DC |

### District Courts (94)

Every state has at least one federal district. Larger states have multiple:
- California: 4 districts (Northern, Central, Eastern, Southern)
- Texas: 4 districts (Northern, Eastern, Southern, Western)
- New York: 4 districts (Northern, Eastern, Southern, Western)
- Florida: 3 districts (Northern, Middle, Southern)

---

## State Court Coverage: Arizona (Pilot)

### Complete Arizona Court Map

```
Arizona Court System
|
+-- Arizona Supreme Court (Phoenix)
|
+-- Arizona Court of Appeals
|     +-- Division 1 (Phoenix) - 16 judges
|     +-- Division 2 (Tucson) - 6 judges
|
+-- Superior Courts (15 counties)
|     +-- Apache County (St. Johns)
|     +-- Cochise County (Bisbee)
|     +-- Coconino County (Flagstaff)
|     +-- Gila County (Globe)
|     +-- Graham County (Safford)
|     +-- Greenlee County (Clifton)
|     +-- La Paz County (Parker)
|     +-- Maricopa County (Phoenix) - largest
|     +-- Mohave County (Kingman)
|     +-- Navajo County (Holbrook)
|     +-- Pima County (Tucson)
|     +-- Pinal County (Florence)
|     +-- Santa Cruz County (Nogales)
|     +-- Yavapai County (Prescott)
|     +-- Yuma County (Yuma)
|
+-- Justice Courts (~87 precincts)
|     +-- Elected judges
|     +-- Civil up to $10,000
|     +-- Misdemeanors, traffic, small claims
|     +-- Preliminary hearings for felonies
|
+-- Municipal Courts (~80+ cities)
      +-- City ordinance violations
      +-- Traffic offenses
      +-- Misdemeanors committed within city limits
```

---

## Implementation: Leptos WASM Map Component

### Architecture

```
Leptos App (WASM)
  |
  +-- MapComponent
  |     |-- Leaflet.js (via wasm-bindgen interop)
  |     |-- GeoJSON layers (federal, state, municipal)
  |     |-- Click handlers -> CourtDetailPanel
  |     |-- Search integration
  |     +-- Zoom-level layer switching
  |
  +-- SearchComponent
  |     |-- Address/zip search (geocoding API)
  |     |-- Case type filter
  |     |-- Court type filter
  |     +-- Results -> MapComponent (fly to location)
  |
  +-- CourtDetailPanel
  |     |-- Court info (address, phone, hours)
  |     |-- Services available
  |     |-- Filing instructions
  |     |-- Fee schedules
  |     |-- Directions link (Google Maps/Apple Maps)
  |     +-- Jurisdiction description
  |
  +-- ConstitutionalReferencePanel
        |-- Article III explanation
        |-- Court hierarchy diagram
        |-- Jurisdiction types explained
        +-- Links to relevant U.S.C. sections
```

### Map Layers

| Layer | Zoom Level | Color | Icon |
|---|---|---|---|
| Federal Supreme | All | Gold | Scales of justice |
| Federal Circuit | 3-8 | Dark blue | Circuit number |
| Federal District | 5-12 | Blue | Federal building |
| State Supreme | 4-10 | Dark red | State seal |
| State Appellate | 5-12 | Red | Gavel |
| State Superior/Trial | 7-14 | Orange | Courthouse |
| Justice/Municipal | 10-18 | Green | Building |
| Specialized | 8-16 | Purple | Star |

### Search Capabilities

```
Search: "criminal court near 85003"
  --> Geocode "85003" to Phoenix, AZ coordinates
  --> Filter by case_type contains "criminal"
  --> Sort by distance from coordinates
  --> Return:
      1. Maricopa County Superior Court - 0.2 mi
      2. Phoenix Municipal Court - 0.5 mi
      3. U.S. District Court (Arizona) - 0.3 mi

Search: "file for divorce maricopa county"
  --> Match "divorce" to case_type "family"
  --> Match "maricopa county" to geographic jurisdiction
  --> Return:
      1. Maricopa County Superior Court - Family Division
         Filing: Electronic via TurboCourt
         Fee: $349 (with minor children) / $299 (without)
         Self-help: Free family law workshops available

Search: "federal bankruptcy court tucson"
  --> Match "federal" + "bankruptcy" + "tucson"
  --> Return:
      1. U.S. Bankruptcy Court, District of Arizona - Tucson
         Address: 38 S. Scott Ave., Tucson, AZ 85701
         Phone: (520) 202-7500
         E-filing: Required via CM/ECF
```

---

## U.S. Constitution Integration

The map ties directly to constitutional provisions. Each court level links to its constitutional or statutory authority:

### Federal Courts

| Court | Authority | Reference |
|---|---|---|
| Supreme Court | U.S. Constitution, Article III, Section 1 | Original and appellate jurisdiction defined in Art. III, Sec. 2 |
| Circuit Courts | 28 U.S.C. Chapter 3 | Established by Judiciary Act of 1891 |
| District Courts | 28 U.S.C. Chapter 5 | At least one per state per Art. III |
| Bankruptcy Courts | 28 U.S.C. Section 151 | Adjuncts to district courts |
| Magistrate Courts | 28 U.S.C. Chapter 43 | Federal Magistrates Act of 1968 |

### State Courts (Arizona Example)

| Court | Authority | Reference |
|---|---|---|
| Supreme Court | Arizona Constitution, Article VI, Section 1 | "The judicial power shall be vested in..." |
| Court of Appeals | Arizona Constitution, Article VI, Section 1; ARS 12-120 | Created 1965 |
| Superior Court | Arizona Constitution, Article VI, Section 14 | General jurisdiction trial court |
| Justice Courts | Arizona Constitution, Article VI, Section 32; ARS 22-201 | Limited jurisdiction |
| Municipal Courts | ARS 22-401 | City charter authority |

---

## Data Collection Strategy

### Phase 1: Federal Courts (Complete Data Available)

Source: `uscourts.gov` — The Administrative Office of the U.S. Courts publishes:
- All court locations with addresses
- District boundaries
- Circuit assignments
- Contact information
- CM/ECF (electronic filing) links

**Action:** Parse and convert to TOML format.

### Phase 2: Arizona State Courts (Pilot)

Sources:
- Arizona Judicial Branch: `azcourts.gov`
- Maricopa County Superior Court: `superiorcourt.maricopa.gov`
- Individual county court websites

**Action:** Manual collection + validation for 15 counties.

### Phase 3: All 50 States (Community-Driven)

Create a contribution template:
```
states/{state}/
  state.toml           # State metadata and court hierarchy
  courts/
    supreme.toml       # State supreme court
    appeals/           # Appellate courts
    trial/             # Trial courts by county/district
    specialized/       # Drug courts, family courts, etc.
    municipal/         # Municipal/city courts
  courts.geojson       # Compiled GeoJSON for map
```

Community contributors fill in their state using the template. CI validates TOML schema. PR review ensures accuracy.

### Phase 4: Tribal Courts

There are approximately 400 tribal justice systems in the United States. These operate under tribal sovereignty with unique jurisdictional rules:

- Indian Civil Rights Act of 1968
- Tribal Law and Order Act of 2010
- Violence Against Women Reauthorization Act of 2013

**Action:** Partner with tribal nations for accurate, respectful representation.

---

## Accessibility Requirements

| Requirement | Implementation |
|---|---|
| Screen reader support | ARIA labels on all map markers and panels |
| Keyboard navigation | Tab through courts, Enter to select, Esc to close |
| Color blind safe | Patterns + labels in addition to colors |
| Text alternative | Full court directory available as searchable list (no map required) |
| Language | English and Spanish initially; expandable |
| Mobile responsive | Touch-friendly markers; swipeable panels |
| Offline capable | Static court data bundled; map tiles cached |
| Low bandwidth | Progressive loading; text-first, map-second |

---

## Data Freshness

Court information changes (hours, phone numbers, new courthouses). The system must stay current:

1. **Automated checks** — Monthly HTTP HEAD requests to court websites; flag changes
2. **Community reports** — "Report incorrect information" button on every court detail
3. **Government feeds** — Subscribe to uscourts.gov RSS feeds for federal updates
4. **Version tracking** — Git history shows when each court entry was last verified
5. **Staleness indicator** — "Last verified: March 2026" on each court detail

---

## Metrics

| Metric | Target |
|---|---|
| Federal courts covered | 100% (94 districts + circuits + Supreme Court + specialized) |
| Arizona courts covered | 100% (all 15 counties + justice + municipal) |
| States with complete data | 10+ by Phase 9 |
| Search result accuracy | 95%+ (correct court for query intent) |
| Page load time (map) | < 3 seconds on 4G connection |
| Accessibility score | WCAG 2.1 AA compliant |

---

*Document Version: 1.0.0*
*Last Updated: March 2026*
*Part of the Justice System Open-Source Framework*
