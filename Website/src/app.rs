use leptos::prelude::*;
use leptos_router::{
    components::{Route, Router, Routes},
    path,
};

use crate::components::{Footer, Navigation};
use crate::pages::{Home, Courts, SelfService, Regulation, Help};

#[component]
pub fn App() -> impl IntoView {
    view! {
        <Router>
            <div class="min-h-screen flex flex-col">
                <Navigation />
                <main class="flex-grow">
                    <Routes fallback=|| view! { <NotFound /> }>
                        <Route path=path!("/") view=Home />
                        <Route path=path!("/courts") view=Courts />
                        <Route path=path!("/self-service") view=SelfService />
                        <Route path=path!("/regulation") view=Regulation />
                        <Route path=path!("/help") view=Help />
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
                <a href="/" class="inline-flex items-center px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors">
                    "Return Home"
                </a>
            </div>
        </div>
    }
}
