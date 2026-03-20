import React, { createContext, useContext, useState, useEffect } from 'react';
import { supabase } from '../lib/auth';

interface Court {
  id: string;
  name: string;
  address: string;
  city: string;
  county_id: string;
  state_id: string;
}

interface CourtContextType {
  selectedCourt: Court | null;
  setSelectedCourt: (court: Court | null) => void;
  clearSelectedCourt: () => void;
}

const CourtContext = createContext<CourtContextType | undefined>(undefined);

export function CourtProvider({ children }: { children: React.ReactNode }) {
  const [selectedCourt, setSelectedCourt] = useState<Court | null>(() => {
    const saved = localStorage.getItem('selectedCourt');
    return saved ? JSON.parse(saved) : null;
  });

  useEffect(() => {
    if (selectedCourt) {
      localStorage.setItem('selectedCourt', JSON.stringify(selectedCourt));
    } else {
      localStorage.removeItem('selectedCourt');
    }
  }, [selectedCourt]);

  const clearSelectedCourt = () => {
    setSelectedCourt(null);
  };

  return (
    <CourtContext.Provider value={{ selectedCourt, setSelectedCourt, clearSelectedCourt }}>
      {children}
    </CourtContext.Provider>
  );
}

export function useCourt() {
  const context = useContext(CourtContext);
  if (context === undefined) {
    throw new Error('useCourt must be used within a CourtProvider');
  }
  return context;
}