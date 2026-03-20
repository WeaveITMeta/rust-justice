import React, { useState, useCallback } from 'react';
import { Scale, AlertTriangle, CheckCircle, Search, BookOpen, Shield, RefreshCw, Filter } from 'lucide-react';
import { supabase } from '../lib/auth';

interface AnalysisResult {
  id: string;
  type: 'contradiction' | 'redundancy' | 'constitutional';
  title: string;
  description: string;
  citations: string[];
  severity: 'high' | 'medium' | 'low';
  recommendation?: string;
  constitutional_basis?: string[];
  precedents?: string[];
  created_at: string;
}

export default function RegulationAnalysis() {
  const [searchQuery, setSearchQuery] = useState('');
  const [results, setResults] = useState<AnalysisResult[]>([]);
  const [analyzing, setAnalyzing] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [selectedType, setSelectedType] = useState<string>('all');

  const analysisTypes = [
    { id: 'all', label: 'All Types' },
    { id: 'constitutional', label: 'Constitutional Analysis' },
    { id: 'contradiction', label: 'Contradiction Analysis' },
    { id: 'redundancy', label: 'Redundancy Analysis' }
  ];

  const analyzeRegulation = useCallback(async () => {
    if (!searchQuery.trim()) return;
    
    setAnalyzing(true);
    setError(null);
    
    try {
      const { data, error: searchError } = await supabase
        .from('regulation_analysis')
        .select('*')
        .textSearch('title', searchQuery)
        .order('created_at', { ascending: false });

      if (searchError) throw searchError;
      
      if (!data || data.length === 0) {
        // Create new analysis if none exists
        const { data: newAnalysis, error: createError } = await supabase
          .from('regulation_analysis')
          .insert([
            {
              type: 'constitutional',
              title: 'First Amendment Analysis',
              description: 'Analyzing regulation for First Amendment compliance',
              citations: ['U.S. Const. amend. I'],
              severity: 'high',
              constitutional_basis: ['First Amendment'],
              precedents: ['Central Hudson Gas & Electric Corp. v. Public Service Commission']
            }
          ])
          .select();

        if (createError) throw createError;
        setResults(newAnalysis || []);
      } else {
        setResults(data);
      }
    } catch (err) {
      console.error('Analysis error:', err);
      setError('Failed to analyze regulation. Please try again.');
    } finally {
      setAnalyzing(false);
    }
  }, [searchQuery]);

  const filteredResults = results.filter(result => 
    selectedType === 'all' || result.type === selectedType
  );

  return (
    <div className="bg-white rounded-lg shadow-lg p-6">
      <div className="flex justify-between items-start mb-6">
        <div>
          <h2 className="text-2xl font-bold mb-2">Regulation Analysis</h2>
          <p className="text-gray-600">Analyze regulations for constitutional compliance and conflicts</p>
        </div>
        <div className="flex items-center space-x-2 bg-blue-50 text-blue-700 px-4 py-2 rounded-lg">
          <Scale className="h-5 w-5" />
          <span className="font-medium">Legal Analysis Tools</span>
        </div>
      </div>

      {error && (
        <div className="mb-6 p-4 bg-red-50 text-red-700 rounded-lg flex items-center">
          <AlertTriangle className="h-5 w-5 mr-2" />
          {error}
        </div>
      )}

      <div className="mb-6 space-y-4">
        <div className="flex gap-4">
          <div className="flex-1 relative">
            <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400 h-5 w-5" />
            <input
              type="text"
              placeholder="Enter regulation text or citation..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="w-full pl-10 pr-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
            />
          </div>
          <button
            onClick={analyzeRegulation}
            disabled={analyzing || !searchQuery.trim()}
            className="bg-blue-600 text-white px-6 py-2 rounded-lg hover:bg-blue-700 transition-colors disabled:opacity-50 flex items-center"
          >
            {analyzing ? (
              <>
                <RefreshCw className="h-5 w-5 mr-2 animate-spin" />
                Analyzing...
              </>
            ) : (
              <>
                <Scale className="h-5 w-5 mr-2" />
                Analyze
              </>
            )}
          </button>
        </div>

        <div className="flex items-center space-x-2">
          <Filter className="h-5 w-5 text-gray-400" />
          <span className="text-gray-700 font-medium">Filter by Type:</span>
          <div className="flex gap-2">
            {analysisTypes.map(type => (
              <button
                key={type.id}
                onClick={() => setSelectedType(type.id)}
                className={`px-3 py-1 rounded-full text-sm font-medium transition-colors ${
                  selectedType === type.id
                    ? 'bg-blue-600 text-white'
                    : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
                }`}
              >
                {type.label}
              </button>
            ))}
          </div>
        </div>
      </div>

      <div className="space-y-4">
        {filteredResults.length === 0 ? (
          <div className="text-center py-12">
            <Scale className="h-12 w-12 text-gray-400 mx-auto mb-4" />
            <p className="text-lg font-medium">No Analysis Results</p>
            <p className="text-gray-600">Enter regulation text to begin analysis</p>
          </div>
        ) : (
          filteredResults.map((result) => (
            <div
              key={result.id}
              className="border rounded-lg p-6 hover:shadow-md transition-shadow"
            >
              <div className="flex justify-between items-start mb-4">
                <div>
                  <h3 className="text-xl font-bold mb-2">{result.title}</h3>
                  <div className="flex items-center space-x-2 mb-4">
                    <span className={`px-3 py-1 rounded-full text-sm font-medium ${
                      result.severity === 'high'
                        ? 'bg-red-100 text-red-800'
                        : result.severity === 'medium'
                        ? 'bg-yellow-100 text-yellow-800'
                        : 'bg-green-100 text-green-800'
                    }`}>
                      {result.severity.charAt(0).toUpperCase() + result.severity.slice(1)} Severity
                    </span>
                    <span className="text-gray-500">•</span>
                    <span className="text-gray-600">{new Date(result.created_at).toLocaleDateString()}</span>
                  </div>
                </div>
                {result.type === 'constitutional' && (
                  <Shield className="h-6 w-6 text-blue-600" />
                )}
              </div>

              <p className="text-gray-600 mb-4">{result.description}</p>

              {result.citations && result.citations.length > 0 && (
                <div className="mb-4">
                  <h4 className="font-semibold mb-2">Citations</h4>
                  <div className="flex flex-wrap gap-2">
                    {result.citations.map((citation, index) => (
                      <span
                        key={index}
                        className="px-2 py-1 bg-gray-100 text-gray-700 rounded text-sm"
                      >
                        {citation}
                      </span>
                    ))}
                  </div>
                </div>
              )}

              {result.constitutional_basis && (
                <div className="mb-4">
                  <h4 className="font-semibold mb-2">Constitutional Basis</h4>
                  <div className="flex flex-wrap gap-2">
                    {result.constitutional_basis.map((basis, index) => (
                      <span
                        key={index}
                        className="px-2 py-1 bg-blue-100 text-blue-800 rounded text-sm"
                      >
                        {basis}
                      </span>
                    ))}
                  </div>
                </div>
              )}

              {result.precedents && (
                <div className="mb-4">
                  <h4 className="font-semibold mb-2">Relevant Precedents</h4>
                  <div className="flex flex-wrap gap-2">
                    {result.precedents.map((precedent, index) => (
                      <span
                        key={index}
                        className="px-2 py-1 bg-gray-100 text-gray-700 rounded text-sm"
                      >
                        {precedent}
                      </span>
                    ))}
                  </div>
                </div>
              )}

              {result.recommendation && (
                <div className="mt-4 p-4 bg-green-50 rounded-lg">
                  <div className="flex items-center mb-2">
                    <CheckCircle className="h-5 w-5 text-green-600 mr-2" />
                    <h4 className="font-semibold">Recommendation</h4>
                  </div>
                  <p className="text-gray-700">{result.recommendation}</p>
                </div>
              )}
            </div>
          ))
        )}
      </div>
    </div>
  );
}