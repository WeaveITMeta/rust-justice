use leptos::prelude::*;

#[component]
pub fn Home() -> impl IntoView {
    view! {
        <div>
            // Hero Section
            <section class="gradient-hero text-white py-20 lg:py-32">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="text-center">
                        <h1 class="text-4xl md:text-6xl lg:text-7xl font-bold mb-6 text-balance">
                            "Transforming "
                            <span class="gradient-text">"Justice"</span>
                            " Through Technology"
                        </h1>
                        <p class="text-xl md:text-2xl text-slate-300 max-w-4xl mx-auto mb-10 text-balance">
                            "An open-source framework combining 3D simulation, AI, and blockchain 
                            to build a transparent, accountable, and evidence-based U.S. Justice System."
                        </p>
                        <div class="flex flex-col sm:flex-row gap-4 justify-center">
                            <a href="/simulation" class="btn-primary">
                                "Explore 3D Simulation"
                            </a>
                            <a href="https://github.com/WeaveITMeta/Justice" target="_blank" class="btn-secondary">
                                "View on GitHub"
                            </a>
                        </div>
                    </div>
                </div>
            </section>

            // Stats Section
            <section class="py-16 bg-white">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="grid grid-cols-2 md:grid-cols-4 gap-8 text-center">
                        <StatCard number="16" label="System Categories" />
                        <StatCard number="83+" label="Directory Modules" />
                        <StatCard number="20+" label="Language SDKs" />
                        <StatCard number="8" label="Blockchain Networks" />
                    </div>
                </div>
            </section>

            // Vision Section
            <section class="py-20 bg-slate-50">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="text-center mb-16">
                        <h2 class="section-title">"Our Vision"</h2>
                        <p class="section-subtitle">
                            "Build the justice system we all need — transparent, accountable, 
                            evidence-based, and accessible to everyone."
                        </p>
                    </div>

                    <div class="grid md:grid-cols-3 gap-8">
                        <VisionCard
                            icon="🎯"
                            title="Evidence-Based Reform"
                            description="Data-driven policy and practice powered by real-time analytics and comprehensive research."
                        />
                        <VisionCard
                            icon="🛡️"
                            title="Victim-Centered Services"
                            description="24/7 AI-powered crisis support with the AI Legal Hotline and instant takedown authority."
                        />
                        <VisionCard
                            icon="🔮"
                            title="Preemptive Protection"
                            description="Sentinel AI system to detect and prevent harm before it escalates using contrastive learning."
                        />
                    </div>
                </div>
            </section>

            // Core Pillars Section
            <section class="py-20 bg-white">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="text-center mb-16">
                        <h2 class="section-title">"Core Technology Pillars"</h2>
                        <p class="section-subtitle">
                            "Four integrated systems working together to transform justice delivery."
                        </p>
                    </div>

                    <div class="grid md:grid-cols-2 gap-8">
                        <PillarCard
                            gradient="from-blue-600 to-blue-800"
                            icon="🤖"
                            title="AI Legal Hotline"
                            description="24/7 crisis support powered by Ultravox + GPT-4 with real-time voice AI, legal case management, and blockchain evidence preservation."
                            link="/platform"
                        />
                        <PillarCard
                            gradient="from-purple-600 to-purple-800"
                            icon="🔍"
                            title="Sentinel Detection"
                            description="Rust-based preemptive legal risk detection using contrastive learning for real-time communication analysis and pattern recognition."
                            link="/technology"
                        />
                        <PillarCard
                            gradient="from-amber-500 to-orange-600"
                            icon="🆔"
                            title="Identity Protection"
                            description="Multi-language SDK with government ID + biometric verification, blockchain tracking across Cardano, Ethereum, Solana, and more."
                            link="/platform"
                        />
                        <PillarCard
                            gradient="from-emerald-500 to-teal-600"
                            icon="🎮"
                            title="3D Simulation Engine"
                            description="Powered by Eustress Engine for immersive courtroom simulations, training scenarios, and evidence visualization."
                            link="/simulation"
                        />
                    </div>
                </div>
            </section>

            // Justice System Flow
            <section class="py-20 bg-slate-900 text-white">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="text-center mb-16">
                        <h2 class="text-3xl md:text-4xl font-bold mb-4">"Complete Justice System Coverage"</h2>
                        <p class="text-lg text-slate-400 max-w-3xl mx-auto">
                            "Our 16-category taxonomy mirrors the actual U.S. criminal justice system flow, 
                            from initial law enforcement contact through reentry and support services."
                        </p>
                    </div>

                    <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
                        <FlowCard number="00" title="Framework Overview" />
                        <FlowCard number="01" title="Entry into System" />
                        <FlowCard number="02" title="Prosecution & Pretrial" />
                        <FlowCard number="03" title="Adjudication & Trial" />
                        <FlowCard number="04" title="Sentencing" />
                        <FlowCard number="05" title="Corrections" />
                        <FlowCard number="06" title="Reentry" />
                        <FlowCard number="07" title="Victims' Rights" />
                        <FlowCard number="08" title="Oversight & Reform" />
                        <FlowCard number="09" title="Civil Justice" />
                        <FlowCard number="10" title="Alternative Justice" />
                        <FlowCard number="11" title="Data & Statistics" />
                        <FlowCard number="12" title="International" />
                        <FlowCard number="13" title="Technology" />
                        <FlowCard number="14" title="Legislation" />
                        <FlowCard number="15" title="Resources & Tools" />
                    </div>
                </div>
            </section>

            // CTA Section
            <section class="py-20 gradient-hero text-white">
                <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
                    <h2 class="text-3xl md:text-4xl font-bold mb-6">
                        "Ready to Transform Justice?"
                    </h2>
                    <p class="text-xl text-slate-300 mb-10">
                        "Join researchers, developers, legal professionals, and advocates 
                        building the justice system we all need."
                    </p>
                    <div class="flex flex-col sm:flex-row gap-4 justify-center">
                        <a href="https://github.com/WeaveITMeta/Justice" target="_blank" class="btn-primary">
                            "Get Started"
                        </a>
                        <a href="https://discord.gg/gA3pspAAQV" target="_blank" class="btn-secondary">
                            "Join Discord"
                        </a>
                    </div>
                </div>
            </section>
        </div>
    }
}

