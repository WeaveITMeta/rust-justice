import React, { useState, useEffect } from 'react';
import { supabase } from '../lib/auth';
import { useLocation } from '../context/LocationContext';
import { useCourt } from '../context/CourtContext';
import { Loader2, AlertCircle } from 'lucide-react';

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

export default function LocationSelector() {
  const [states, setStates] = useState<State[]>([]);
  const [counties, setCounties] = useState<County[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [initialLoadComplete, setInitialLoadComplete] = useState(false);
  
  const { 
    selectedState, 
    selectedCounty, 
    setSelectedState, 
    setSelectedCounty 
  } = useLocation();

  const { selectedCourt } = useCourt();

  useEffect(() => {
    fetchStates();
  }, []);

  // Handle initial population when a court is selected
  useEffect(() => {
    if (selectedCourt?.state_id && !selectedState && states.length > 0) {
      const state = states.find(s => s.id === selectedCourt.state_id);
      if (state) {
        setSelectedState(state);
      }
    }
  }, [selectedCourt, selectedState, states]);

  // Handle county selection for selected court
  useEffect(() => {
    if (selectedCourt?.county_id && selectedState && counties.length > 0 && !selectedCounty) {
      const county = counties.find(c => c.id === selectedCourt.county_id);
      if (county) {
        setSelectedCounty(county);
      }
    }
  }, [selectedCourt, selectedState, counties, selectedCounty]);

  useEffect(() => {
    if (selectedState) {
      fetchCounties(selectedState.id);
    } else {
      setCounties([]);
      setSelectedCounty(null);
    }
  }, [selectedState]);

  async function fetchStates() {
    try {
      const { data, error } = await supabase
        .from('states')
        .select('*')
        .order('name');

      if (error) throw error;
      setStates(data || []);

      // If we have a selected court, try to select its state
      if (selectedCourt?.state_id) {
        const state = data?.find(s => s.id === selectedCourt.state_id);
        if (state && !selectedState) {
          setSelectedState(state);
        }
      }
    } catch (err) {
      console.error('Error fetching states:', err);
      setError('Failed to load states');
    } finally {
      setLoading(false);
      setInitialLoadComplete(true);
    }
  }

  async function fetchCounties(stateId: string) {
    setLoading(true);
    try {
      const { data, error } = await supabase
        .from('counties')
        .select('*')
        .eq('state_id', stateId)
        .order('name');

      if (error) throw error;
      setCounties(data || []);

      // If we have a selected court, try to select its county
      if (selectedCourt?.county_id) {
        const county = data?.find(c => c.id === selectedCourt.county_id);
        if (county && !selectedCounty) {
          setSelectedCounty(county);
        }
      }
    } catch (err) {
      console.error('Error fetching counties:', err);
      setError('Failed to load counties');
    } finally {
      setLoading(false);
    }
  }

  if (loading && !initialLoadComplete) {
    return (
      <div className="flex items-center justify-center p-4">
        <Loader2 className="h-6 w-6 animate-spin text-blue-600" />
      </div>
    );
  }

  return (
    <div className="space-y-4">
      <div>
        <label className="block text-sm font-medium text-gray-700 mb-1">
          Select State
        </label>
        <select
          value={selectedState?.id || ''}
          onChange={(e) => {
            const state = states.find(s => s.id === e.target.value);
            setSelectedState(state || null);
          }}
          className="w-full border rounded-lg p-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
        >
          <option value="">Choose a state...</option>
          {states.map(state => (
            <option key={state.id} value={state.id}>
              {state.name}
            </option>
          ))}
        </select>
      </div>

      {selectedState && (
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            Select County
          </label>
          <select
            value={selectedCounty?.id || ''}
            onChange={(e) => {
              const county = counties.find(c => c.id === e.target.value);
              setSelectedCounty(county || null);
            }}
            className="w-full border rounded-lg p-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
          >
            <option value="">Choose a county...</option>
            {counties.map(county => (
              <option key={county.id} value={county.id}>
                {county.name}
              </option>
            ))}
          </select>
        </div>
      )}

      {error && (
        <div className="text-red-600 text-sm">
          {error}
        </div>
      )}
    </div>
  );
}