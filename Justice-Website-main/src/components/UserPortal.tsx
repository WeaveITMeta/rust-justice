import React, { useState } from 'react';
import { supabase } from '../lib/auth';
import { Search, Users, Home, Shield, AlertCircle, Info, Loader2 } from 'lucide-react';

interface Resident {
  id: string;
  full_name: string;
  address: string;
  city: string;
  state: string;
  zip_code: string;
}

export default function UserPortal() {
  const [searchQuery, setSearchQuery] = useState('');
  const [searchType, setSearchType] = useState<'name' | 'address'>('name');
  const [residents, setResidents] = useState<Resident[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [showPrivacyInfo, setShowPrivacyInfo] = useState(false);

  // Privacy laws and regulations relevant to residential information
  const privacyLaws = [
    {
      title: "Fourth Amendment",
      description: "Protects against unreasonable searches and seizures, establishing a right to privacy in one's home and personal information.",
      citation: "U.S. Constitution, Amendment IV"
    },
    {
      title: "Fair Housing Act",
      description: "Prohibits discrimination and protects privacy in housing-related matters.",
      citation: "42 U.S.C. §§ 3601-3619"
    },
    {
      title: "Privacy Act",
      description: "Regulates the collection, maintenance, use, and dissemination of personal information by federal agencies.",
      citation: "5 U.S.C. § 552a"
    },
    {
      title: "GDPR Compliance",
      description: "Though U.S.-based, we follow GDPR principles for data protection and privacy.",
      citation: "EU 2016/679"
    }
  ];

  const handleSearch = async () => {
    if (!searchQuery.trim()) return;

    setLoading(true);
    setError(null);
    
    try {
      let query = supabase
        .from('profiles')
        .select('id, full_name, address, city, state, zip_code')
        .neq('address', null);

      if (searchType === 'name') {
        query = query.ilike('full_name', `%${searchQuery}%`);
      } else {
        query = query.or(`address.ilike.%${searchQuery}%,city.ilike.%${searchQuery}%`);
      }

      const { data, error: searchError } = await query;

      if (searchError) throw searchError;
      setResidents(data || []);
    } catch (err) {
      console.error('Search error:', err);
      setError('Failed to perform search. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="bg-white rounded-lg shadow-lg p-6">
      <div className="flex justify-between items-start mb-6">
        <div>
          <h2 className="text-2xl font-bold mb-2">User Portal</h2>
          <p className="text-gray-600">Search and manage resident information</p>
        </div>
        <button
          onClick={() => setShowPrivacyInfo(!showPrivacyInfo)}
          className="flex items-center text-blue-600 hover:text-blue-700"
        >
          <Shield className="h-5 w-5 mr-1" />
          Privacy Guidelines
        </button>
      </div>

      {showPrivacyInfo && (
        <div className="mb-6 bg-blue-50 rounded-lg p-4">
          <div className="flex items-center mb-4">
            <Info className="h-5 w-5 text-blue-600 mr-2" />
            <h3 className="font-semibold">Privacy Laws and Protections</h3>
          </div>
          <div className="space-y-4">
            {privacyLaws.map((law, index) => (
              <div key={index}>
                <h4 className="font-medium">{law.title}</h4>
                <p className="text-sm text-gray-600 mb-1">{law.description}</p>
                <p className="text-xs text-blue-600">Citation: {law.citation}</p>
              </div>
            ))}
          </div>
        </div>
      )}

      {error && (
        <div className="mb-6 p-4 bg-red-50 text-red-700 rounded-lg flex items-center">
          <AlertCircle className="h-5 w-5 mr-2" />
          {error}
        </div>
      )}

      <div className="mb-6">
        <div className="flex gap-4 mb-4">
          <button
            onClick={() => setSearchType('name')}
            className={`flex items-center px-4 py-2 rounded-lg ${
              searchType === 'name'
                ? 'bg-blue-600 text-white'
                : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
            }`}
          >
            <Users className="h-5 w-5 mr-2" />
            Search by Name
          </button>
          <button
            onClick={() => setSearchType('address')}
            className={`flex items-center px-4 py-2 rounded-lg ${
              searchType === 'address'
                ? 'bg-blue-600 text-white'
                : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
            }`}
          >
            <Home className="h-5 w-5 mr-2" />
            Search by Address
          </button>
        </div>

        <div className="flex gap-4">
          <div className="flex-1 relative">
            <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400 h-5 w-5" />
            <input
              type="text"
              placeholder={`Search by ${searchType}...`}
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="w-full pl-10 pr-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
            />
          </div>
          <button
            onClick={handleSearch}
            disabled={loading || !searchQuery.trim()}
            className="px-6 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed flex items-center"
          >
            {loading ? (
              <>
                <Loader2 className="h-5 w-5 mr-2 animate-spin" />
                Searching...
              </>
            ) : (
              'Search'
            )}
          </button>
        </div>
      </div>

      {/* Search Results */}
      <div className="space-y-4">
        {residents.map((resident) => (
          <div
            key={resident.id}
            className="border rounded-lg p-4 hover:shadow-md transition-shadow"
          >
            <div className="flex justify-between">
              <div>
                <h3 className="font-bold text-lg mb-2">{resident.full_name}</h3>
                <div className="space-y-1 text-gray-600">
                  <p>{resident.address}</p>
                  <p>
                    {resident.city}, {resident.state} {resident.zip_code}
                  </p>
                </div>
              </div>
              <div className="flex space-x-2">
                <button className="text-blue-600 hover:text-blue-700">
                  View Details
                </button>
              </div>
            </div>
          </div>
        ))}

        {residents.length === 0 && !loading && searchQuery && (
          <div className="text-center py-8">
            <Users className="h-12 w-12 text-gray-400 mx-auto mb-4" />
            <p className="text-lg font-medium">No residents found</p>
            <p className="text-gray-600">Try adjusting your search terms</p>
          </div>
        )}
      </div>
    </div>
  );
}