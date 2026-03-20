use leptos::prelude::*;

#[component]
pub fn Home() -> impl IntoView {
    view! {
        <div>
            // Hero Section
            <div
                class="relative h-[60vh] bg-cover bg-center"
                style="background-image: url('https://images.unsplash.com/photo-1589829545856-d10d557cf95f?auto=format&fit=crop&q=80')"
            >
                <div class="absolute inset-0 bg-black bg-opacity-50" />
                <div class="relative container mx-auto px-4 h-full flex items-center">
                    <div class="text-white max-w-2xl">
                        <h1 class="text-5xl font-bold mb-4">"Justice For All"</h1>
                        <p class="text-xl mb-8">
                            "Access to justice is a fundamental right. We are here to help you understand your rights under "
                            <strong>"Title 28 U.S.C."</strong>
                            " — the law that defines how federal courts work and how you access them."
                        </p>
                        <a
                            href="/self-service"
                            class="inline-block bg-blue-600 text-white px-8 py-3 rounded-lg text-lg font-semibold hover:bg-blue-700 transition"
                        >
                            "Get Started"
                        </a>
                    </div>
                </div>
            </div>

            // Features Section
            <div class="py-16 bg-white">
                <div class="container mx-auto px-4">
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
                        <FeatureCard
                            icon="scale"
                            title="Equal Justice"
                            description="Justice served without prejudice or favor, grounded in Title 28"
                        />
                        <FeatureCard
                            icon="gavel"
                            title="Court Services"
                            description="Efficient and accessible federal court proceedings"
                        />
                        <FeatureCard
                            icon="users"
                            title="Community Focus"
                            description="Serving the needs of every citizen in every community"
                        />
                        <FeatureCard
                            icon="document"
                            title="Online Services"
                            description="Digital access to forms, filings, and legal resources"
                        />
                    </div>
                </div>
            </div>

            // Your Day in Court Section
            <div class="py-16 bg-gray-50">
                <div class="container mx-auto px-4">
                    <div class="max-w-4xl mx-auto">
                        <div class="text-center mb-12">
                            <svg class="h-12 w-12 mx-auto mb-4 text-blue-600" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <rect x="2" y="3" width="20" height="14" rx="2" ry="2"/>
                                <path d="M8 21h8"/>
                                <path d="M12 17v4"/>
                            </svg>
                            <h2 class="text-3xl font-bold mb-4">"Your Day in Court"</h2>
                            <p class="text-gray-600">"Essential information to help you prepare for and navigate your court appearance"</p>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 mb-12">
                            // Overview
                            <div class="bg-white p-6 rounded-lg shadow-lg">
                                <h3 class="text-xl font-bold mb-4 flex items-center">
                                    <svg class="h-6 w-6 text-blue-600 mr-2" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <path d="M2 3h6a4 4 0 0 1 4 4v14a3 3 0 0 0-3-3H2z"/>
                                        <path d="M22 3h-6a4 4 0 0 0-4 4v14a3 3 0 0 1 3-3h7z"/>
                                    </svg>
                                    "Overview"
                                </h3>
                                <ul class="space-y-3 text-gray-600">
                                    <li class="flex items-start">
                                        <svg class="h-5 w-5 text-blue-600 mr-2 flex-shrink-0 mt-0.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14"/><path d="M12 5l7 7-7 7"/></svg>
                                        "Arrive at least 30 minutes early"
                                    </li>
                                    <li class="flex items-start">
                                        <svg class="h-5 w-5 text-blue-600 mr-2 flex-shrink-0 mt-0.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14"/><path d="M12 5l7 7-7 7"/></svg>
                                        "Dress professionally and conservatively"
                                    </li>
                                    <li class="flex items-start">
                                        <svg class="h-5 w-5 text-blue-600 mr-2 flex-shrink-0 mt-0.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14"/><path d="M12 5l7 7-7 7"/></svg>
                                        "Bring all required documents and evidence"
                                    </li>
                                    <li class="flex items-start">
                                        <svg class="h-5 w-5 text-blue-600 mr-2 flex-shrink-0 mt-0.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14"/><path d="M12 5l7 7-7 7"/></svg>
                                        "Phones must be silenced in the courtroom"
                                    </li>
                                </ul>
                            </div>

                            // Your Rights
                            <div class="bg-white p-6 rounded-lg shadow-lg">
                                <h3 class="text-xl font-bold mb-4 flex items-center">
                                    <svg class="h-6 w-6 text-blue-600 mr-2" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <path d="M12 3L2 7l10 4 10-4-10-4z"/>
                                        <path d="M2 17l10 4 10-4"/>
                                        <path d="M2 12l10 4 10-4"/>
                                    </svg>
                                    "Your Rights Under Title 28"
                                </h3>
                                <ul class="space-y-3 text-gray-600">
                                    <li class="flex items-start">
                                        <svg class="h-5 w-5 text-blue-600 mr-2 flex-shrink-0 mt-0.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14"/><path d="M12 5l7 7-7 7"/></svg>
                                        "Right to be heard by the court (28 U.S.C. § 1654)"
                                    </li>
                                    <li class="flex items-start">
                                        <svg class="h-5 w-5 text-blue-600 mr-2 flex-shrink-0 mt-0.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14"/><path d="M12 5l7 7-7 7"/></svg>
                                        "Right to present evidence and call witnesses"
                                    </li>
                                    <li class="flex items-start">
                                        <svg class="h-5 w-5 text-blue-600 mr-2 flex-shrink-0 mt-0.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14"/><path d="M12 5l7 7-7 7"/></svg>
                                        "Right to legal representation or self-representation"
                                    </li>
                                    <li class="flex items-start">
                                        <svg class="h-5 w-5 text-blue-600 mr-2 flex-shrink-0 mt-0.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14"/><path d="M12 5l7 7-7 7"/></svg>
                                        "Right to appeal decisions (28 U.S.C. § 1291)"
                                    </li>
                                </ul>
                            </div>

                            // Preparing for Trial
                            <div class="bg-white p-6 rounded-lg shadow-lg">
                                <h3 class="text-xl font-bold mb-4 flex items-center">
                                    <svg class="h-6 w-6 text-blue-600 mr-2" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
                                        <polyline points="14 2 14 8 20 8"/>
                                        <line x1="16" y1="13" x2="8" y2="13"/>
                                        <line x1="16" y1="17" x2="8" y2="17"/>
                                    </svg>
                                    "Preparing for Trial"
                                </h3>
                                <ul class="space-y-3 text-gray-600">
                                    <li class="flex items-start">
                                        <svg class="h-5 w-5 text-blue-600 mr-2 flex-shrink-0 mt-0.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14"/><path d="M12 5l7 7-7 7"/></svg>
                                        "Organize all documents chronologically"
                                    </li>
                                    <li class="flex items-start">
                                        <svg class="h-5 w-5 text-blue-600 mr-2 flex-shrink-0 mt-0.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14"/><path d="M12 5l7 7-7 7"/></svg>
                                        "Prepare witness statements in advance"
                                    </li>
                                    <li class="flex items-start">
                                        <svg class="h-5 w-5 text-blue-600 mr-2 flex-shrink-0 mt-0.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14"/><path d="M12 5l7 7-7 7"/></svg>
                                        "Review court procedures and local rules"
                                    </li>
                                    <li class="flex items-start">
                                        <svg class="h-5 w-5 text-blue-600 mr-2 flex-shrink-0 mt-0.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14"/><path d="M12 5l7 7-7 7"/></svg>
                                        "Practice your presentation clearly"
                                    </li>
                                </ul>
                            </div>

                            // Presenting Your Case
                            <div class="bg-white p-6 rounded-lg shadow-lg">
                                <h3 class="text-xl font-bold mb-4 flex items-center">
                                    <svg class="h-6 w-6 text-blue-600 mr-2" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <circle cx="12" cy="12" r="10"/>
                                        <path d="M12 8v4l3 3"/>
                                    </svg>
                                    "Presenting Your Case"
                                </h3>
                                <ul class="space-y-3 text-gray-600">
                                    <li class="flex items-start">
                                        <svg class="h-5 w-5 text-blue-600 mr-2 flex-shrink-0 mt-0.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14"/><path d="M12 5l7 7-7 7"/></svg>
                                        "Speak clearly and respectfully to the court"
                                    </li>
                                    <li class="flex items-start">
                                        <svg class="h-5 w-5 text-blue-600 mr-2 flex-shrink-0 mt-0.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14"/><path d="M12 5l7 7-7 7"/></svg>
                                        "Present evidence systematically"
                                    </li>
                                    <li class="flex items-start">
                                        <svg class="h-5 w-5 text-blue-600 mr-2 flex-shrink-0 mt-0.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14"/><path d="M12 5l7 7-7 7"/></svg>
                                        "Listen carefully to all questions"
                                    </li>
                                    <li class="flex items-start">
                                        <svg class="h-5 w-5 text-blue-600 mr-2 flex-shrink-0 mt-0.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14"/><path d="M12 5l7 7-7 7"/></svg>
                                        "Stay focused on relevant facts"
                                    </li>
                                </ul>
                            </div>
                        </div>

                        // Common Terms and FAQ
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                            // Common Terms
                            <div class="bg-white p-6 rounded-lg shadow-lg">
                                <h3 class="text-xl font-bold mb-4">"Common Legal Terms"</h3>
                                <dl class="space-y-4">
                                    <div>
                                        <dt class="font-semibold text-blue-600">"Plaintiff"</dt>
                                        <dd class="text-gray-600">"The party who initiates a lawsuit"</dd>
                                    </div>
                                    <div>
                                        <dt class="font-semibold text-blue-600">"Defendant"</dt>
                                        <dd class="text-gray-600">"The party being sued or accused"</dd>
                                    </div>
                                    <div>
                                        <dt class="font-semibold text-blue-600">"Jurisdiction"</dt>
                                        <dd class="text-gray-600">"The court's authority to hear a case (Title 28, Ch. 85)"</dd>
                                    </div>
                                    <div>
                                        <dt class="font-semibold text-blue-600">"Venue"</dt>
                                        <dd class="text-gray-600">"The proper location for trial (28 U.S.C. § 1391)"</dd>
                                    </div>
                                </dl>
                            </div>

                            // FAQ
                            <div class="bg-white p-6 rounded-lg shadow-lg">
                                <h3 class="text-xl font-bold mb-4 flex items-center">
                                    <svg class="h-6 w-6 text-blue-600 mr-2" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <circle cx="12" cy="12" r="10"/>
                                        <path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3"/>
                                        <line x1="12" y1="17" x2="12.01" y2="17"/>
                                    </svg>
                                    "Frequently Asked Questions"
                                </h3>
                                <div class="space-y-4">
                                    <div>
                                        <h4 class="font-semibold text-blue-600">"Can I represent myself in federal court?"</h4>
                                        <p class="text-gray-600">"Yes. Under 28 U.S.C. § 1654, you may plead and conduct your own case personally."</p>
                                    </div>
                                    <div>
                                        <h4 class="font-semibold text-blue-600">"How do I know which court to file in?"</h4>
                                        <p class="text-gray-600">"Title 28 defines jurisdiction and venue. Use our Court Finder to locate the right court."</p>
                                    </div>
                                    <div>
                                        <h4 class="font-semibold text-blue-600">"What if I can't afford filing fees?"</h4>
                                        <p class="text-gray-600">"You may petition to proceed in forma pauperis under 28 U.S.C. § 1915."</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="mt-8 text-center">
                            <a href="/help" class="inline-flex items-center text-blue-600 hover:text-blue-700">
                                "Need more help?"
                                <svg class="h-5 w-5 ml-1" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <path d="M5 12h14"/>
                                    <path d="M12 5l7 7-7 7"/>
                                </svg>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    }
}

