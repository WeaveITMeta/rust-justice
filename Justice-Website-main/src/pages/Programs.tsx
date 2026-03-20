import React, { useState, useEffect } from 'react';
import { supabase } from '../lib/auth';
import { Award, CheckCircle, Clock, ArrowRight, Search, Filter, Plus, Loader2, AlertCircle, ChevronDown, Building2, Lock } from 'lucide-react';
import { useCourt } from '../context/CourtContext';
import { useNavigate } from 'react-router-dom';
import ProgramManagement from '../components/ProgramManagement';
import TestManagement from '../components/TestManagement';
import TestTaking from '../components/TestTaking';

interface Program {
  id: string;
  title: string;
  description: string;
  requirements: string[];
  steps: string[];
  completion_criteria: string[];
  badge_id: string | null;
  is_active: boolean;
}

interface UserProgress {
  program_id: string;
  completed_steps: string[];
  started_at: string;
  completed_at: string | null;
}

interface Badge {
  id: string;
  name: string;
  description: string;
  icon_url: string | null;
}

interface UserBadge {
  badge_id: string;
  badge: Badge;
  awarded_at: string;
}

interface TestResult {
  score: number;
  passed: boolean;
  completed_at: string;
}

export default function Programs() {
  const { selectedCourt } = useCourt();
  const navigate = useNavigate();
  const [programs, setPrograms] = useState<Program[]>([]);
  const [userProgress, setUserProgress] = useState<UserProgress[]>([]);
  const [userBadges, setUserBadges] = useState<UserBadge[]>([]);
  const [testResults, setTestResults] = useState<Record<string, TestResult[]>>({});
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [isAdmin, setIsAdmin] = useState(false);
  const [showProgramManagement, setShowProgramManagement] = useState(false);
  const [showTestManagement, setShowTestManagement] = useState(false);
  const [selectedProgram, setSelectedProgram] = useState<string | null>(null);
  const [showTestResults, setShowTestResults] = useState<Record<string, boolean>>({});
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedCategory, setSelectedCategory] = useState<string>('');
  const [isAuthenticated, setIsAuthenticated] = useState(false);

  useEffect(() => {
    checkAuth();
  }, []);

  useEffect(() => {
    if (selectedCourt) {
      fetchData();
      checkAdminStatus();
    }
  }, [selectedCourt]);

  async function checkAuth() {
    const { data: { user } } = await supabase.auth.getUser();
    setIsAuthenticated(!!user);
  }

  async function checkAdminStatus() {
    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) return;

      const { data, error } = await supabase.rpc('is_court_administrator', {
        court_id: selectedCourt.id
      });

      if (error) throw error;
      setIsAdmin(!!data);
    } catch (err) {
      console.error('Error checking admin status:', err);
      setIsAdmin(false);
    }
  }

  async function fetchData() {
    setLoading(true);
    setError(null);

    try {
      const { data: { user } } = await supabase.auth.getUser();

      // Fetch programs
      const { data: programsData, error: programsError } = await supabase
        .from('programs')
        .select('*')
        .eq('is_active', true);

      if (programsError) throw programsError;
      setPrograms(programsData || []);

      if (user) {
        // Fetch user progress
        const { data: progressData, error: progressError } = await supabase
          .from('user_program_progress')
          .select('*')
          .eq('user_id', user.id);

        if (progressError) throw progressError;
        setUserProgress(progressData || []);

        // Fetch user badges
        const { data: badgesData, error: badgesError } = await supabase
          .from('user_badges')
          .select('badge_id, badge:badges(*), awarded_at')
          .eq('user_id', user.id);

        if (badgesError) throw badgesError;
        setUserBadges(badgesData || []);

        // Fetch test results
        const { data: resultsData, error: resultsError } = await supabase
          .from('user_test_results')
          .select('*')
          .eq('user_id', user.id);

        if (resultsError) throw resultsError;
        
        // Group test results by program
        const groupedResults = resultsData?.reduce((acc, result) => {
          if (!acc[result.test_id]) {
            acc[result.test_id] = [];
          }
          acc[result.test_id].push(result);
          return acc;
        }, {} as Record<string, TestResult[]>);

        setTestResults(groupedResults || {});
      }
    } catch (err) {
      console.error('Error fetching data:', err);
      setError('Failed to load programs');
    } finally {
      setLoading(false);
    }
  }

  const handleProgramSelect = (programId: string) => {
    if (!isAuthenticated) {
      // Redirect to login with return URL
      navigate(`/login?returnTo=/programs?program=${programId}`);
      return;
    }
    setSelectedProgram(programId);
  };

  if (!selectedCourt) {
    return (
      <div className="container mx-auto px-4 py-8">
        <div className="bg-white rounded-lg shadow-lg p-8 text-center">
          <Building2 className="h-12 w-12 text-gray-400 mx-auto mb-4" />
          <h3 className="text-lg font-medium text-gray-900 mb-2">Select a Court</h3>
          <p className="text-gray-600 mb-6">Please select a court to view available programs</p>
          <button
            onClick={() => navigate('/courts')}
            className="inline-flex items-center px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors"
          >
            Select Court
            <ArrowRight className="ml-2 h-5 w-5" />
          </button>
        </div>
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

  return (
    <div className="container mx-auto px-4 py-8">
      <div className="flex justify-between items-start mb-8">
        <div>
          <h1 className="text-4xl font-bold mb-2">Programs</h1>
          <p className="text-gray-600">Available programs for {selectedCourt.name}</p>
        </div>
        {isAdmin && (
          <div className="flex space-x-4">
            <button
              onClick={() => setShowProgramManagement(true)}
              className="flex items-center px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors"
            >
              <Plus className="h-5 w-5 mr-2" />
              Create Program
            </button>
            <button
              onClick={() => setShowTestManagement(true)}
              className="flex items-center px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors"
            >
              <Plus className="h-5 w-5 mr-2" />
              Create Test
            </button>
          </div>
        )}
      </div>

      {error && (
        <div className="mb-6 p-4 bg-red-50 text-red-700 rounded-lg flex items-center">
          <AlertCircle className="h-5 w-5 mr-2" />
          {error}
        </div>
      )}

      {showProgramManagement && (
        <ProgramManagement onClose={() => setShowProgramManagement(false)} />
      )}

      {showTestManagement && (
        <TestManagement onClose={() => setShowTestManagement(false)} />
      )}

      {selectedProgram && (
        <TestTaking programId={selectedProgram} />
      )}

      {!selectedProgram && (
        <>
          {programs.length === 0 ? (
            <div className="bg-white rounded-lg shadow-lg p-8 text-center">
              <Award className="h-12 w-12 text-gray-400 mx-auto mb-4" />
              <h3 className="text-lg font-medium text-gray-900 mb-2">No Programs Available</h3>
              <p className="text-gray-600 mb-6">
                {isAdmin 
                  ? "Create a new program to get started"
                  : "There are no public programs available for this court at the moment"}
              </p>
              {isAdmin && (
                <button
                  onClick={() => setShowProgramManagement(true)}
                  className="inline-flex items-center px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors"
                >
                  <Plus className="h-5 w-5 mr-2" />
                  Create Program
                </button>
              )}
            </div>
          ) : (
            <div className="space-y-6">
              {/* Programs Grid */}
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                {programs.map(program => {
                  const progress = userProgress.find(p => p.program_id === program.id);
                  const badge = userBadges.find(b => b.badge_id === program.badge_id)?.badge;
                  
                  return (
                    <div key={program.id} className="bg-white rounded-lg shadow-lg overflow-hidden">
                      <div className="p-6">
                        <div className="flex justify-between items-start mb-4">
                          <h3 className="text-xl font-bold">{program.title}</h3>
                          {badge && (
                            <div className="flex items-center bg-blue-100 text-blue-800 px-3 py-1 rounded-full text-sm">
                              <Award className="h-4 w-4 mr-1" />
                              {badge.name}
                            </div>
                          )}
                        </div>
                        
                        <p className="text-gray-600 mb-4">{program.description}</p>
                        
                        {progress ? (
                          <div className="mb-4">
                            <div className="flex justify-between items-center mb-2">
                              <span className="text-sm font-medium text-gray-700">Progress</span>
                              <span className="text-sm text-gray-600">
                                {progress.completed_steps?.length || 0} of {program.steps.length} steps
                              </span>
                            </div>
                            <div className="w-full bg-gray-200 rounded-full h-2">
                              <div
                                className="bg-blue-600 h-2 rounded-full transition-all duration-300"
                                style={{ 
                                  width: `${((progress.completed_steps?.length || 0) / program.steps.length) * 100}%` 
                                }}
                              />
                            </div>
                          </div>
                        ) : (
                          <div className="mb-4">
                            <p className="text-sm text-gray-600">
                              {program.steps.length} steps to complete
                            </p>
                          </div>
                        )}

                        <div className="space-y-2 mb-6">
                          {program.requirements.map((req, index) => (
                            <div key={index} className="flex items-center text-sm text-gray-600">
                              <CheckCircle className="h-4 w-4 text-green-600 mr-2" />
                              {req}
                            </div>
                          ))}
                        </div>

                        <div className="flex justify-between items-center pt-4 border-t">
                          <div className="flex items-center text-gray-600">
                            {isAuthenticated ? (
                              <>
                                <Clock className="h-5 w-5 mr-1" />
                                <span className="text-sm">
                                  {progress?.completed_at 
                                    ? 'Completed'
                                    : progress?.started_at
                                    ? 'In Progress'
                                    : 'Not Started'}
                                </span>
                              </>
                            ) : (
                              <>
                                <Lock className="h-5 w-5 mr-1" />
                                <span className="text-sm">Sign in required</span>
                              </>
                            )}
                          </div>
                          <button
                            onClick={() => handleProgramSelect(program.id)}
                            className="flex items-center text-blue-600 hover:text-blue-700"
                          >
                            {!isAuthenticated ? (
                              <>
                                Sign in to Start
                                <ArrowRight className="h-5 w-5 ml-1" />
                              </>
                            ) : progress?.completed_at ? (
                              <>
                                View Results
                                <ArrowRight className="h-5 w-5 ml-1" />
                              </>
                            ) : (
                              <>
                                Start Program
                                <ArrowRight className="h-5 w-5 ml-1" />
                              </>
                            )}
                          </button>
                        </div>
                      </div>
                    </div>
                  );
                })}
              </div>
            </div>
          )}
        </>
      )}
    </div>
  );
}