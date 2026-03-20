use leptos::prelude::*;

#[component]
pub fn Platform() -> impl IntoView {
    view! {
        <div>
            // Hero
            <section class="gradient-hero text-white py-16 lg:py-24">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
                    <h1 class="text-4xl md:text-5xl font-bold mb-6">"Platform Overview"</h1>
                    <p class="text-xl text-slate-300 max-w-3xl mx-auto">
                        "Four integrated technology systems working together to transform 
                        justice delivery across the United States."
                    </p>
                </div>
            </section>

            // AI Legal Hotline
            <section class="py-20 bg-white">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="grid md:grid-cols-2 gap-12 items-center">
                        <div>
                            <div class="inline-flex items-center gap-2 bg-blue-100 text-blue-800 px-4 py-2 rounded-full text-sm font-medium mb-4">
                                <span>"🤖"</span>
                                <span>"Core System"</span>
                            </div>
                            <h2 class="text-3xl md:text-4xl font-bold text-slate-900 mb-6">
                                "AI Legal Hotline"
                            </h2>
                            <p class="text-lg text-slate-600 mb-6">
                                "24/7 crisis support and legal assistance powered by advanced AI, 
                                providing immediate help when it matters most."
                            </p>
                            <ul class="space-y-4">
                                <FeatureItem text="Real-time voice AI (Ultravox + GPT-4)" />
                                <FeatureItem text="Legal case management and tracking" />
                                <FeatureItem text="Evidence visualization and preservation" />
                                <FeatureItem text="Automated transcription and analysis" />
                                <FeatureItem text="Blockchain evidence chain of custody" />
                            </ul>
                        </div>
                        <div class="bg-gradient-to-br from-blue-500 to-blue-700 rounded-2xl p-8 text-white">
                            <h3 class="text-2xl font-bold mb-6">"Technical Stack"</h3>
                            <div class="space-y-4">
                                <TechItem label="Orchestration" value="n8n (GCP)" />
                                <TechItem label="Voice AI" value="Ultravox + OpenAI GPT-4 + ElevenLabs" />
                                <TechItem label="Telephony" value="Twilio" />
                                <TechItem label="Database" value="PostgreSQL + Redis" />
                                <TechItem label="Embeddings" value="Nomic Atlas Enterprise" />
                                <TechItem label="Case Law" value="Grok 4 API" />
                                <TechItem label="Infrastructure" value="Rust + TypeScript" />
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            // Sentinel Detection
            <section class="py-20 bg-slate-50">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="grid md:grid-cols-2 gap-12 items-center">
                        <div class="order-2 md:order-1 bg-gradient-to-br from-purple-500 to-purple-700 rounded-2xl p-8 text-white">
                            <h3 class="text-2xl font-bold mb-6">"How It Works"</h3>
                            <div class="space-y-6">
                                <ProcessStep number="1" title="Communication Analysis" description="Real-time pattern recognition across communications" />
                                <ProcessStep number="2" title="Contrastive Learning" description="Positive/negative index comparison for risk detection" />
                                <ProcessStep number="3" title="Expert Integration" description="Legal analyst review for escalation decisions" />
                                <ProcessStep number="4" title="Constitutional Compliance" description="Built-in safeguards for civil liberties" />
                            </div>
                        </div>
                        <div class="order-1 md:order-2">
                            <div class="inline-flex items-center gap-2 bg-purple-100 text-purple-800 px-4 py-2 rounded-full text-sm font-medium mb-4">
                                <span>"🔍"</span>
                                <span>"Prevention System"</span>
                            </div>
                            <h2 class="text-3xl md:text-4xl font-bold text-slate-900 mb-6">
                                "Sentinel Detection System"
                            </h2>
                            <p class="text-lg text-slate-600 mb-6">
                                "Preemptive legal risk detection using contrastive learning, 
                                designed to identify and prevent harm before escalation."
                            </p>
                            <ul class="space-y-4">
                                <FeatureItem text="Rust-based high-performance processing" />
                                <FeatureItem text="ML-powered pattern recognition" />
                                <FeatureItem text="AI Legal Hotline integration" />
                                <FeatureItem text="Law enforcement system connectivity" />
                                <FeatureItem text="Blockchain chain of custody" />
                            </ul>
                        </div>
                    </div>
                </div>
            </section>

            // Identity Protection
            <section class="py-20 bg-white">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="grid md:grid-cols-2 gap-12 items-center">
                        <div>
                            <div class="inline-flex items-center gap-2 bg-amber-100 text-amber-800 px-4 py-2 rounded-full text-sm font-medium mb-4">
                                <span>"🆔"</span>
                                <span>"Protection Platform"</span>
                            </div>
                            <h2 class="text-3xl md:text-4xl font-bold text-slate-900 mb-6">
                                "Digital Identity Protection"
                            </h2>
                            <p class="text-lg text-slate-600 mb-6">
                                "Multi-language SDK for platform-level identity protection with 
                                government-grade verification and blockchain tracking."
                            </p>
                            <ul class="space-y-4">
                                <FeatureItem text="Government ID + biometric verification" />
                                <FeatureItem text="Multi-blockchain tracking (8+ networks)" />
                                <FeatureItem text="Cross-platform monitoring" />
                                <FeatureItem text="Instant takedown authority" />
                                <FeatureItem text="48-hour compliance (Take It Down Act)" />
                            </ul>
                        </div>
                        <div class="bg-gradient-to-br from-amber-500 to-orange-600 rounded-2xl p-8 text-white">
                            <h3 class="text-2xl font-bold mb-6">"Supported Platforms"</h3>
                            <div class="grid grid-cols-2 gap-4">
                                <PlatformBadge name="Facebook" />
                                <PlatformBadge name="Instagram" />
                                <PlatformBadge name="TikTok" />
                                <PlatformBadge name="Twitter/X" />
                                <PlatformBadge name="YouTube" />
                                <PlatformBadge name="Snapchat" />
                                <PlatformBadge name="Discord" />
                                <PlatformBadge name="LinkedIn" />
                            </div>
                            <h3 class="text-xl font-bold mt-8 mb-4">"Blockchain Networks"</h3>
                            <div class="flex flex-wrap gap-2">
                                <ChainBadge name="Cardano" />
                                <ChainBadge name="Ethereum" />
                                <ChainBadge name="Polygon" />
                                <ChainBadge name="Solana" />
                                <ChainBadge name="Bitcoin" />
                                <ChainBadge name="Polkadot" />
                                <ChainBadge name="Chainlink" />
                                <ChainBadge name="ICP" />
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            // Take It Down Act
            <section class="py-20 bg-slate-900 text-white">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="text-center mb-12">
                        <h2 class="text-3xl md:text-4xl font-bold mb-4">"Take It Down Act (2025)"</h2>
                        <p class="text-xl text-slate-400 max-w-3xl mx-auto">
                            "Federal legislation for NCII removal and identity protection"
                        </p>
                    </div>
                    <div class="grid md:grid-cols-4 gap-6">
                        <ActCard icon="⏱️" title="48-Hour" description="Takedown requirement" />
                        <ActCard icon="📋" title="Mandatory" description="Platform compliance" />
                        <ActCard icon="💰" title="$10M+" description="Non-compliance penalties" />
                        <ActCard icon="🌍" title="Global" description="Cross-border enforcement" />
                    </div>
                </div>
            </section>
        </div>
    }
}

