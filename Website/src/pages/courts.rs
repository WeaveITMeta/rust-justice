use leptos::prelude::*;

#[component]
pub fn Courts() -> impl IntoView {
    view! {
        <div class="container mx-auto px-4 py-8">
            <h1 class="text-4xl font-bold mb-8">"Courts"</h1>

            // Federal Court System + Procedures
            <div class="grid grid-cols-1 md:grid-cols-2 gap-8 mb-12">
                <div>
                    <h2 class="text-2xl font-bold mb-6 flex items-center">
                        <svg class="h-6 w-6 mr-2 text-blue-600" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <circle cx="12" cy="12" r="10"/>
                            <path d="M12 8v4l3 3"/>
                        </svg>
                        "Federal Court System"
                    </h2>
                    <div class="space-y-4">
                        <CourtCard
                            title="Supreme Court"
                            code="U.S.C. Title 28, Chapter 1"
                            description="Highest court with ultimate appellate jurisdiction and original jurisdiction in limited cases (28 U.S.C. §§ 1251-1259)"
                        />
                        <CourtCard
                            title="Courts of Appeals"
                            code="U.S.C. Title 28, Chapter 3"
                            description="13 circuits with appellate jurisdiction over district courts and federal administrative agencies (28 U.S.C. §§ 41-49)"
                        />
                        <CourtCard
                            title="Federal District Courts"
                            code="U.S.C. Title 28, Chapter 5"
                            description="94 districts with original jurisdiction for federal civil and criminal cases (28 U.S.C. §§ 81-144)"
                        />
                        <CourtCard
                            title="Bankruptcy Courts"
                            code="U.S.C. Title 28, Chapter 6"
                            description="Units of district courts handling bankruptcy proceedings (28 U.S.C. § 151)"
                        />
                    </div>
                </div>

                <div>
                    <h2 class="text-2xl font-bold mb-6 flex items-center">
                        <svg class="h-6 w-6 mr-2 text-blue-600" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <path d="M2 3h6a4 4 0 0 1 4 4v14a3 3 0 0 0-3-3H2z"/>
                            <path d="M22 3h-6a4 4 0 0 0-4 4v14a3 3 0 0 1 3-3h7z"/>
                        </svg>
                        "Federal Rules & Procedures"
                    </h2>
                    <div class="bg-gray-50 p-6 rounded-lg">
                        <div class="mb-6">
                            <h3 class="font-bold text-lg mb-2">"Civil Procedure"</h3>
                            <p class="text-blue-600 text-sm mb-1">"Title 28, Part IV"</p>
                            <p class="text-gray-600">"Federal Rules of Civil Procedure govern lawsuits in federal courts, including filing, discovery, motions, and trial."</p>
                        </div>
                        <div class="mb-6">
                            <h3 class="font-bold text-lg mb-2">"Criminal Procedure"</h3>
                            <p class="text-blue-600 text-sm mb-1">"Title 18, Part II"</p>
                            <p class="text-gray-600">"Federal criminal procedure protects the rights of defendants from arrest through sentencing and appeal."</p>
                        </div>
                        <div class="mb-6">
                            <h3 class="font-bold text-lg mb-2">"Evidence Rules"</h3>
                            <p class="text-blue-600 text-sm mb-1">"Title 28, Appendix"</p>
                            <p class="text-gray-600">"Federal Rules of Evidence govern what testimony, documents, and physical evidence may be presented."</p>
                        </div>
                        <div>
                            <h3 class="font-bold text-lg mb-2">"Appellate Procedure"</h3>
                            <p class="text-blue-600 text-sm mb-1">"Title 28, Part V"</p>
                            <p class="text-gray-600">"Rules governing appeals from district courts to courts of appeals (28 U.S.C. §§ 1291-1296)."</p>
                        </div>
                    </div>
                </div>
            </div>

            // Jurisdiction Guide
            <div class="bg-white rounded-lg shadow-lg p-6 mb-12">
                <h2 class="text-2xl font-bold mb-6">"Can Federal Court Help Me?"</h2>
                <p class="text-gray-600 mb-6">"Federal courts have limited jurisdiction. Under Title 28, they can hear your case if:"</p>
                <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                    <div class="bg-blue-50 p-6 rounded-lg">
                        <h3 class="font-bold text-lg mb-2 text-blue-800">"Federal Question"</h3>
                        <p class="text-sm text-blue-600 mb-2">"28 U.S.C. § 1331"</p>
                        <p class="text-gray-700">"Your case arises under the Constitution, federal laws, or treaties. Examples: civil rights violations, federal crimes, patent disputes."</p>
                    </div>
                    <div class="bg-green-50 p-6 rounded-lg">
                        <h3 class="font-bold text-lg mb-2 text-green-800">"Diversity of Citizenship"</h3>
                        <p class="text-sm text-green-600 mb-2">"28 U.S.C. § 1332"</p>
                        <p class="text-gray-700">"The parties are from different states and the amount in controversy exceeds $75,000. You can sue out-of-state defendants in federal court."</p>
                    </div>
                    <div class="bg-purple-50 p-6 rounded-lg">
                        <h3 class="font-bold text-lg mb-2 text-purple-800">"United States as a Party"</h3>
                        <p class="text-sm text-purple-600 mb-2">"28 U.S.C. §§ 1345-1346"</p>
                        <p class="text-gray-700">"Cases where the U.S. government is suing or being sued, including tort claims against the government (FTCA)."</p>
                    </div>
                </div>
            </div>

            // Key Title 28 Sections
            <div class="bg-gray-50 rounded-lg p-6 mb-12">
                <h2 class="text-2xl font-bold mb-6">"Key Title 28 Sections Every Citizen Should Know"</h2>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <StatuteRef
                        section="§ 1331"
                        name="Federal question jurisdiction"
                        description="Courts have jurisdiction over cases arising under federal law"
                    />
                    <StatuteRef
                        section="§ 1332"
                        name="Diversity jurisdiction"
                        description="Cases between citizens of different states exceeding $75,000"
                    />
                    <StatuteRef
                        section="§ 1391"
                        name="Venue"
                        description="Where your case should be filed geographically"
                    />
                    <StatuteRef
                        section="§ 1441"
                        name="Removal"
                        description="Moving a case from state court to federal court"
                    />
                    <StatuteRef
                        section="§ 1654"
                        name="Right to self-representation"
                        description="You may plead and conduct your own case in person"
                    />
                    <StatuteRef
                        section="§ 1915"
                        name="In forma pauperis"
                        description="Proceeding without prepaying fees if you cannot afford them"
                    />
                    <StatuteRef
                        section="§ 1291"
                        name="Final decisions"
                        description="Right to appeal final decisions of district courts"
                    />
                    <StatuteRef
                        section="§ 1983 (42 U.S.C.)"
                        name="Civil rights actions"
                        description="Sue state officials for violating your constitutional rights"
                    />
                </div>
            </div>

            // Find Your Court CTA
            <div class="bg-blue-600 text-white rounded-lg p-8 text-center">
                <h2 class="text-2xl font-bold mb-4">"Find Your Federal Court"</h2>
                <p class="mb-6 text-blue-100">"The U.S. has 94 federal judicial districts organized into 13 circuits. Find the right court for your case."</p>
                <a
                    href="https://www.uscourts.gov/federal-court-finder/search"
                    target="_blank"
                    class="inline-flex items-center bg-white text-blue-600 px-6 py-3 rounded-lg font-semibold hover:bg-blue-50 transition"
                >
                    "U.S. Courts Court Finder"
                    <svg class="h-5 w-5 ml-2" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"/>
                        <polyline points="15 3 21 3 21 9"/>
                        <line x1="10" y1="14" x2="21" y2="3"/>
                    </svg>
                </a>
            </div>
        </div>
    }
}

#[component]
fn CourtCard(title: &'static str, code: &'static str, description: &'static str) -> impl IntoView {
    view! {
        <div class="bg-white p-6 border rounded-lg shadow-sm">
            <h3 class="font-bold text-lg mb-2">{title}</h3>
            <p class="text-blue-600 text-sm mb-2">{code}</p>
            <p class="text-gray-600">{description}</p>
        </div>
    }
}

#[component]
fn StatuteRef(section: &'static str, name: &'static str, description: &'static str) -> impl IntoView {
    view! {
        <div class="bg-white p-4 rounded-lg border flex items-start">
            <svg class="h-5 w-5 text-blue-600 mr-3 flex-shrink-0 mt-0.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M9 18l6-6-6-6"/>
            </svg>
            <div>
                <span class="font-bold text-blue-600">{section}</span>
                <span class="font-medium">" — "{name}</span>
                <p class="text-gray-600 text-sm mt-1">{description}</p>
            </div>
        </div>
    }
}
