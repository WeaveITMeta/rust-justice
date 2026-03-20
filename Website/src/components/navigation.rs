use leptos::prelude::*;

#[component]
pub fn Navigation() -> impl IntoView {
    let (mobile_open, set_mobile_open) = signal(false);

    view! {
        <nav class="gradient-hero sticky top-0 z-50 shadow-lg">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex items-center justify-between h-16">
                    // Logo
                    <a href="/" class="flex items-center space-x-3">
                        <span class="text-3xl">"⚖️"</span>
                        <span class="text-xl font-bold text-white">"Justice System"</span>
                    </a>

                    // Desktop Navigation
                    <div class="hidden md:flex items-center space-x-1">
                        <a href="/" class="nav-link">"Home"</a>
                        <a href="/about" class="nav-link">"About"</a>
                        <a href="/platform" class="nav-link">"Platform"</a>
                        <a href="/simulation" class="nav-link">"3D Simulation"</a>
                        <a href="/technology" class="nav-link">"Technology"</a>
                        <a href="https://github.com/WeaveITMeta/Justice" target="_blank" class="nav-link flex items-center gap-2">
                            <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                                <path d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z"/>
                            </svg>
                            "GitHub"
                        </a>
                    </div>

                    // Mobile menu button
                    <button
                        class="md:hidden p-2 rounded-lg text-white hover:bg-white/10"
                        on:click=move |_| set_mobile_open.update(|v| *v = !*v)
                    >
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"/>
                        </svg>
                    </button>
                </div>

                // Mobile Navigation
                <div
                    class="md:hidden overflow-hidden transition-all duration-300"
                    class:max-h-0=move || !mobile_open.get()
                    class:max-h-96=move || mobile_open.get()
                >
                    <div class="py-4 space-y-2">
                        <a href="/" class="block nav-link">"Home"</a>
                        <a href="/about" class="block nav-link">"About"</a>
                        <a href="/platform" class="block nav-link">"Platform"</a>
                        <a href="/simulation" class="block nav-link">"3D Simulation"</a>
                        <a href="/technology" class="block nav-link">"Technology"</a>
                    </div>
                </div>
            </div>
        </nav>
    }
}
