import React, { createContext, useContext, useState } from 'react';
import { supabase } from '../lib/auth';

interface State {
  id: string;
  name: string;
  code: string;
}

interface County {
  id: string;
  name: string;
  state_id: string;
}

interface LocationContextType {
  selectedState: State | null;
  selectedCounty: County | null;
  setSelectedState: (state: State | null) => void;
  setSelectedCounty: (county: County | null) => void;
  clearSelection: () => void;
}

const LocationContext = createContext<LocationContextType | undefined>(undefined);

export function LocationProvider({ children }: { children: React.ReactNode }) {
  const [selectedState, setSelectedState] = useState<State | null>(null);
  const [selectedCounty, setSelectedCounty] = useState<County | null>(null);

  const clearSelection = () => {
    setSelectedState(null);
    setSelectedCounty(null);
  };

  return (
    <LocationContext.Provider 
      value={{ 
        selectedState, 
        selectedCounty, 
        setSelectedState, 
        setSelectedCounty,
        clearSelection 
      }}
    >
      {children}
    </LocationContext.Provider>
  );
}

export function useLocation() {
  const context = useContext(LocationContext);
  if (context === undefined) {
    throw new Error('useLocation must be used within a LocationProvider');
  }
  return context;
}