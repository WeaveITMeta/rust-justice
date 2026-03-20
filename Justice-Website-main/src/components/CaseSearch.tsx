import React, { useState } from 'react';
import { Search, Filter, Calendar, FileText, AlertCircle, Building2, ArrowRight } from 'lucide-react';
import { useCourt } from '../context/CourtContext';
import { useNavigate } from 'react-router-dom';

interface SearchFilters {
  caseType: string;
  dateRange: string;
  status: string;
}

export default function CaseSearch() {
  const { selectedCourt } = useCourt();
  const navigate = useNavigate();
  const [searchQuery, setSearchQuery] = useState('');
  const [filters, setFilters] = useState<SearchFilters>({
    caseType: '',
    dateRange: '',
    status: ''
  });
  const [isSearching, setIsSearching] = useState(false);
  const [searchResults, setSearchResults] = useState<any[]>([]);
  const [error, setError] = useState<string | null>(null);

  const caseTypes = [
    'Civil',
    'Criminal',
    'Family',
    'Probate',
    'Small Claims',
    'Traffic'
  ];

  const dateRanges = [
    'Last 30 days',
    'Last 3 months',
    'Last 6 months',
    'Last year',
    'All time'
  ];

  const statuses = [
    'Active',
    'Closed',
    'Pending',
    'Under Review',
    'Scheduled'
  ];

  const handleSearch = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!selectedCourt) return;

    setIsSearching(true);
    setError(null);
    setSearchResults([]);

    try {
      // Simulate API call with court-specific search
      await new Promise(resolve => setTimeout(resolve, 1500));

      // In a real implementation, you would:
      // 1. Make an API call to search cases for the selected court
      // 2. Include the court_location_id in the search parameters
      // 3. Filter results based on the selected filters
      
      setSearchResults([
        {
          caseNumber: '2024-12345',
          title: 'State v. Smith',
          type: 'Criminal',
          status: 'Active',
          filingDate: '2024-02-15',
          nextHearing: '2024-04-01'
        },
        // Add more mock results as needed
      ]);
    } catch (err) {
      console.error('Search error:', err);
      setError('Failed to search cases. Please try again.');
    } finally {
      setIsSearching(false);
    }
  };

  if (!selectedCourt) {
    return (
      <div className="bg-white rounded-lg shadow-lg p-8 text-center">
        <Building2 className="h-12 w-12 text-gray-400 mx-auto mb-4" />
        <h3 className="text-lg font-medium text-gray-900 mb-2">Select a Court</h3>
        <p className="text-gray-600 mb-6">Please select a court to search for cases</p>
        <button
          onClick={() => navigate('/courts')}
          className="inline-flex items-center px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors"
        >
          Select Court
          <ArrowRight className="ml-2 h-5 w-5" />
        </button>
      </div>
    );
  }

  return (
    <div className="bg-white rounded-lg shadow-lg p-6">
      <div className="mb-6">
        <h2 className="text-2xl font-bold mb-2">Case Search</h2>
        <p className="text-gray-600">Search for cases at {selectedCourt.name}</p>
      </div>

      {error && (
        <div className="mb-6 p-4 bg-red-50 text-red-700 rounded-lg flex items-center">
          <AlertCircle className="h-5 w-5 mr-2" />
          {error}
        </div>
      )}

      <form onSubmit={handleSearch}>
        {/* Main Search Bar */}
        <div className="relative mb-6">
          <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400 h-5 w-5" />
          <input
            type="text"
            placeholder="Enter case number, name, or keyword..."
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            className="w-full pl-10 pr-4 py-3 border rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
          />
        </div>

        {/* Filters */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Case Type</label>
            <select
              value={filters.caseType}
              onChange={(e) => setFilters({ ...filters, caseType: e.target.value })}
              className="w-full border rounded-lg p-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
            >
              <option value="">All Types</option>
              {caseTypes.map(type => (
                <option key={type} value={type}>{type}</option>
              ))}
            </select>
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Date Range</label>
            <select
              value={filters.dateRange}
              onChange={(e) => setFilters({ ...filters, dateRange: e.target.value })}
              className="w-full border rounded-lg p-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
            >
              <option value="">Any Time</option>
              {dateRanges.map(range => (
                <option key={range} value={range}>{range}</option>
              ))}
            </select>
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Status</label>
            <select
              value={filters.status}
              onChange={(e) => setFilters({ ...filters, status: e.target.value })}
              className="w-full border rounded-lg p-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
            >
              <option value="">All Statuses</option>
              {statuses.map(status => (
                <option key={status} value={status}>{status}</option>
              ))}
            </select>
          </div>
        </div>

        {/* Search Button */}
        <button
          type="submit"
          disabled={isSearching}
          className="w-full bg-blue-600 text-white py-3 rounded-lg hover:bg-blue-700 transition-colors duration-200 disabled:opacity-50 flex items-center justify-center"
        >
          {isSearching ? (
            <>
              <div className="animate-spin rounded-full h-5 w-5 border-b-2 border-white mr-2" />
              Searching...
            </>
          ) : (
            <>
              <Search className="h-5 w-5 mr-2" />
              Search Cases
            </>
          )}
        </button>
      </form>

      {/* Search Results */}
      {searchResults.length > 0 && (
        <div className="mt-8 space-y-4">
          <h3 className="text-lg font-semibold mb-4">Search Results</h3>
          {searchResults.map((result, index) => (
            <div
              key={index}
              className="border rounded-lg p-4 hover:shadow-md transition-shadow"
            >
              <div className="flex justify-between items-start">
                <div>
                  <h4 className="font-bold text-lg mb-1">{result.title}</h4>
                  <p className="text-gray-600">Case #{result.caseNumber}</p>
                  <div className="mt-2 space-y-1">
                    <p className="text-sm text-gray-600">
                      <Calendar className="inline-block h-4 w-4 mr-1" />
                      Filed: {result.filingDate}
                    </p>
                    {result.nextHearing && (
                      <p className="text-sm text-gray-600">
                        <Calendar className="inline-block h-4 w-4 mr-1" />
                        Next Hearing: {result.nextHearing}
                      </p>
                    )}
                  </div>
                </div>
                <div className="flex flex-col items-end">
                  <span className="px-3 py-1 rounded-full text-sm font-medium bg-blue-100 text-blue-800 mb-2">
                    {result.type}
                  </span>
                  <span className="px-3 py-1 rounded-full text-sm font-medium bg-green-100 text-green-800">
                    {result.status}
                  </span>
                </div>
              </div>
              <div className="mt-4 flex justify-end">
                <button className="text-blue-600 hover:text-blue-700 flex items-center">
                  <FileText className="h-4 w-4 mr-1" />
                  View Details
                </button>
              </div>
            </div>
          ))}
        </div>
      )}

      {/* Search Tips */}
      <div className="mt-8 bg-blue-50 rounded-lg p-4">
        <h3 className="font-semibold flex items-center mb-2">
          <AlertCircle className="h-5 w-5 text-blue-600 mr-2" />
          Search Tips
        </h3>
        <ul className="text-sm text-gray-600 space-y-2">
          <li>• Use case numbers in the format "YYYY-XXXXX"</li>
          <li>• For name searches, enter last name first</li>
          <li>• Filter results using the options above</li>
          <li>• Use quotation marks for exact phrase matches</li>
        </ul>
      </div>
    </div>
  );
}