#[component]
fn FeatureCard(icon: &'static str, title: &'static str, description: &'static str) -> impl IntoView {
    let svg = match icon {
        "scale" => view! {
            <svg class="h-12 w-12 mx-auto mb-4 text-blue-600" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M12 3L2 7l10 4 10-4-10-4z"/>
                <path d="M2 17l10 4 10-4"/>
                <path d="M2 12l10 4 10-4"/>
            </svg>
        }.into_any(),
        "gavel" => view! {
            <svg class="h-12 w-12 mx-auto mb-4 text-blue-600" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <circle cx="12" cy="12" r="10"/>
                <path d="M12 8v4l3 3"/>
            </svg>
        }.into_any(),
        "users" => view! {
            <svg class="h-12 w-12 mx-auto mb-4 text-blue-600" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
                <circle cx="9" cy="7" r="4"/>
                <path d="M23 21v-2a4 4 0 0 0-3-3.87"/>
                <path d="M16 3.13a4 4 0 0 1 0 7.75"/>
            </svg>
        }.into_any(),
        _ => view! {
            <svg class="h-12 w-12 mx-auto mb-4 text-blue-600" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
                <polyline points="14 2 14 8 20 8"/>
                <line x1="16" y1="13" x2="8" y2="13"/>
                <line x1="16" y1="17" x2="8" y2="17"/>
            </svg>
        }.into_any(),
    };

    view! {
        <div class="text-center p-6">
            {svg}
            <h3 class="text-xl font-bold mb-2">{title}</h3>
            <p class="text-gray-600">{description}</p>
        </div>
    }
}
