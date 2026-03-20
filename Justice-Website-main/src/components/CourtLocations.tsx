import React, { useState, useEffect } from 'react';
import { supabase } from '../lib/auth';
import { MapPin, Search, Building2, Loader2, AlertCircle, CheckCircle } from 'lucide-react';
import { useCourt } from '../context/CourtContext';

interface State {
  id: string;
  name: string;
  code: string;
}

interface County {
  id: string;
  name: string;
}

interface CourtLocation {
  id: string;
  name: string;
  address: string;
  city: string;
  zip_code: string;
  phone: string;
  hours: string;
  website: string;
  latitude: number;
  longitude: number;
  county_id: string;
  state_id: string;
}

export default function CourtLocations() {
  const [states, setStates] = useState<State[]>([]);
  const [counties, setCounties] = useState<County[]>([]);
  const [locations, setLocations] = useState<CourtLocation[]>([]);
  const [selectedState, setSelectedState] = useState<string>('');
  const [selectedCounty, setSelectedCounty] = useState<string>('');
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const { selectedCourt, setSelectedCourt } = useCourt();

  useEffect(() => {
    fetchStates();
  }, []);

  useEffect(() => {
    if (selectedState) {
      fetchCounties(selectedState);
      setSelectedCounty('');
      setLocations([]);
    }
  }, [selectedState]);

  useEffect(() => {
    if (selectedCounty) {
      fetchLocations(selectedCounty);
    }
  }, [selectedCounty]);

  async function fetchStates() {
    try {
      const { data, error } = await supabase
        .from('states')
        .select('*')
        .order('name');

      if (error) throw error;
      setStates(data || []);
    } catch (err) {
      console.error('Error fetching states:', err);
      setError('Failed to load states');
    } finally {
      setLoading(false);
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
    } catch (err) {
      console.error('Error fetching counties:', err);
      setError('Failed to load counties');
    } finally {
      setLoading(false);
    }
  }

  async function fetchLocations(countyId: string) {
    setLoading(true);
    try {
      const { data, error } = await supabase
        .from('court_locations')
        .select('*')
        .eq('county_id', countyId)
        .order('name');

      if (error) throw error;
      setLocations(data || []);
    } catch (err) {
      console.error('Error fetching locations:', err);
      setError('Failed to load court locations');
    } finally {
      setLoading(false);
    }
  }

  const handleCourtSelection = (court: CourtLocation) => {
    setSelectedCourt({
      id: court.id,
      name: court.name,
      address: court.address,
      city: court.city,
      county_id: court.county_id,
      state_id: court.state_id,
    });
  };

  return (
    <div className="bg-white rounded-lg shadow-lg p-6">
      <div className="mb-6">
        <h2 className="text-2xl font-bold mb-2">Find Courts</h2>
        <p className="text-gray-600">Locate courts by state and county</p>
      </div>

      {error && (
        <div className="mb-6 p-4 bg-red-50 text-red-700 rounded-lg flex items-center">
          <AlertCircle className="h-5 w-5 mr-2" />
          {error}
        </div>
      )}

      <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-8">
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            Select State
          </label>
          <select
            value={selectedState}
            onChange={(e) => setSelectedState(e.target.value)}
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

        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            Select County
          </label>
          <select
            value={selectedCounty}
            onChange={(e) => setSelectedCounty(e.target.value)}
            disabled={!selectedState}
            className="w-full border rounded-lg p-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 disabled:opacity-50"
          >
            <option value="">Choose a county...</option>
            {counties.map(county => (
              <option key={county.id} value={county.id}>
                {county.name}
              </option>
            ))}
          </select>
        </div>
      </div>

      {loading ? (
        <div className="flex items-center justify-center p-12">
          <Loader2 className="h-8 w-8 animate-spin text-blue-600" />
        </div>
      ) : (
        <div className="space-y-6">
          {locations.length === 0 ? (
            <div className="text-center py-12">
              <Building2 className="h-12 w-12 text-gray-400 mx-auto mb-4" />
              <p className="text-lg font-medium">No courts found</p>
              <p className="text-gray-600">
                {selectedState
                  ? selectedCounty
                    ? 'No courts found in this county'
                    : 'Please select a county'
                  : 'Please select a state and county'}
              </p>
            </div>
          ) : (
            locations.map(location => (
              <div
                key={location.id}
                className="border rounded-lg p-6 hover:shadow-md transition-shadow"
              >
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div className="space-y-2">
                    <h3 className="text-xl font-bold mb-2">{location.name}</h3>
                    <p className="flex items-start">
                      <MapPin className="h-5 w-5 text-blue-600 mr-2 mt-0.5" />
                      <span>
                        {location.address}<br />
                        {location.city}, {location.zip_code}
                      </span>
                    </p>
                    {location.phone && (
                      <p className="text-gray-600">
                        Phone: {location.phone}
                      </p>
                    )}
                    {location.hours && (
                      <p className="text-gray-600">
                        Hours: {location.hours}
                      </p>
                    )}
                  </div>
                  <div className="flex flex-col justify-between">
                    <div className="space-y-2">
                      {location.website && (
                        <a
                          href={location.website}
                          target="_blank"
                          rel="noopener noreferrer"
                          className="text-blue-600 hover:text-blue-700 flex items-center"
                        >
                          Visit Website →
                        </a>
                      )}
                      {location.latitude && location.longitude && (
                        <a
                          href={`https://www.google.com/maps?q=${location.latitude},${location.longitude}`}
                          target="_blank"
                          rel="noopener noreferrer"
                          className="text-blue-600 hover:text-blue-700 flex items-center"
                        >
                          View on Map →
                        </a>
                      )}
                    </div>
                    <button
                      onClick={() => handleCourtSelection(location)}
                      className={`mt-4 px-4 py-2 rounded-lg transition-colors ${
                        selectedCourt?.id === location.id
                          ? 'bg-green-100 text-green-800 flex items-center justify-center'
                          : 'bg-blue-600 text-white hover:bg-blue-700'
                      }`}
                    >
                      {selectedCourt?.id === location.id ? (
                        <>
                          <CheckCircle className="h-5 w-5 mr-2" />
                          Selected Court
                        </>
                      ) : (
                        'Select Court'
                      )}
                    </button>
                  </div>
                </div>
              </div>
            ))
          )}
        </div>
      )}
    </div>
  );
}