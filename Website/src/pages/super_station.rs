use leptos::prelude::*;

/// The published Justice Super Station on Eustress.
const STATION_URL: &str = "https://eustress.dev/simulation/c285aff6-a5d3-4ec5-b0e5-37c6415c56dc";
const REPO_URL: &str = "https://github.com/WeaveITMeta/rust-justice";

#[component]
pub fn SuperStation() -> impl IntoView {
    view! {
        <div class="bg-slate-950 text-white">
            // Hero: the cover art carries the title, so the heading is for screen readers.
            <section class="relative">
                <h1 class="sr-only">"Justice Super Station"</h1>
                <picture>
                    <source srcset="/assets/justice-super-station.webp" type="image/webp" />
                    <img
                        src="/assets/justice-super-station.jpg"
                        width="1920"
                        height="1080"
                        alt="Justice Super Station: a wood-panelled courtroom whose ceiling opens onto a glowing blue city of rings"
                        class="block w-full h-auto max-h-[78vh] object-cover object-center"
                    />
                </picture>
                <div class="absolute inset-x-0 bottom-0 h-40 bg-gradient-to-t from-slate-950 to-transparent pointer-events-none"></div>
            </section>

            // Pitch and call to action
            <section class="relative -mt-10 pb-16">
                <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
                    <div class="inline-flex items-center gap-2 border border-amber-400/40 bg-amber-400/10 text-amber-300 px-4 py-1.5 rounded-full text-sm font-medium mb-6">
                        <span class="w-2 h-2 rounded-full bg-emerald-400"></span>
                        <span>"Live on Eustress"</span>
                    </div>
                    <p class="text-2xl md:text-3xl font-semibold leading-snug mb-4">
                        "Describe a legal problem in plain words. See where it sits in the justice system."
                    </p>
                    <p class="text-lg text-slate-300 max-w-2xl mx-auto mb-10">
                        "The station shows where the problem starts, where it resolves, and which
                        part of this open repository holds each topic."
                    </p>
                    <div class="flex flex-col sm:flex-row gap-4 justify-center">
                        <a
                            href=STATION_URL
                            target="_blank"
                            rel="noopener"
                            class="inline-flex items-center justify-center gap-2 bg-amber-400 hover:bg-amber-300 text-slate-950 text-lg font-bold px-8 py-4 rounded-lg transition-colors"
                        >
                            <span>"Open the Super Station"</span>
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"/>
                            </svg>
                        </a>
                        <a
                            href=REPO_URL
                            target="_blank"
                            rel="noopener"
                            class="inline-flex items-center justify-center border border-white/20 hover:bg-white/10 text-lg font-semibold px-8 py-4 rounded-lg transition-colors"
                        >
                            "Read the source"
                        </a>
                    </div>
                    <p class="text-sm text-slate-400 mt-4">"Opens eustress.dev in a new tab. Free to open."</p>
                </div>
            </section>

            // A real reading
            <section class="py-20 bg-slate-900 border-y border-white/10">
                <div class="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="text-center mb-12">
                        <h2 class="text-3xl md:text-4xl font-bold mb-4">"One question, one reading"</h2>
                        <p class="text-lg text-slate-300 max-w-2xl mx-auto">
                            "This is what the station returns for the example it ships with."
                        </p>
                    </div>
                    <div class="grid md:grid-cols-5 gap-6 items-stretch">
                        <div class="md:col-span-2 rounded-2xl border border-white/10 bg-slate-950 p-6">
                            <div class="text-xs font-semibold tracking-widest text-amber-300 mb-3">"YOU TYPE"</div>
                            <p class="text-xl font-medium leading-relaxed">
                                "I was arrested and cannot afford a lawyer"
                            </p>
                        </div>
                        <div class="md:col-span-3 rounded-2xl border border-amber-400/30 bg-slate-950 p-6">
                            <div class="text-xs font-semibold tracking-widest text-amber-300 mb-4">"THE STATION TRACES"</div>
                            <ul class="space-y-4">
                                <Ray path="Arrest  >  Defense Attorney" note="Starts at Entry, resolves in Parties. Held in Courtroom Roles." />
                                <Ray path="Counsel" note="In the Rights ring. Held in the Rights Register." />
                                <Ray path="Bail" note="In the Pretrial ring. Held in Prosecution and Pretrial." />
                            </ul>
                        </div>
                    </div>
                </div>
            </section>

            // How it works
            <section class="py-20">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="text-center mb-14">
                        <h2 class="text-3xl md:text-4xl font-bold mb-4">"How it works"</h2>
                        <p class="text-lg text-slate-300 max-w-3xl mx-auto">
                            "Twenty-four rings of words surround a Sun named Equal Justice Under Law.
                            Each ring is one part of the justice system."
                        </p>
                    </div>
                    <div class="grid md:grid-cols-3 gap-6">
                        <Step number="1" title="Type the problem"
                            text="Press Play and write what happened, the way you would say it to a friend." />
                        <Step number="2" title="The rings turn"
                            text="The station scores every word cube against your words, turns its rings, and lights rays from the Sun through the words that line up." />
                        <Step number="3" title="Read the path"
                            text="The reading lists the topics you named, where the problem starts, where it resolves, and any federal statute on file for it." />
                    </div>
                </div>
            </section>

            // What it covers, what it is not
            <section class="py-20 bg-slate-900 border-y border-white/10">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="grid md:grid-cols-2 gap-6">
                        <div class="rounded-2xl border border-white/10 bg-slate-950 p-8">
                            <h2 class="text-2xl font-bold mb-6">"What it covers"</h2>
                            <ul class="space-y-4 text-slate-300">
                                <Item text="The path of a case: entry, pretrial, trial, sentencing, corrections and reentry." />
                                <Item text="Victims, civil matters, rights, evidence and procedure." />
                                <Item text="Two federal statutes with their elements, penalties and text: 18 U.S.C. 1341 (mail fraud) and 1343 (wire fraud)." />
                                <Item text="Each topic names the folder of this open repository that holds it." />
                            </ul>
                        </div>
                        <div class="rounded-2xl border border-white/10 bg-slate-950 p-8">
                            <h2 class="text-2xl font-bold mb-6">"What it is not"</h2>
                            <ul class="space-y-4 text-slate-300">
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
            <section class="py-20">
                <div class="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
                    <h2 class="text-3xl md:text-4xl font-bold mb-6">"Try it with your own question"</h2>
                    <p class="text-lg text-slate-300 mb-8">
                        "The station is published on Eustress. Its word list, its generator and a
                        reference solver are open for anyone to read."
                    </p>
                    <a href=STATION_URL target="_blank" rel="noopener"
                        class="inline-flex items-center justify-center bg-amber-400 hover:bg-amber-300 text-slate-950 text-lg font-bold px-8 py-4 rounded-lg transition-colors">
                        "Open the Super Station"
                    </a>
                </div>
            </section>
        </div>
    }
}

#[component]
fn Step(number: &'static str, title: &'static str, text: &'static str) -> impl IntoView {
    view! {
        <div class="rounded-2xl border border-white/10 bg-slate-900 p-8">
            <div class="w-12 h-12 rounded-full bg-amber-400 text-slate-950 flex items-center justify-center text-xl font-bold mb-6">{number}</div>
            <h3 class="text-xl font-bold mb-3">{title}</h3>
            <p class="text-slate-300">{text}</p>
        </div>
    }
}

#[component]
fn Ray(path: &'static str, note: &'static str) -> impl IntoView {
    view! {
        <li class="flex items-start gap-3">
            <span class="mt-2 w-2.5 h-2.5 rounded-full bg-amber-400 shrink-0"></span>
            <div>
                <div class="font-mono text-lg text-white">{path}</div>
                <div class="text-sm text-slate-400">{note}</div>
            </div>
        </li>
    }
}

#[component]
fn Item(text: &'static str) -> impl IntoView {
    view! {
        <li class="flex items-start gap-3">
            <span class="text-amber-400 font-bold mt-0.5">"•"</span>
            <span>{text}</span>
        </li>
    }
}
