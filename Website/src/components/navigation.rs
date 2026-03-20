use leptos::prelude::*;

#[component]
pub fn Navigation() -> impl IntoView {
    let (mobile_open, set_mobile_open) = signal(false);

    view! {
        <header class="bg-slate-900 text-white relative z-50">
            <div class="container mx-auto px-4">
                <div class="flex items-center justify-between h-20">
                    // Logo
                    <a href="/" class="flex items-center space-x-3 -ml-2">
                        <span class="text-4xl">"⚖️"</span>
                        <span class="text-2xl font-bold">"Justice"</span>
                    </a>

                    // Desktop Navigation
                    <div class="flex items-center">
                        <nav class="hidden md:flex items-center mr-8">
                            <div class="flex items-center justify-center space-x-4">
                                <a href="/" class="flex items-center justify-center h-[40px] px-2 hover:text-blue-400 transition">"Home"</a>
                                <a href="/courts" class="flex items-center justify-center h-[40px] px-2 hover:text-blue-400 transition">"Courts"</a>
                                <a href="/self-service" class="flex items-center justify-center h-[40px] px-2 hover:text-blue-400 transition">"Service"</a>
                                <a href="/regulation" class="flex items-center justify-center h-[40px] px-2 hover:text-blue-400 transition">"Regulation"</a>
                                <a href="/help" class="flex items-center justify-center h-[40px] px-2 hover:text-blue-400 transition">"Help"</a>
                            </div>
                        </nav>

                        // Sign In button
                        <a
                            href="/help"
                            class="hidden md:flex items-center space-x-2 bg-blue-600 hover:bg-blue-700 px-4 py-2 rounded-lg transition-colors"
                        >
                            <svg class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
                                <circle cx="12" cy="7" r="4"/>
                            </svg>
                            <span>"Get Help"</span>
                        </a>

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
                </div>

                // Mobile Navigation
                <div
                    class="md:hidden overflow-hidden transition-all duration-300"
                    class:max-h-0=move || !mobile_open.get()
                    class:max-h-96=move || mobile_open.get()
                >
                    <div class="py-4 space-y-2 border-t border-slate-700">
                        <a href="/" class="block px-3 py-2 rounded-lg hover:bg-slate-800 transition">"Home"</a>
                        <a href="/courts" class="block px-3 py-2 rounded-lg hover:bg-slate-800 transition">"Courts"</a>
                        <a href="/self-service" class="block px-3 py-2 rounded-lg hover:bg-slate-800 transition">"Service"</a>
                        <a href="/regulation" class="block px-3 py-2 rounded-lg hover:bg-slate-800 transition">"Regulation"</a>
                        <a href="/help" class="block px-3 py-2 rounded-lg hover:bg-slate-800 transition">"Help"</a>
                    </div>
                </div>
            </div>
        </header>
    }
}