#[component]
fn FeatureItem(text: &'static str) -> impl IntoView {
    view! {
        <li class="flex items-center gap-3">
            <span class="text-emerald-500">"✓"</span>
            <span class="text-slate-700">{text}</span>
        </li>
    }
}

#[component]
fn TechItem(label: &'static str, value: &'static str) -> impl IntoView {
    view! {
        <div class="flex justify-between items-center border-b border-white/20 pb-2">
            <span class="text-white/70">{label}</span>
            <span class="font-medium">{value}</span>
        </div>
    }
}

#[component]
fn ProcessStep(number: &'static str, title: &'static str, description: &'static str) -> impl IntoView {
    view! {
        <div class="flex gap-4">
            <div class="w-8 h-8 rounded-full bg-white/20 flex items-center justify-center font-bold text-sm">
                {number}
            </div>
            <div>
                <div class="font-semibold">{title}</div>
                <div class="text-white/70 text-sm">{description}</div>
            </div>
        </div>
    }
}

#[component]
fn PlatformBadge(name: &'static str) -> impl IntoView {
    view! {
        <div class="bg-white/20 rounded-lg px-3 py-2 text-center text-sm font-medium">
            {name}
        </div>
    }
}

#[component]
fn ChainBadge(name: &'static str) -> impl IntoView {
    view! {
        <span class="bg-white/20 rounded-full px-3 py-1 text-sm">
            {name}
        </span>
    }
}

#[component]
fn ActCard(icon: &'static str, title: &'static str, description: &'static str) -> impl IntoView {
    view! {
        <div class="glass rounded-xl p-6 text-center">
            <div class="text-4xl mb-3">{icon}</div>
            <div class="text-2xl font-bold text-amber-400">{title}</div>
            <div class="text-slate-400">{description}</div>
        </div>
    }
}