#[component]
fn StatCard(number: &'static str, label: &'static str) -> impl IntoView {
    view! {
        <div class="p-6">
            <div class="stat-number">{number}</div>
            <div class="text-slate-600 mt-2">{label}</div>
        </div>
    }
}

#[component]
fn VisionCard(icon: &'static str, title: &'static str, description: &'static str) -> impl IntoView {
    view! {
        <div class="card text-center">
            <div class="text-5xl mb-4">{icon}</div>
            <h3 class="text-xl font-bold text-slate-900 mb-3">{title}</h3>
            <p class="text-slate-600">{description}</p>
        </div>
    }
}

#[component]
fn PillarCard(
    gradient: &'static str,
    icon: &'static str,
    title: &'static str,
    description: &'static str,
    link: &'static str,
) -> impl IntoView {
    view! {
        <a href=link class=format!("pillar-card bg-gradient-to-br {}", gradient)>
            <div class="text-4xl mb-4">{icon}</div>
            <h3 class="text-2xl font-bold mb-3">{title}</h3>
            <p class="text-white/80">{description}</p>
            <div class="mt-4 flex items-center text-white/60 hover:text-white transition-colors">
                <span>"Learn more"</span>
                <svg class="w-4 h-4 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                </svg>
            </div>
        </a>
    }
}

#[component]
fn FlowCard(number: &'static str, title: &'static str) -> impl IntoView {
    view! {
        <div class="glass rounded-xl p-4 text-center hover:bg-white/20 transition-colors cursor-default">
            <div class="text-amber-400 font-mono text-sm mb-1">{number}</div>
            <div class="text-sm font-medium">{title}</div>
        </div>
    }
}
