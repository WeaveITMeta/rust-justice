use leptos::prelude::*;

#[component]
pub fn Footer() -> impl IntoView {
    view! {
        <footer class="bg-slate-900 text-white mt-auto">
            <div class="container mx-auto px-4 py-8">
                <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
                    <div>
                        <h3 class="text-lg font-bold mb-4">"Contact Us"</h3>
                        <p class="text-slate-300">"Federal Justice Portal"</p>
                        <p class="text-slate-300">"Title 28 U.S.C."</p>
                        <p class="text-slate-300">"Phone: (555) 123-4567"</p>
                    </div>
                    <div>
                        <h3 class="text-lg font-bold mb-4">"Quick Links"</h3>
                        <ul class="space-y-2">
                            <li><a href="/self-service" class="text-slate-300 hover:text-blue-400 transition">"Forms & Documents"</a></li>
                            <li><a href="/courts" class="text-slate-300 hover:text-blue-400 transition">"Court Calendar"</a></li>
                            <li><a href="/regulation" class="text-slate-300 hover:text-blue-400 transition">"U.S. Code Reference"</a></li>
                        </ul>
                    </div>
                    <div>
                        <h3 class="text-lg font-bold mb-4">"Resources"</h3>
                        <ul class="space-y-2">
                            <li><a href="https://www.uscourts.gov/" target="_blank" class="text-slate-300 hover:text-blue-400 transition">"U.S. Courts"</a></li>
                            <li><a href="https://www.law.cornell.edu/uscode/text/28" target="_blank" class="text-slate-300 hover:text-blue-400 transition">"Title 28 - Full Text"</a></li>
                            <li><a href="https://bjs.ojp.gov/" target="_blank" class="text-slate-300 hover:text-blue-400 transition">"Bureau of Justice Statistics"</a></li>
                            <li><a href="https://www.ussc.gov/" target="_blank" class="text-slate-300 hover:text-blue-400 transition">"U.S. Sentencing Commission"</a></li>
                        </ul>
                    </div>
                    <div>
                        <h3 class="text-lg font-bold mb-4">"Emergency"</h3>
                        <ul class="space-y-2 text-sm">
                            <li>
                                <span class="text-slate-400">"Domestic Violence: "</span>
                                <a href="tel:1-800-799-7233" class="text-white font-medium">"1-800-799-7233"</a>
                            </li>
                            <li>
                                <span class="text-slate-400">"RAINN: "</span>
                                <a href="tel:1-800-656-4673" class="text-white font-medium">"1-800-656-4673"</a>
                            </li>
                            <li>
                                <span class="text-slate-400">"Suicide Prevention: "</span>
                                <a href="tel:988" class="text-white font-medium">"988"</a>
                            </li>
                            <li>
                                <span class="text-slate-400">"Crisis Text: "</span>
                                <span class="text-white font-medium">"HOME to 741741"</span>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="border-t border-slate-700 mt-8 pt-8 text-center">
                    <p class="text-slate-400">"© 2026 Justice Portal. Open-source under MIT License. Built with Rust & Leptos."</p>
                </div>
            </div>
        </footer>
    }
}
