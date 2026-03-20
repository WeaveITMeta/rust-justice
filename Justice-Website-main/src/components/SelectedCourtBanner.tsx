import React from 'react';
import { MapPin, X, ChevronRight } from 'lucide-react';
import { useCourt } from '../context/CourtContext';
import { Link, useNavigate } from 'react-router-dom';
import { supabase } from '../lib/auth';

export default function SelectedCourtBanner() {
  const { selectedCourt, clearSelectedCourt } = useCourt();
  const navigate = useNavigate();

  const handleCourtClick = async () => {
    if (!selectedCourt) {
      navigate('/courts');
      return;
    }

    try {
      const { data, error } = await supabase
        .from('court_locations')
        .select('website')
        .eq('id', selectedCourt.id)
        .single();

      if (error) throw error;
      if (data?.website) {
        window.open(data.website, '_blank');
      }
    } catch (err) {
      console.error('Error getting court website:', err);
    }
  };

  if (!selectedCourt) {
    return (
      <div className="bg-blue-50 border-b border-blue-100">
        <div className="container mx-auto px-4 py-3">
          <button
            onClick={() => navigate('/courts')}
            className="w-full flex items-center justify-between text-blue-700 hover:text-blue-800 transition-colors"
          >
            <div className="flex items-center space-x-2">
              <MapPin className="h-6 w-6" />
              <span className="font-medium">Select your court location</span>
            </div>
            <ChevronRight className="h-5 w-5" />
          </button>
        </div>
      </div>
    );
  }

  return (
    <div className="bg-blue-50 border-b border-blue-100">
      <div className="container mx-auto px-4 py-3">
        <div className="flex items-center justify-between">
          <button 
            onClick={handleCourtClick}
            className="group flex items-center space-x-3 hover:text-blue-600 transition-colors text-left"
          >
            <div className="flex items-center justify-center h-10 w-10">
              <MapPin className="h-7 w-7 text-blue-700 group-hover:text-blue-600" />
            </div>
            <div>
              <h3 className="font-medium text-blue-900 group-hover:text-blue-600">{selectedCourt.name}</h3>
              <p className="text-sm text-blue-700 group-hover:text-blue-600">
                {selectedCourt.address}, {selectedCourt.city}
              </p>
            </div>
          </button>
          <div className="flex items-center space-x-4">
            <Link
              to="/courts"
              className="text-blue-700 hover:text-blue-800 text-sm font-medium"
            >
              Change
            </Link>
            <button
              onClick={clearSelectedCourt}
              className="text-blue-700 hover:text-blue-800 p-1"
              title="Clear selected court"
            >
              <X className="h-5 w-5" />
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}