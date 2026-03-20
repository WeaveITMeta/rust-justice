use leptos::prelude::*;

#[component]
pub fn Help() -> impl IntoView {
    view! {
        <div class="container mx-auto px-4 py-8">
            <h1 class="text-4xl font-bold mb-8">"Help Center"</h1>

            // Help Categories
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8 mb-12">
                <HelpCategory
                    icon="book"
                    title="Getting Started"
                    items=vec![
                        "How to navigate the Justice Portal",
                        "Understanding federal court procedures",
                        "Creating and managing your account",
                        "Finding the right court for your case",
                    ]
                />
                <HelpCategory
                    icon="forms"
                    title="Forms & Documents"
                    items=vec![
                        "Guide to federal court forms",
                        "Document formatting requirements",
                        "Signature and notarization rules",
                        "Filing fees and fee waiver applications",
                    ]
                />
                <HelpCategory
                    icon="court"
                    title="Court Services"
                    items=vec![
                        "Case filing and management",
                        "Document retrieval via PACER",
                        "Court calendar and scheduling",
                        "Remote and virtual hearing access",
                    ]
                />
            </div>

            // Title 28 Guide for Citizens
            <div class="bg-white rounded-lg shadow-lg p-8 mb-12">
                <h2 class="text-2xl font-bold mb-6">"Understanding Title 28 — A Citizen's Guide"</h2>

                <div class="space-y-6">
                    <div class="border-l-4 border-blue-600 pl-6">
                        <h3 class="font-bold text-lg mb-2">"What is Title 28?"</h3>
                        <p class="text-gray-600">
                            "Title 28 of the United States Code is the law that establishes the entire federal court system. It defines which courts exist, what cases they can hear, where you must file, and the procedures for getting justice. If you have a legal matter involving the federal government, a dispute with someone in another state, or a violation of your constitutional rights, Title 28 is the law that gives you access to the courts."
                        </p>
                    </div>

                    <div class="border-l-4 border-green-600 pl-6">
                        <h3 class="font-bold text-lg mb-2">"Do I Need a Lawyer?"</h3>
                        <p class="text-gray-600">
                            "No. Under "<strong>"28 U.S.C. § 1654"</strong>", you have the absolute right to represent yourself in any federal court. This is called proceeding "<em>"pro se"</em>". While an attorney can help with complex matters, the law guarantees your ability to plead and conduct your own case. Many federal courts offer self-help resources and pro se clinics."
                        </p>
                    </div>

                    <div class="border-l-4 border-purple-600 pl-6">
                        <h3 class="font-bold text-lg mb-2">"What if I Can't Afford Court Fees?"</h3>
                        <p class="text-gray-600">
                            "Under "<strong>"28 U.S.C. § 1915"</strong>", you can apply to proceed "<em>"in forma pauperis"</em>" (IFP). This means the court will waive your filing fees if you demonstrate financial hardship. Submit an affidavit of your income and assets with your complaint. Justice should never be denied because of poverty."
                        </p>
                    </div>

                    <div class="border-l-4 border-amber-600 pl-6">
                        <h3 class="font-bold text-lg mb-2">"How Do I Know If I Can File in Federal Court?"</h3>
                        <p class="text-gray-600 mb-3">"Federal courts can hear your case if:"</p>
                        <ul class="space-y-2 text-gray-600">
                            <li class="flex items-start">
                                <svg class="h-5 w-5 text-amber-600 mr-2 flex-shrink-0 mt-0.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 18l6-6-6-6"/></svg>
                                <span><strong>"Federal Question"</strong>" (§ 1331) — Your case involves the U.S. Constitution, a federal law, or a treaty"</span>
                            </li>
                            <li class="flex items-start">
                                <svg class="h-5 w-5 text-amber-600 mr-2 flex-shrink-0 mt-0.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 18l6-6-6-6"/></svg>
                                <span><strong>"Diversity"</strong>" (§ 1332) — You and the other party are from different states and the amount exceeds $75,000"</span>
                            </li>
                            <li class="flex items-start">
                                <svg class="h-5 w-5 text-amber-600 mr-2 flex-shrink-0 mt-0.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 18l6-6-6-6"/></svg>
                                <span><strong>"U.S. Government"</strong>" (§ 1345-1346) — The federal government is a party to the case"</span>
                            </li>
                        </ul>
                    </div>

                    <div class="border-l-4 border-red-600 pl-6">
                        <h3 class="font-bold text-lg mb-2">"My Constitutional Rights Were Violated"</h3>
                        <p class="text-gray-600">
                            "If a state official has violated your constitutional rights, you can sue under "<strong>"42 U.S.C. § 1983"</strong>", which federal courts have jurisdiction to hear under 28 U.S.C. § 1331. This includes violations by police, government agencies, public schools, or any person acting under color of state law."
                        </p>
                    </div>
                </div>
            </div>

            // Contact Support
            <div class="bg-gray-50 rounded-lg p-8 mb-12">
                <div class="flex flex-col md:flex-row items-center justify-between">
                    <div class="flex items-center space-x-4 mb-4 md:mb-0">
                        <svg class="h-8 w-8 text-blue-600" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"/>
                        </svg>
                        <div>
                            <p class="font-medium text-lg">"Need more help?"</p>
                            <p class="text-gray-600">"Contact our support team for assistance with court services"</p>
                        </div>
                    </div>
                    <div class="flex space-x-4">
                        <a
                            href="mailto:support@justice-portal.gov"
                            class="inline-flex items-center px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-100 transition-colors"
                        >
                            <svg class="h-5 w-5 mr-2" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/>
                                <polyline points="22,6 12,13 2,6"/>
                            </svg>
                            "Email Support"
                        </a>
                        <a
                            href="https://discord.gg/gA3pspAAQV"
                            target="_blank"
                            class="inline-flex items-center px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors"
                        >
                            <svg class="h-5 w-5 mr-2" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/>
                            </svg>
                            "Community Chat"
                        </a>
                    </div>
                </div>
            </div>

            // External Resources
            <div class="bg-white rounded-lg shadow-lg p-6">
                <h2 class="text-2xl font-bold mb-6">"Official Resources"</h2>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <ResourceLink
                        title="U.S. Courts Official Website"
                        description="Official portal for the federal judiciary"
                        url="https://www.uscourts.gov/"
                    />
                    <ResourceLink
                        title="Title 28 — Full Text (Cornell)"
                        description="Complete text of Title 28 U.S.C. with annotations"
                        url="https://www.law.cornell.edu/uscode/text/28"
                    />
                    <ResourceLink
                        title="Federal Rules of Civil Procedure"
                        description="Rules governing civil cases in federal court"
                        url="https://www.law.cornell.edu/rules/frcp"
                    />
                    <ResourceLink
                        title="Legal Services Corporation"
                        description="Find free legal aid in your area"
                        url="https://www.lsc.gov/about-lsc/what-legal-aid/get-legal-help"
                    />
                    <ResourceLink
                        title="PACER — Court Records"
                        description="Search and access federal court records"
                        url="https://pacer.uscourts.gov/"
                    />
                    <ResourceLink
                        title="Federal Court Forms"
                        description="Download official forms for all federal courts"
                        url="https://www.uscourts.gov/forms/all-forms"
                    />
                </div>
            </div>
        </div>
    }
}

