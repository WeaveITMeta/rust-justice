use leptos::prelude::*;

#[component]
pub fn SelfService() -> impl IntoView {
    view! {
        <div class="container mx-auto px-4 py-8">
            <h1 class="text-4xl font-bold mb-8">"Self Service Portal"</h1>

            // Service Cards
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8 mb-12">
                <ServiceCard
                    icon="forms"
                    title="Legal Forms"
                    description="Access and complete court forms online for federal filings"
                    link="https://www.uscourts.gov/forms/all-forms"
                />
                <ServiceCard
                    icon="search"
                    title="Case Search"
                    description="Look up case information, status, and docket entries"
                    link="https://www.courtlistener.com/"
                />
                <ServiceCard
                    icon="calendar"
                    title="Court Calendar"
                    description="View upcoming court dates and hearing schedules"
                    link="https://www.uscourts.gov/"
                />
                <ServiceCard
                    icon="help"
                    title="Legal Resources"
                    description="Access guides, self-help tools, and legal information"
                    link="/help"
                />
            </div>

            // Pro Se Guide
            <div class="bg-white rounded-lg shadow-lg p-8 mb-12">
                <h2 class="text-2xl font-bold mb-6">"Filing a Federal Lawsuit — Step by Step"</h2>
                <p class="text-gray-600 mb-8">
                    "Under 28 U.S.C. § 1654, you have the right to represent yourself (pro se) in federal court. Here is how to file a civil case:"
                </p>

                <div class="space-y-6">
                    <Step
                        number="1"
                        title="Determine Jurisdiction"
                        description="Your case must fall under federal jurisdiction. Check if it involves a federal question (28 U.S.C. § 1331) or diversity of citizenship (28 U.S.C. § 1332). If neither applies, you likely need to file in state court."
                    />
                    <Step
                        number="2"
                        title="Determine Venue"
                        description="Under 28 U.S.C. § 1391, file where any defendant resides (if all reside in the same state), where a substantial part of the events occurred, or where any defendant may be found if no other district is proper."
                    />
                    <Step
                        number="3"
                        title="Draft Your Complaint"
                        description="Write a complaint stating your claims, the facts supporting them, and the relief you seek. Follow the Federal Rules of Civil Procedure, Rule 8 — a short and plain statement is sufficient."
                    />
                    <Step
                        number="4"
                        title="Prepare a Civil Cover Sheet"
                        description="Complete Form JS-44, the Civil Cover Sheet. This helps the court categorize your case and assign it to the appropriate judge."
                    />
                    <Step
                        number="5"
                        title="Pay the Filing Fee or Request a Waiver"
                        description="The federal civil filing fee is $405. If you cannot afford it, file an Application to Proceed In Forma Pauperis under 28 U.S.C. § 1915 to have the fee waived."
                    />
                    <Step
                        number="6"
                        title="File and Serve"
                        description="File your complaint with the district court clerk. You must then serve the defendant within 90 days under FRCP Rule 4. The court can issue a summons for you."
                    />
                    <Step
                        number="7"
                        title="Track Your Case"
                        description="Monitor your case via PACER (Public Access to Court Electronic Records) at pacer.uscourts.gov. Respond to all motions and attend all hearings."
                    />
                </div>
            </div>

            // Quick Links
            <div class="bg-gray-50 p-8 rounded-lg mb-12">
                <h2 class="text-2xl font-bold mb-6">"Essential Resources"</h2>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <QuickLink
                        title="PACER — Case Search"
                        description="Search federal court records and track case status"
                        url="https://pacer.uscourts.gov/"
                    />
                    <QuickLink
                        title="Federal Court Forms"
                        description="All official forms for federal court filings"
                        url="https://www.uscourts.gov/forms/all-forms"
                    />
                    <QuickLink
                        title="Federal Rules of Civil Procedure"
                        description="Complete rules governing civil lawsuits"
                        url="https://www.law.cornell.edu/rules/frcp"
                    />
                    <QuickLink
                        title="Fee Schedule & IFP Application"
                        description="Filing fees and fee waiver application"
                        url="https://www.uscourts.gov/services-forms/fees"
                    />
                    <QuickLink
                        title="Pro Se Litigant Guide"
                        description="Handbook for self-represented parties in federal court"
                        url="https://www.uscourts.gov/court-records/find-case-pacer"
                    />
                    <QuickLink
                        title="Legal Aid Finder"
                        description="Find free legal assistance in your area"
                        url="https://www.lsc.gov/about-lsc/what-legal-aid/get-legal-help"
                    />
                </div>
            </div>

            // Fee Waiver Info
            <div class="bg-blue-50 rounded-lg p-6 border border-blue-200">
                <h3 class="font-bold text-lg text-blue-800 mb-3 flex items-center">
                    <svg class="h-6 w-6 mr-2" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <circle cx="12" cy="12" r="10"/>
                        <line x1="12" y1="16" x2="12" y2="12"/>
                        <line x1="12" y1="8" x2="12.01" y2="8"/>
                    </svg>
                    "Can't Afford Filing Fees?"
                </h3>
                <p class="text-gray-700 mb-3">
                    "Under "<strong>"28 U.S.C. § 1915"</strong>", any court of the United States may authorize the commencement of any suit without prepayment of fees by a person who submits an affidavit that they are unable to pay such fees."
                </p>
                <p class="text-gray-600 text-sm">
                    "This is called proceeding "<em>"in forma pauperis"</em>" (IFP). The court will review your financial situation and may waive all filing fees, allowing you full access to the justice system regardless of income."
                </p>
            </div>
        </div>
    }
}

