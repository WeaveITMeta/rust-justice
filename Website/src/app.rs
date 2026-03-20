use leptos::prelude::*;
use leptos_router::{
    components::{Route, Router, Routes},
    path,
};

use crate::components::{Footer, Navigation};
use crate::pages::{About, Home, Platform, Simulation, Technology};

#[component]
pub fn App() -> impl IntoView {
    view! {
        <Router>
            <div class="min-h-screen flex flex-col">
                <Navigation />
                <main class="flex-1">
                    <Routes fallback=|| view! { <NotFound /> }>
                        <Route path=path!("/") view=Home />
                        <Route path=path!("/about") view=About />
                        <Route path=path!("/platform") view=Platform />
                        <Route path=path!("/simulation") view=Simulation />
                        <Route path=path!("/technology") view=Technology />
                    </Routes>
                </main>
                <Footer />
            </div>
        </Router>
    }
}

#[component]
fn NotFound() -> impl IntoView {
    view! {
        <div class="min-h-[60vh] flex items-center justify-center">
            <div class="text-center">
                <h1 class="text-6xl font-bold text-slate-900 mb-4">"404"</h1>
                <p class="text-xl text-slate-600 mb-8">"Page not found"</p>
                <a href="/" class="btn-primary">"Return Home"</a>
            </div>
        </div>
    }
}
