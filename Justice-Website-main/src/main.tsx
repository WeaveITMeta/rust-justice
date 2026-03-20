import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';
import { GoogleOAuthProvider } from '@react-oauth/google';
import App from './App.tsx';
import './index.css';

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <GoogleOAuthProvider clientId="738023439284-ai4a96d7ntpcjtdciman721ehjt9b43p.apps.googleusercontent.com">
      <App />
    </GoogleOAuthProvider>
  </StrictMode>
);