#[component]
fn ServiceCard(icon: &'static str, title: &'static str, description: &'static str, link: &'static str) -> impl IntoView {
    let svg = match icon {
        "forms" => view! {
            <svg class="h-8 w-8 text-blue-600 mb-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
                <polyline points="14 2 14 8 20 8"/>
                <line x1="16" y1="13" x2="8" y2="13"/>
                <line x1="16" y1="17" x2="8" y2="17"/>
            </svg>
        }.into_any(),
        "search" => view! {
            <svg class="h-8 w-8 text-blue-600 mb-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <circle cx="11" cy="11" r="8"/>
                <line x1="21" y1="21" x2="16.65" y2="16.65"/>
            </svg>
        }.into_any(),
        "calendar" => view! {
            <svg class="h-8 w-8 text-blue-600 mb-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <rect x="3" y="4" width="18" height="18" rx="2" ry="2"/>
                <line x1="16" y1="2" x2="16" y2="6"/>
                <line x1="8" y1="2" x2="8" y2="6"/>
                <line x1="3" y1="10" x2="21" y2="10"/>
            </svg>
        }.into_any(),
        _ => view! {
            <svg class="h-8 w-8 text-blue-600 mb-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <circle cx="12" cy="12" r="10"/>
                <path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3"/>
                <line x1="12" y1="17" x2="12.01" y2="17"/>
            </svg>
        }.into_any(),
    };

    view! {
        <a href=link target="_blank" class="bg-white p-6 rounded-lg shadow-lg hover:shadow-xl transition-shadow block">
            {svg}
            <h2 class="text-xl font-bold mb-2">{title}</h2>
            <p class="text-gray-600 mb-4">{description}</p>
            <span class="text-blue-600 hover:text-blue-700 flex items-center">
                "Access Service"
                <svg class="h-4 w-4 ml-1" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M5 12h14"/>
                    <path d="M12 5l7 7-7 7"/>
                </svg>
            </span>
        </a>
    }
}

#[component]
fn Step(number: &'static str, title: &'static str, description: &'static str) -> impl IntoView {
    view! {
        <div class="flex items-start">
            <div class="flex-shrink-0 w-10 h-10 bg-blue-600 text-white rounded-full flex items-center justify-center font-bold text-lg mr-4">
                {number}
            </div>
            <div>
                <h3 class="font-bold text-lg mb-1">{title}</h3>
                <p class="text-gray-600">{description}</p>
            </div>
        </div>
    }
}

#[component]
fn QuickLink(title: &'static str, description: &'static str, url: &'static str) -> impl IntoView {
    view! {
        <a
            href=url
            target="_blank"
            class="bg-white p-4 rounded-lg shadow hover:shadow-md transition-shadow flex items-start space-x-3"
        >
            <svg class="h-6 w-6 text-blue-600 flex-shrink-0 mt-0.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"/>
                <polyline points="15 3 21 3 21 9"/>
                <line x1="10" y1="14" x2="21" y2="3"/>
            </svg>
            <div>
                <h3 class="font-bold mb-1">{title}</h3>
                <p class="text-gray-600 text-sm">{description}</p>
            </div>
        </a>
    }
}
