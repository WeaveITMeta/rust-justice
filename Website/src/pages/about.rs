use leptos::prelude::*;

#[component]
pub fn About() -> impl IntoView {
    view! {
        <div>
            // Hero
            <section class="gradient-hero text-white py-16 lg:py-24">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
                    <h1 class="text-4xl md:text-5xl font-bold mb-6">"About Justice System"</h1>
                    <p class="text-xl text-slate-300 max-w-3xl mx-auto">
                        "An open-source framework for transforming criminal justice, victim support, 
                        and digital identity protection through technology and collaboration."
                    </p>
                </div>
            </section>

            // Mission
            <section class="py-20 bg-white">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="grid md:grid-cols-2 gap-12 items-center">
                        <div>
                            <h2 class="section-title">"Our Mission"</h2>
                            <p class="text-lg text-slate-600 mb-6">
                                "Transform criminal justice, victim support, and digital identity protection through:"
                            </p>
                            <ul class="space-y-4">
                                <MissionItem
                                    icon="📊"
                                    title="Evidence-Based Reform"
                                    description="Data-driven policy and practice"
                                />
                                <MissionItem
                                    icon="💚"
                                    title="Victim-Centered Services"
                                    description="24/7 AI-powered crisis support"
                                />
                                <MissionItem
                                    icon="🛡️"
                                    title="Preemptive Protection"
                                    description="Detect and prevent harm before it escalates"
                                />
                                <MissionItem
                                    icon="🔐"
                                    title="Digital Rights"
                                    description="Protect identity and privacy across all platforms"
                                />
                                <MissionItem
                                    icon="🤝"
                                    title="Open Collaboration"
                                    description="Community-driven innovation and improvement"
                                />
                            </ul>
                        </div>
                        <div class="bg-slate-100 rounded-2xl p-8">
                            <h3 class="text-2xl font-bold text-slate-900 mb-6">"Why This Matters"</h3>
                            <div class="space-y-6">
                                <ImpactStat
                                    number="Millions"
                                    description="experience crime victimization without adequate support each year"
                                />
                                <ImpactStat
                                    number="Thousands"
                                    description="suffer identity theft and deepfake exploitation"
                                />
                                <ImpactStat
                                    number="Billions"
                                    description="in economic harm from cybercrime annually"
                                />
                                <ImpactStat
                                    number="Countless"
                                    description="opportunities missed for early intervention and prevention"
                                />
                            </div>
                            <p class="mt-6 text-lg font-semibold text-blue-600">
                                "We can do better."
                            </p>
                        </div>
                    </div>
                </div>
            </section>

            // Core Principles
            <section class="py-20 bg-slate-50">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="text-center mb-16">
                        <h2 class="section-title">"Core Principles"</h2>
                    </div>

                    <div class="grid md:grid-cols-3 gap-8">
                        <PrincipleCard title="Justice System">
                            <PrincipleItem text="Evidence-Based: Data-driven policy and practice" />
                            <PrincipleItem text="Accountability: Transparent oversight and review" />
                            <PrincipleItem text="Fairness: Equal treatment and due process" />
                            <PrincipleItem text="Rehabilitation: Focus on reintegration and support" />
                            <PrincipleItem text="Victim-Centered: Rights and services for victims" />
                        </PrincipleCard>

                        <PrincipleCard title="Technology">
                            <PrincipleItem text="Privacy-Preserving: Constitutional protections" />
                            <PrincipleItem text="Transparent: Open algorithms and decisions" />
                            <PrincipleItem text="Accountable: Human oversight and appeals" />
                            <PrincipleItem text="Effective: Measurable outcome improvements" />
                            <PrincipleItem text="Accessible: Multi-language, cross-platform" />
                        </PrincipleCard>

                        <PrincipleCard title="Digital Identity">
                            <PrincipleItem text="Self-Sovereignty: Individual control over identity" />
                            <PrincipleItem text="Self-Governance: Community-driven standards" />
                            <PrincipleItem text="Self-Determination: Choice in identity management" />
                            <PrincipleItem text="Self-Control: Authority over personal data" />
                        </PrincipleCard>
                    </div>
                </div>
            </section>

            // Impact Goals
            <section class="py-20 bg-white">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="text-center mb-16">
                        <h2 class="section-title">"Impact Goals"</h2>
                    </div>

                    <div class="grid md:grid-cols-2 gap-12">
                        <div class="card">
                            <h3 class="text-2xl font-bold text-slate-900 mb-6">"By 2027"</h3>
                            <ul class="space-y-3">
                                <GoalItem text="1M+ individuals served by AI Legal Hotline" />
                                <GoalItem text="50+ organizations deploying components" />
                                <GoalItem text="25+ states with adopted legislation" />
                                <GoalItem text="50% reduction in identity theft among users" />
                                <GoalItem text="30% reduction in repeat victimization" />
                            </ul>
                        </div>
                        <div class="card bg-gradient-to-br from-blue-50 to-purple-50">
                            <h3 class="text-2xl font-bold text-slate-900 mb-6">"By 2028+"</h3>
                            <ul class="space-y-3">
                                <GoalItem text="10M+ individuals served annually" />
                                <GoalItem text="50+ countries with deployments" />
                                <GoalItem text="Global standard for digital identity protection" />
                                <GoalItem text="Measurable transformation of justice outcomes" />
                                <GoalItem text="Self-sustaining open-source ecosystem" />
                            </ul>
                        </div>
                    </div>
                </div>
            </section>

            // Team / Community
            <section class="py-20 bg-slate-900 text-white">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
                    <h2 class="text-3xl md:text-4xl font-bold mb-6">"Join the Community"</h2>
                    <p class="text-xl text-slate-400 max-w-3xl mx-auto mb-10">
                        "Whether you're a researcher, developer, legal professional, advocate, 
                        designer, or writer — you can make a difference."
                    </p>
                    <div class="flex flex-col sm:flex-row gap-4 justify-center">
                        <a href="https://github.com/WeaveITMeta/Justice" target="_blank" class="btn-primary">
                            "Contribute on GitHub"
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
fn MissionItem(icon: &'static str, title: &'static str, description: &'static str) -> impl IntoView {
    view! {
        <li class="flex items-start gap-4">
            <span class="text-2xl">{icon}</span>
            <div>
                <span class="font-semibold text-slate-900">{title}": "</span>
                <span class="text-slate-600">{description}</span>
            </div>
        </li>
    }
}

#[component]
fn ImpactStat(number: &'static str, description: &'static str) -> impl IntoView {
    view! {
        <div>
            <span class="text-2xl font-bold text-amber-500">{number}</span>
            <span class="text-slate-600">" "{description}</span>
        </div>
    }
}

#[component]
fn PrincipleCard(title: &'static str, children: Children) -> impl IntoView {
    view! {
        <div class="card">
            <h3 class="text-xl font-bold text-slate-900 mb-4">{title}</h3>
            <ul class="space-y-2">
                {children()}
            </ul>
        </div>
    }
}

#[component]
fn PrincipleItem(text: &'static str) -> impl IntoView {
    view! {
        <li class="flex items-start gap-2 text-slate-600">
            <span class="text-emerald-500 mt-1">"✓"</span>
            <span>{text}</span>
        </li>
    }
}

#[component]
fn GoalItem(text: &'static str) -> impl IntoView {
    view! {
        <li class="flex items-center gap-3">
            <span class="text-emerald-500">"✅"</span>
            <span class="text-slate-700">{text}</span>
        </li>
    }
}
