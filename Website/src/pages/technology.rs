use leptos::prelude::*;

#[component]
pub fn Technology() -> impl IntoView {
    view! {
        <div>
            // Hero
            <section class="gradient-hero text-white py-16 lg:py-24">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
                    <h1 class="text-4xl md:text-5xl font-bold mb-6">"Technology Stack"</h1>
                    <p class="text-xl text-slate-300 max-w-3xl mx-auto">
                        "Built with cutting-edge technologies for performance, security, and scalability."
                    </p>
                </div>
            </section>

            // Languages & SDKs
            <section class="py-20 bg-white">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="text-center mb-16">
                        <h2 class="section-title">"Multi-Language SDK Support"</h2>
                        <p class="section-subtitle">"20+ language implementations for universal platform integration."</p>
                    </div>
                    <div class="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-5 gap-4">
                        <LangCard name="Rust" icon="🦀" primary=true />
                        <LangCard name="TypeScript" icon="📘" primary=true />
                        <LangCard name="Python" icon="🐍" primary=true />
                        <LangCard name="Go" icon="🐹" primary=true />
                        <LangCard name="Java" icon="☕" primary=false />
                        <LangCard name="Swift" icon="🍎" primary=false />
                        <LangCard name="C#" icon="🎮" primary=false />
                        <LangCard name="C++" icon="⚡" primary=false />
                        <LangCard name="Kotlin" icon="🎯" primary=false />
                        <LangCard name="Ruby" icon="💎" primary=false />
                    </div>
                </div>
            </section>

            // Core Infrastructure
            <section class="py-20 bg-slate-50">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="text-center mb-16">
                        <h2 class="section-title">"Core Infrastructure"</h2>
                    </div>
                    <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
                        <InfraCard title="AI & ML" items=vec![
                            "OpenAI GPT-4 - NLP", "Ultravox - Voice AI", "ElevenLabs - Synthesis",
                            "Nomic Atlas - Embeddings", "Contrastive Learning"
                        ] />
                        <InfraCard title="Blockchain" items=vec![
                            "Cardano (Atala PRISM)", "Ethereum", "Polygon", "Solana", "IPFS"
                        ] />
                        <InfraCard title="Database" items=vec![
                            "PostgreSQL", "Redis", "Loro CRDTs", "IPFS Storage"
                        ] />
                        <InfraCard title="Networking" items=vec![
                            "Lightyear", "QUIC Protocol", "WebSockets", "Twilio"
                        ] />
                        <InfraCard title="Game Engine" items=vec![
                            "Bevy 0.18", "Avian3D Physics", "wgpu Rendering", "Slint UI"
                        ] />
                        <InfraCard title="DevOps" items=vec![
                            "GCP", "n8n Orchestration", "Docker", "GitHub Actions"
                        ] />
                    </div>
                </div>
            </section>

            // Architecture
            <section class="py-20 bg-slate-900 text-white">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="text-center mb-12">
                        <h2 class="text-3xl md:text-4xl font-bold mb-4">"System Architecture"</h2>
                    </div>
                    <div class="bg-slate-800 rounded-2xl p-6 font-mono text-sm overflow-x-auto">
                        <pre class="text-slate-300">{r#"
┌─────────────────────────────────────────────────────────┐
│              JUSTICE SYSTEM PLATFORM                     │
├─────────────────────────────────────────────────────────┤
│  AI Hotline │ Sentinel │ Identity │ 3D Simulation       │
├─────────────────────────────────────────────────────────┤
│           INTEGRATION (justice-eustress)                 │
├─────────────────────────────────────────────────────────┤
│  AI Engine │ Blockchain │ Storage │ Network │ Physics   │
├─────────────────────────────────────────────────────────┤
│              EUSTRESS ENGINE (Bevy 0.18)                 │
└─────────────────────────────────────────────────────────┘"#}</pre>
                    </div>
                </div>
            </section>

            // Security & Open Source
            <section class="py-20 bg-white">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="grid md:grid-cols-2 lg:grid-cols-4 gap-6 mb-16">
                        <SecCard icon="🔐" title="Encryption" desc="End-to-end encryption" />
                        <SecCard icon="🛡️" title="Privacy" desc="GDPR-aligned controls" />
                        <SecCard icon="📜" title="Compliance" desc="Constitutional safeguards" />
                        <SecCard icon="🔍" title="Audit" desc="Blockchain verification" />
                    </div>
                    <div class="text-center">
                        <h3 class="text-2xl font-bold mb-4">"100% Open Source"</h3>
                        <p class="text-slate-600 mb-6">"MIT Licensed. Built by the community, for the community."</p>
                        <div class="flex flex-col sm:flex-row gap-4 justify-center">
                            <a href="https://github.com/WeaveITMeta/Justice" target="_blank" class="btn-primary">"Justice Framework"</a>
                            <a href="https://github.com/WeaveITMeta/EustressEngine" target="_blank" class="btn-secondary">"Eustress Engine"</a>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    }
}

#[component]
fn LangCard(name: &'static str, icon: &'static str, primary: bool) -> impl IntoView {
    let class = if primary { "card text-center border-2 border-blue-200 bg-blue-50" } else { "card text-center" };
    view! {
        <div class=class>
            <div class="text-3xl mb-2">{icon}</div>
            <div class="font-semibold text-slate-900">{name}</div>
            {primary.then(|| view! { <div class="text-xs text-blue-600 mt-1">"Primary"</div> })}
        </div>
    }
}

#[component]
fn InfraCard(title: &'static str, items: Vec<&'static str>) -> impl IntoView {
    view! {
        <div class="card">
            <h3 class="text-xl font-bold text-slate-900 mb-4">{title}</h3>
            <ul class="space-y-2">
                {items.into_iter().map(|item| view! {
                    <li class="text-slate-600 text-sm flex items-center gap-2">
                        <span class="text-emerald-500">"•"</span>{item}
                    </li>
                }).collect::<Vec<_>>()}
            </ul>
        </div>
    }
}

#[component]
fn SecCard(icon: &'static str, title: &'static str, desc: &'static str) -> impl IntoView {
    view! {
        <div class="card text-center">
            <div class="text-4xl mb-4">{icon}</div>
            <h3 class="text-lg font-bold text-slate-900 mb-2">{title}</h3>
            <p class="text-slate-600 text-sm">{desc}</p>
        </div>
    }
}
