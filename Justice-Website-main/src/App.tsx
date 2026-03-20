import React from 'react';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Layout from './components/Layout';
import Home from './pages/Home';
import Login from './pages/Login';
import ForgotPassword from './pages/ForgotPassword';
import ResetPassword from './pages/ResetPassword';
import ChatBot from './components/ChatBot';
import Help from './pages/Help';
import Building from './pages/Building';
import Programs from './pages/Programs';
import AdminPanel from './pages/AdminPanel';
import { CourtProvider } from './context/CourtContext';
import { LocationProvider } from './context/LocationContext';

// Lazy load other pages
const Courts = React.lazy(() => import('./pages/Courts'));
const Administration = React.lazy(() => import('./pages/Administration'));
const SelfService = React.lazy(() => import('./pages/SelfService'));
const Licensing = React.lazy(() => import('./pages/Licensing'));
const Regulation = React.lazy(() => import('./pages/Regulation'));

export default function App() {
  return (
    <LocationProvider>
      <CourtProvider>
        <BrowserRouter>
          <Routes>
            <Route path="/login" element={<Login />} />
            <Route path="/forgot-password" element={<ForgotPassword />} />
            <Route path="/reset-password" element={<ResetPassword />} />
            <Route path="/" element={<Layout />}>
              <Route index element={<Home />} />
              <Route path="help" element={<Help />} />
              <Route path="building" element={<Building />} />
              <Route path="programs" element={<Programs />} />
              <Route path="admin" element={<AdminPanel />} />
              <Route path="courts" element={
                <React.Suspense fallback={<div>Loading...</div>}>
                  <Courts />
                </React.Suspense>
              } />
              <Route path="administration" element={
                <React.Suspense fallback={<div>Loading...</div>}>
                  <Administration />
                </React.Suspense>
              } />
              <Route path="self-service" element={
                <React.Suspense fallback={<div>Loading...</div>}>
                  <SelfService />
                </React.Suspense>
              } />
              <Route path="licensing" element={
                <React.Suspense fallback={<div>Loading...</div>}>
                  <Licensing />
                </React.Suspense>
              } />
              <Route path="regulation" element={
                <React.Suspense fallback={<div>Loading...</div>}>
                  <Regulation />
                </React.Suspense>
              } />
            </Route>
          </Routes>
          <ChatBot />
        </BrowserRouter>
      </CourtProvider>
    </LocationProvider>
  );
}