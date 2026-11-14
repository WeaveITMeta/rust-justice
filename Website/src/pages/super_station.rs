use leptos::prelude::*;

/// The published Justice Super Station on Eustress.
const STATION_URL: &str = "https://eustress.dev/simulation/c285aff6-a5d3-4ec5-b0e5-37c6415c56dc";

#[component]
pub fn SuperStation() -> impl IntoView {
    view! {
        <div>
            // Hero
            <section class="bg-slate-900 text-white py-16 lg:py-24">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
                    <div class="inline-flex items-center gap-2 bg-white/10 px-4 py-2 rounded-full text-sm font-medium mb-6">
                        <span>"Live on Eustress"</span>
                    </div>
                    <h1 class="text-4xl md:text-5xl font-bold mb-6">"Justice Super Station"</h1>
                    <p class="text-xl text-slate-300 max-w-3xl mx-auto mb-10">
                        "Describe a legal problem in plain words. The station shows where it sits in the
                        U.S. justice system: where it starts, where it resolves, and which part of this
                        repository holds each topic."
                    </p>
                    <a
                        href=STATION_URL
                        target="_blank"
                        rel="noopener"
                        class="inline-flex items-center gap-2 bg-blue-600 hover:bg-blue-700 text-white text-lg font-semibold px-8 py-4 rounded-lg transition-colors"
                    >
                        <span>"Open the Super Station"</span>
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"/>
                        </svg>
                    </a>
                    <p class="text-sm text-slate-400 mt-4">"Opens eustress.dev in a new tab."</p>
                </div>
            </section>

            // How it works
            <section class="py-20 bg-white">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="text-center mb-16">
                        <h2 class="text-3xl md:text-4xl font-bold text-slate-900 mb-4">"How it works"</h2>
                        <p class="text-lg text-slate-600 max-w-3xl mx-auto">
                            "Twenty-four rings of words surround a Sun named Equal Justice Under Law.
                            Each ring is one part of the justice system."
                        </p>
                    </div>
                    <div class="grid md:grid-cols-3 gap-8">
                        <Step number="1" title="Type the problem"
                            text="Press Play and write what happened, the way you would say it to a friend. For example: I was arrested and cannot afford a lawyer." />
                        <Step number="2" title="The rings turn"
                            text="The station scores every word cube against your words, turns its rings, and lights rays from the Sun through the words that line up." />
                        <Step number="3" title="Read the path"
                            text="The reading lists the topics you named, where the problem starts, where it resolves, and any federal statute on file for it." />
                    </div>
                </div>
            </section>

            // What it covers
            <section class="py-20 bg-slate-50">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="grid md:grid-cols-2 gap-12">
                        <div>
                            <h2 class="text-3xl font-bold text-slate-900 mb-6">"What it covers"</h2>
                            <ul class="space-y-4 text-slate-700">
                                <Item text="The path of a case: entry, pretrial, trial, sentencing, corrections and reentry." />
                                <Item text="Victims, civil matters, rights, evidence and procedure." />
                                <Item text="Two federal statutes with their elements, penalties and text: 18 U.S.C. 1341 (mail fraud) and 1343 (wire fraud)." />
                                <Item text="Each topic names the folder of this open-source repository that holds it." />
                            </ul>
                        </div>
                        <div>
                            <h2 class="text-3xl font-bold text-slate-900 mb-6">"What it is not"</h2>
                            <ul class="space-y-4 text-slate-700">
                                <Item text="It is not legal advice. A statute applies only when every element is proved, and state law may apply instead." />
                                <Item text="It is not a language model. It matches words and searches ring positions for the best alignment." />
                                <Item text="It never scores or judges a person." />
                                <Item text="It calls no network and stores nothing about you." />
                            </ul>
                        </div>
                    </div>
                </div>
            </section>

            // Closing call
            <section class="py-20 bg-slate-900 text-white">
                <div class="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
                    <h2 class="text-3xl md:text-4xl font-bold mb-6">"Try it with your own question"</h2>
                    <p class="text-lg text-slate-300 mb-8">
                        "The station is published on Eustress. Its word list, its generator and a
                        reference solver are open for anyone to read."
                    </p>
                    <div class="flex flex-col sm:flex-row gap-4 justify-center">
                        <a href=STATION_URL target="_blank" rel="noopener"
                            class="inline-flex items-center justify-center bg-blue-600 hover:bg-blue-700 px-8 py-4 rounded-lg font-semibold transition-colors">
                            "Open the Super Station"
                        </a>
                        <a href="https://github.com/WeaveITMeta/rust-justice" target="_blank" rel="noopener"
                            class="inline-flex items-center justify-center bg-white/10 hover:bg-white/20 px-8 py-4 rounded-lg font-semibold transition-colors">
                            "Read the source"
                        </a>
                    </div>
                </div>
            </section>
        </div>
    }
}

#[component]
fn Step(number: &'static str, title: &'static str, text: &'static str) -> impl IntoView {
    view! {
        <div class="bg-white rounded-2xl border border-slate-200 p-8 shadow-sm">
            <div class="w-12 h-12 rounded-full bg-blue-600 text-white flex items-center justify-center text-xl font-bold mb-6">{number}</div>
            <h3 class="text-xl font-bold text-slate-900 mb-3">{title}</h3>
            <p class="text-slate-600">{text}</p>
        </div>
    }
}

#[component]
fn Item(text: &'static str) -> impl IntoView {
    view! {
        <li class="flex items-start gap-3">
            <span class="text-blue-600 font-bold mt-0.5">"•"</span>
            <span>{text}</span>
        </li>
    }
}
