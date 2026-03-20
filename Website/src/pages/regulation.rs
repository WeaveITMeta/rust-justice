use leptos::prelude::*;

#[component]
pub fn Regulation() -> impl IntoView {
    let (search_query, set_search_query) = signal(String::new());

    let usc_titles: Vec<(&str, &str, &str, bool)> = vec![
        ("Title 1", "General Provisions", "Rules of construction, definitions, and general provisions", false),
        ("Title 2", "The Congress", "Organization and operation of Congress", false),
        ("Title 3", "The President", "Presidential powers and duties", false),
        ("Title 4", "Flag and Seal, Seat of Government", "National symbols and capital", false),
        ("Title 5", "Government Organization and Employees", "Federal agencies and civil service", false),
        ("Title 6", "Domestic Security", "Homeland security and domestic safety", false),
        ("Title 7", "Agriculture", "Farming, food, and agriculture", false),
        ("Title 8", "Aliens and Nationality", "Immigration and citizenship", false),
        ("Title 9", "Arbitration", "Commercial arbitration and proceedings", false),
        ("Title 10", "Armed Forces", "Military organization and procedure", false),
        ("Title 11", "Bankruptcy", "Bankruptcy and insolvency", false),
        ("Title 12", "Banks and Banking", "Financial institutions and operations", false),
        ("Title 13", "Census", "Census Bureau and demographic data", false),
        ("Title 14", "Coast Guard", "Coast Guard organization and operations", false),
        ("Title 15", "Commerce and Trade", "Business and commercial regulations", false),
        ("Title 16", "Conservation", "Environmental protection and wildlife", false),
        ("Title 17", "Copyrights", "Copyright law and intellectual property", false),
        ("Title 18", "Crimes and Criminal Procedure", "Criminal law and procedure", false),
        ("Title 19", "Customs Duties", "Import/export and tariffs", false),
        ("Title 20", "Education", "Educational programs and institutions", false),
        ("Title 21", "Food and Drugs", "Food safety and drug regulation", false),
        ("Title 22", "Foreign Relations and Intercourse", "International relations", false),
        ("Title 23", "Highways", "Federal highway programs", false),
        ("Title 24", "Hospitals and Asylums", "REPEALED — Healthcare facilities (repealed by Pub. L. 98-473)", true),
        ("Title 25", "Indians", "Native American tribes and relations", false),
        ("Title 26", "Internal Revenue Code", "Federal tax law", false),
        ("Title 27", "Intoxicating Liquors", "REPEALED — Alcohol regulation (repealed by Pub. L. 109-59)", true),
        ("Title 28", "Judiciary and Judicial Procedure", "Courts and civil procedure — the foundation of federal justice", false),
        ("Title 29", "Labor", "Employment and labor law", false),
        ("Title 30", "Mineral Lands and Mining", "Mining and mineral resources", false),
        ("Title 31", "Money and Finance", "Treasury and financial management", false),
        ("Title 32", "National Guard", "State militia and National Guard", false),
        ("Title 33", "Navigation and Navigable Waters", "Waterway regulation", false),
        ("Title 34", "Crime Control and Law Enforcement", "REPEALED — Law enforcement (repealed by Pub. L. 90-351)", true),
        ("Title 35", "Patents", "Patent law and intellectual property", false),
        ("Title 36", "Patriotic and National Observances", "Patriotic organizations and observances", false),
        ("Title 37", "Pay and Allowances of the Uniformed Services", "Military compensation", false),
        ("Title 38", "Veterans' Benefits", "Veterans' rights and benefits", false),
        ("Title 39", "Postal Service", "Postal system operations", false),
        ("Title 40", "Public Buildings, Property, and Works", "Public property management", false),
        ("Title 41", "Public Contracts", "Government procurement", false),
        ("Title 42", "The Public Health and Welfare", "Public health, civil rights, and social programs", false),
        ("Title 43", "Public Lands", "Public land management", false),
        ("Title 44", "Public Printing and Documents", "Government publishing", false),
        ("Title 45", "Railroads", "Railroad transportation", false),
        ("Title 46", "Shipping", "Maritime law and shipping", false),
        ("Title 47", "Telecommunications", "Communications regulation", false),
        ("Title 48", "Territories and Insular Possessions", "U.S. territories", false),
        ("Title 49", "Transportation", "Transportation regulation", false),
        ("Title 50", "War and National Defense", "Military and national security", false),
        ("Title 51", "National and Commercial Space Programs", "Space exploration", false),
        ("Title 52", "Voting and Elections", "Federal election law", false),
        ("Title 53", "Small Business", "REPEALED — Small business programs (repealed by Pub. L. 85-536)", true),
        ("Title 54", "National Park Service", "National parks and monuments", false),
    ];

    view! {
        <div class="container mx-auto px-4 py-8">
            <h1 class="text-4xl font-bold mb-8">"Regulations & U.S. Code"</h1>

            // Search
            <div class="bg-white rounded-lg shadow-lg p-6 mb-8">
                <div class="flex flex-wrap gap-4 items-center">
                    <div class="flex-1">
                        <div class="relative">
                            <svg class="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400 h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <circle cx="11" cy="11" r="8"/>
                                <line x1="21" y1="21" x2="16.65" y2="16.65"/>
                            </svg>
                            <input
                                type="text"
                                placeholder="Search U.S. Code titles..."
                                class="w-full pl-10 pr-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                                on:input=move |ev| {
                                    set_search_query.set(event_target_value(&ev));
                                }
                                prop:value=search_query
                            />
                        </div>
                    </div>
                </div>
            </div>

            // Title 28 Highlight
            <div class="bg-blue-50 border-2 border-blue-300 rounded-lg p-6 mb-8">
                <div class="flex items-start">
                    <svg class="h-8 w-8 text-blue-600 mr-4 flex-shrink-0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M12 3L2 7l10 4 10-4-10-4z"/>
                        <path d="M2 17l10 4 10-4"/>
                        <path d="M2 12l10 4 10-4"/>
                    </svg>
                    <div>
                        <h2 class="text-2xl font-bold text-blue-800 mb-2">"Title 28 — Judiciary and Judicial Procedure"</h2>
                        <p class="text-gray-700 mb-4">
                            "This is the cornerstone of federal justice. Title 28 defines how federal courts are organized, what cases they can hear, where you file, and how the judiciary operates. Every citizen interacting with the federal court system is governed by Title 28."
                        </p>
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                            <div class="bg-white p-3 rounded-lg">
                                <p class="font-semibold text-blue-700">"Part I — Organization"</p>
                                <p class="text-sm text-gray-600">"Supreme Court, Courts of Appeals, District Courts"</p>
                            </div>
                            <div class="bg-white p-3 rounded-lg">
                                <p class="font-semibold text-blue-700">"Part IV — Jurisdiction & Venue"</p>
                                <p class="text-sm text-gray-600">"§§ 1330-1631: Who can sue, where to file"</p>
                            </div>
                            <div class="bg-white p-3 rounded-lg">
                                <p class="font-semibold text-blue-700">"Part V — Procedure"</p>
                                <p class="text-sm text-gray-600">"§§ 1651-1932: How cases proceed through court"</p>
                            </div>
                        </div>
                        <a
                            href="https://www.law.cornell.edu/uscode/text/28"
                            target="_blank"
                            class="inline-flex items-center mt-4 text-blue-600 hover:text-blue-700 font-medium"
                        >
                            "Read Full Title 28"
                            <svg class="h-4 w-4 ml-1" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"/>
                                <polyline points="15 3 21 3 21 9"/>
                                <line x1="10" y1="14" x2="21" y2="3"/>
                            </svg>
                        </a>
                    </div>
                </div>
            </div>

            // All USC Titles
            <div class="bg-white rounded-lg shadow-lg">
                <div class="p-6 border-b">
                    <h2 class="text-2xl font-bold">"United States Code"</h2>
                    <p class="text-gray-600">"Complete listing of all 52 active U.S. Code titles"</p>
                </div>

                <div class="divide-y">
                    {usc_titles.into_iter().map(|(title, name, desc, is_repealed)| {
                        let title_owned = title.to_string();
                        let name_owned = name.to_string();
                        let desc_owned = desc.to_string();
                        let title_num = title.replace("Title ", "");
                        let cornell_url = format!("https://www.law.cornell.edu/uscode/text/{}", title_num);
                        let is_title_28 = title == "Title 28";

                        view! {
                            <div
                                class="p-6"
                                class:hidden=move || {
                                    let q = search_query.get().to_lowercase();
                                    if q.is_empty() { return false; }
                                    !title_owned.to_lowercase().contains(&q)
                                        && !name_owned.to_lowercase().contains(&q)
                                        && !desc_owned.to_lowercase().contains(&q)
                                }
                                class:bg-blue-50=is_title_28
                                class:bg-gray-100=is_repealed
                                class:opacity-60=is_repealed
                            >
                                <div class="flex justify-between items-start">
                                    <div>
                                        <h3 class="text-xl font-bold mb-1">
                                            {title}" — "{name}
                                            {is_repealed.then(|| view! {
                                                <span class="ml-2 text-sm font-normal text-red-600 bg-red-100 px-2 py-1 rounded">"REPEALED"</span>
                                            })}
                                        </h3>
                                        <p class="text-gray-600">{desc}</p>
                                    </div>
                                    {(!is_repealed).then(|| view! {
                                        <a
                                            href=cornell_url
                                            target="_blank"
                                            class="text-blue-600 hover:text-blue-700 flex items-center whitespace-nowrap ml-4"
                                        >
                                            "View Full Title"
                                            <svg class="h-4 w-4 ml-1" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                                <path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"/>
                                                <polyline points="15 3 21 3 21 9"/>
                                                <line x1="10" y1="14" x2="21" y2="3"/>
                                            </svg>
                                        </a>
                                    })}
                                </div>
                            </div>
                        }
                    }).collect::<Vec<_>>()}
                </div>
            </div>
        </div>
    }
}