#[component]
fn HelpCategory(icon: &'static str, title: &'static str, items: Vec<&'static str>) -> impl IntoView {
    let svg = match icon {
        "book" => view! {
            <svg class="h-8 w-8 text-blue-600 mb-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M2 3h6a4 4 0 0 1 4 4v14a3 3 0 0 0-3-3H2z"/>
                <path d="M22 3h-6a4 4 0 0 0-4 4v14a3 3 0 0 1 3-3h7z"/>
            </svg>
        }.into_any(),
        "forms" => view! {
            <svg class="h-8 w-8 text-blue-600 mb-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
                <polyline points="14 2 14 8 20 8"/>
                <line x1="16" y1="13" x2="8" y2="13"/>
                <line x1="16" y1="17" x2="8" y2="17"/>
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
        <div class="bg-white p-6 rounded-lg shadow-lg">
            {svg}
            <h2 class="text-xl font-bold mb-4">{title}</h2>
            <ul class="space-y-3">
                {items.into_iter().map(|item| {
                    view! {
                        <li class="flex items-start text-gray-600">
                            <svg class="h-5 w-5 text-blue-600 mr-2 flex-shrink-0 mt-0.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M9 18l6-6-6-6"/>
                            </svg>
                            {item}
                        </li>
                    }
                }).collect::<Vec<_>>()}
            </ul>
        </div>
    }
}

#[component]
fn ResourceLink(title: &'static str, description: &'static str, url: &'static str) -> impl IntoView {
    view! {
        <a
            href=url
            target="_blank"
            class="flex items-start p-4 border rounded-lg hover:shadow-md transition-shadow"
        >
            <svg class="h-5 w-5 text-blue-600 mr-3 flex-shrink-0 mt-0.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"/>
                <polyline points="15 3 21 3 21 9"/>
                <line x1="10" y1="14" x2="21" y2="3"/>
            </svg>
            <div>
                <h3 class="font-bold">{title}</h3>
                <p class="text-gray-600 text-sm">{description}</p>
            </div>
        </a>
    }
}
