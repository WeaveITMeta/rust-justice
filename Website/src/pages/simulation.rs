use leptos::prelude::*;

#[component]
pub fn Simulation() -> impl IntoView {
    view! {
        <div>
            // Hero
            <section class="gradient-hero text-white py-16 lg:py-24">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
                    <h1 class="text-4xl md:text-5xl font-bold mb-6">"3D Justice Simulation"</h1>
                    <p class="text-xl text-slate-300 max-w-3xl mx-auto">
                        "Immersive 3D environments powered by the Eustress Engine for training, 
                        evidence visualization, and justice system modeling."
                    </p>
                </div>
            </section>

            // Engine Overview
            <section class="py-20 bg-white">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="grid md:grid-cols-2 gap-12 items-center">
                        <div>
                            <div class="inline-flex items-center gap-2 bg-emerald-100 text-emerald-800 px-4 py-2 rounded-full text-sm font-medium mb-4">
                                <span>"🎮"</span>
                                <span>"Powered by Eustress Engine"</span>
                            </div>
                            <h2 class="text-3xl md:text-4xl font-bold text-slate-900 mb-6">
                                "Next-Generation Simulation"
                            </h2>
                            <p class="text-lg text-slate-600 mb-6">
                                "Built on the Eustress Engine — a batteries-included fork of Bevy 
                                with advanced capabilities for justice-centric applications."
                            </p>
                            <ul class="space-y-4">
                                <FeatureItem text="Real-time 3D rendering with Bevy 0.18" />
                                <FeatureItem text="Physics simulation with Avian3D" />
                                <FeatureItem text="Networked multiplayer via Lightyear" />
                                <FeatureItem text="Cross-platform: Desktop, Web, Mobile" />
                                <FeatureItem text="VR/AR ready for immersive training" />
                            </ul>
                        </div>
                        <div class="bg-slate-900 rounded-2xl p-8 text-white">
                            <h3 class="text-2xl font-bold mb-6">"Engine Architecture"</h3>
                            <div class="space-y-4 font-mono text-sm">
                                <CodeBlock>
                                    "Eustress Engine\n"
                                    "├── Core (Bevy 0.18 ECS)\n"
                                    "├── Rendering (wgpu + Slint UI)\n"
                                    "├── Physics (Avian3D)\n"
                                    "├── Networking (Lightyear + QUIC)\n"
                                    "├── Persistence (CRDTs + Loro)\n"
                                    "└── Justice Integration Crate"
                                </CodeBlock>
                            </div>
                            <a href="https://github.com/WeaveITMeta/EustressEngine" target="_blank" class="inline-flex items-center gap-2 mt-6 text-amber-400 hover:text-amber-300">
                                <span>"View Engine Source"</span>
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"/>
                                </svg>
                            </a>
                        </div>
                    </div>
                </div>
            </section>

            // Use Cases
            <section class="py-20 bg-slate-50">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="text-center mb-16">
                        <h2 class="section-title">"Simulation Use Cases"</h2>
                        <p class="section-subtitle">
                            "Transforming how justice professionals train, analyze, and present information."
                        </p>
                    </div>

                    <div class="grid md:grid-cols-3 gap-8">
                        <UseCaseCard
                            icon="⚖️"
                            title="Courtroom Simulation"
                            description="Immersive courtroom environments for training judges, attorneys, and court staff. Practice procedures, examine evidence, and conduct mock trials."
                            features=vec!["Realistic courtroom layouts", "Role-based perspectives", "Procedural training scenarios"]
                        />
                        <UseCaseCard
                            icon="🔬"
                            title="Evidence Visualization"
                            description="3D reconstruction of crime scenes, accident sites, and complex evidence for clearer presentation to juries and investigators."
                            features=vec!["Crime scene reconstruction", "Forensic evidence display", "Timeline visualization"]
                        />
                        <UseCaseCard
                            icon="👮"
                            title="Law Enforcement Training"
                            description="De-escalation training, procedural compliance, and scenario-based learning in safe virtual environments."
                            features=vec!["De-escalation scenarios", "Use of force training", "Community interaction"]
                        />
                        <UseCaseCard
                            icon="🏛️"
                            title="Correctional Facilities"
                            description="Virtual tours and training for correctional officers, rehabilitation program visualization, and facility planning."
                            features=vec!["Facility walkthroughs", "Emergency response drills", "Rehabilitation programs"]
                        />
                        <UseCaseCard
                            icon="📚"
                            title="Legal Education"
                            description="Interactive learning environments for law students to experience courtroom dynamics and legal procedures firsthand."
                            features=vec!["Moot court practice", "Case study simulations", "Procedural learning"]
                        />
                        <UseCaseCard
                            icon="🤝"
                            title="Restorative Justice"
                            description="Virtual spaces for victim-offender mediation, community conferencing, and restorative dialogue facilitation."
                            features=vec!["Mediation environments", "Community circles", "Healing spaces"]
                        />
                    </div>
                </div>
            </section>

            // Technical Capabilities
            <section class="py-20 bg-white">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="text-center mb-16">
                        <h2 class="section-title">"Technical Capabilities"</h2>
                    </div>

                    <div class="grid md:grid-cols-2 lg:grid-cols-4 gap-6">
                        <CapabilityCard
                            icon="🖥️"
                            title="Cross-Platform"
                            items=vec!["Windows, macOS, Linux", "WebAssembly (Browser)", "iOS & Android", "VR Headsets"]
                        />
                        <CapabilityCard
                            icon="🌐"
                            title="Networking"
                            items=vec!["Real-time multiplayer", "QUIC protocol", "P2P & Client-Server", "CRDT synchronization"]
                        />
                        <CapabilityCard
                            icon="🎨"
                            title="Rendering"
                            items=vec!["PBR materials", "Dynamic lighting", "Post-processing", "GPU-accelerated"]
                        />
                        <CapabilityCard
                            icon="⚙️"
                            title="Simulation"
                            items=vec!["Rigid body physics", "Collision detection", "Spatial audio", "AI behaviors"]
                        />
                    </div>
                </div>
            </section>

            // Integration
            <section class="py-20 bg-slate-900 text-white">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="text-center mb-12">
                        <h2 class="text-3xl md:text-4xl font-bold mb-4">"Justice-Eustress Integration"</h2>
                        <p class="text-xl text-slate-400 max-w-3xl mx-auto">
                            "A dedicated integration crate keeps justice-specific features separate 
                            from the core engine, enabling clean upstream updates."
                        </p>
                    </div>
                    <div class="bg-slate-800 rounded-2xl p-8 max-w-3xl mx-auto">
                        <div class="font-mono text-sm text-slate-300">
                            <div class="text-slate-500">"// Cargo.toml"</div>
                            <div>"[dependencies]"</div>
                            <div class="text-amber-400">"justice-eustress = \"0.1\""</div>
                            <div class="mt-4 text-slate-500">"// main.rs"</div>
                            <div>"use justice_eustress::prelude::*;"</div>
                            <div class="mt-2">"fn main() {"</div>
                            <div>"    App::new()"</div>
                            <div>"        .add_plugins(JusticePlugins)"</div>
                            <div>"        .add_plugins(CourtroomPlugin)"</div>
                            <div>"        .add_plugins(EvidenceVisualizationPlugin)"</div>
                            <div>"        .run();"</div>
                            <div>"}"</div>
                        </div>
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
fn CodeBlock(children: Children) -> impl IntoView {
    view! {
        <pre class="bg-slate-800 rounded-lg p-4 overflow-x-auto whitespace-pre">
            {children()}
        </pre>
    }
}

#[component]
fn UseCaseCard(
    icon: &'static str,
    title: &'static str,
    description: &'static str,
    features: Vec<&'static str>,
) -> impl IntoView {
    view! {
        <div class="card">
            <div class="text-4xl mb-4">{icon}</div>
            <h3 class="text-xl font-bold text-slate-900 mb-3">{title}</h3>
            <p class="text-slate-600 mb-4">{description}</p>
            <ul class="space-y-2">
                {features.into_iter().map(|f| view! {
                    <li class="flex items-center gap-2 text-sm text-slate-500">
                        <span class="text-emerald-500">"•"</span>
                        {f}
                    </li>
                }).collect::<Vec<_>>()}
            </ul>
        </div>
    }
}

#[component]
fn CapabilityCard(icon: &'static str, title: &'static str, items: Vec<&'static str>) -> impl IntoView {
    view! {
        <div class="card text-center">
            <div class="text-4xl mb-4">{icon}</div>
            <h3 class="text-lg font-bold text-slate-900 mb-4">{title}</h3>
            <ul class="space-y-2">
                {items.into_iter().map(|item| view! {
                    <li class="text-slate-600 text-sm">{item}</li>
                }).collect::<Vec<_>>()}
            </ul>
        </div>
    }
}
