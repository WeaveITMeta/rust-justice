import React, { useState, useEffect } from 'react';
import { supabase } from '../lib/auth';
import { useLocation } from '../context/LocationContext';
import { useCourt } from '../context/CourtContext';
import { Building2, MapPin, Phone, Globe, Clock, Loader2, AlertCircle, Filter } from 'lucide-react';

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
  court_type: string[];
  jurisdiction: string;
  presiding_judge: string;
  filing_office_hours: string;
  security_info: string;
  parking_info: string;
  electronic_filing: boolean;
  virtual_hearings: boolean;
}

type CourtType = 'criminal' | 'civil' | 'family' | 'traffic' | 'probate' | 'juvenile' | 'appeals' | 'tax' | 'bankruptcy';

export default function CourtList() {
  const [courts, setCourts] = useState<CourtLocation[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const { selectedState, selectedCounty } = useLocation();
  const { selectedCourt, setSelectedCourt } = useCourt();
  const [selectedTypes, setSelectedTypes] = useState<CourtType[]>([]);

  const courtTypes: CourtType[] = [
    'criminal',
    'civil',
    'family',
    'traffic',
    'probate',
    'juvenile',
    'appeals',
    'tax',
    'bankruptcy'
  ];

  useEffect(() => {
    if (selectedCounty) {
      fetchCourts();
    } else {
      setCourts([]);
    }
  }, [selectedCounty]);

  async function fetchCourts() {
    setLoading(true);
    try {
      const { data, error } = await supabase
        .from('court_locations')
        .select('*')
        .eq('county_id', selectedCounty?.id)
        .order('name');

      if (error) throw error;
      setCourts(data || []);
    } catch (err) {
      console.error('Error fetching courts:', err);
      setError('Failed to load court locations');
    } finally {
      setLoading(false);
    }
  }

  const toggleCourtType = (type: CourtType) => {
    setSelectedTypes(prev =>
      prev.includes(type)
        ? prev.filter(t => t !== type)
        : [...prev, type]
    );
  };

  const filteredCourts = courts.filter(court =>
    selectedTypes.length === 0 ||
    court.court_type.some(type => selectedTypes.includes(type as CourtType))
  );

  if (!selectedState || !selectedCounty) {
    return (
      <div className="text-center py-8">
        <Building2 className="h-12 w-12 text-gray-400 mx-auto mb-4" />
        <h3 className="text-lg font-medium text-gray-900">Select a Location</h3>
        <p className="mt-2 text-gray-500">
          Choose a state and county to view available courts
        </p>
      </div>
    );
  }

  if (loading) {
    return (
      <div className="flex items-center justify-center p-8">
        <Loader2 className="h-8 w-8 animate-spin text-blue-600" />
      </div>
    );
  }

  if (error) {
    return (
      <div className="p-4 bg-red-50 text-red-700 rounded-lg flex items-center">
        <AlertCircle className="h-5 w-5 mr-2" />
        {error}
      </div>
    );
  }

  return (
    <div className="space-y-6">
      {/* Court Type Filters */}
      <div className="bg-gray-50 p-4 rounded-lg">
        <div className="flex items-center mb-3">
          <Filter className="h-5 w-5 text-gray-500 mr-2" />
          <h3 className="font-medium">Filter by Court Type</h3>
        </div>
        <div className="flex flex-wrap gap-2">
          {courtTypes.map(type => (
            <button
              key={type}
              onClick={() => toggleCourtType(type)}
              className={`px-3 py-1 rounded-full text-sm font-medium transition-colors ${
                selectedTypes.includes(type)
                  ? 'bg-blue-600 text-white'
                  : 'bg-gray-200 text-gray-700 hover:bg-gray-300'
              }`}
            >
              {type.charAt(0).toUpperCase() + type.slice(1)}
            </button>
          ))}
        </div>
      </div>

      {/* Court List */}
      {filteredCourts.length === 0 ? (
        <div className="text-center py-8">
          <Building2 className="h-12 w-12 text-gray-400 mx-auto mb-4" />
          <h3 className="text-lg font-medium text-gray-900">No Courts Found</h3>
          <p className="mt-2 text-gray-500">
            {courts.length === 0
              ? `No court locations found in ${selectedCounty.name} County`
              : 'No courts match the selected filters'}
          </p>
        </div>
      ) : (
        <div className="space-y-4">
          {filteredCourts.map((court) => (
            <div
              key={court.id}
              className="border rounded-lg p-6 hover:shadow-md transition-shadow"
            >
              <div className="flex justify-between items-start">
                <div className="space-y-4">
                  <div>
                    <h3 className="text-xl font-bold mb-2">{court.name}</h3>
                    <div className="flex flex-wrap gap-2 mb-3">
                      {court.court_type.map(type => (
                        <span
                          key={type}
                          className="px-2 py-1 bg-blue-100 text-blue-800 text-sm rounded-full"
                        >
                          {type.charAt(0).toUpperCase() + type.slice(1)}
                        </span>
                      ))}
                    </div>
                    <div className="space-y-2 text-gray-600">
                      <p className="flex items-center">
                        <MapPin className="h-5 w-5 text-gray-400 mr-2" />
                        {court.address}, {court.city}, {court.zip_code}
                      </p>
                      {court.phone && (
                        <p className="flex items-center">
                          <Phone className="h-5 w-5 text-gray-400 mr-2" />
                          {court.phone}
                        </p>
                      )}
                      {court.hours && (
                        <p className="flex items-center">
                          <Clock className="h-5 w-5 text-gray-400 mr-2" />
                          {court.hours}
                        </p>
                      )}
                    </div>
                  </div>

                  <div className="flex space-x-4">
                    {court.website && (
                      <a
                        href={court.website}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="inline-flex items-center text-blue-600 hover:text-blue-700"
                      >
                        <Globe className="h-5 w-5 mr-1" />
                        Website
                      </a>
                    )}
                    {court.latitude && court.longitude && (
                      <a
                        href={`https://www.google.com/maps?q=${court.latitude},${court.longitude}`}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="inline-flex items-center text-blue-600 hover:text-blue-700"
                      >
                        <MapPin className="h-5 w-5 mr-1" />
                        Directions
                      </a>
                    )}
                  </div>
                </div>

                <button
                  onClick={() => setSelectedCourt(court)}
                  className={`px-4 py-2 rounded-lg transition-colors ${
                    selectedCourt?.id === court.id
                      ? 'bg-green-100 text-green-800'
                      : 'bg-blue-600 text-white hover:bg-blue-700'
                  }`}
                >
                  {selectedCourt?.id === court.id ? 'Selected' : 'Select Court'}
                </button>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}