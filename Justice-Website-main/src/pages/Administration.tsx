import React, { useState, useEffect } from 'react';
import { Users, FileText, Phone, Shield, AlertCircle, Info, Loader2, ChevronRight, Building2 } from 'lucide-react';
import { useNavigate } from 'react-router-dom';
import { useCourt } from '../context/CourtContext';
import BankAccountManagement from '../components/BankAccountManagement';
import StaffDirectory from '../components/StaffDirectory';
import DocumentUploadCenter from '../components/DocumentUploadCenter';
import { hasRole } from '../lib/auth';

interface AdminStats {
  totalUsers: number;
  totalCourts: number;
  totalCases: number;
  activeUsers: number;
}

export default function Administration() {
  const [canManageAccounts, setCanManageAccounts] = useState(false);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [activeView, setActiveView] = useState<'main' | 'directory' | 'accounts' | 'documents'>('main');
  const navigate = useNavigate();
  const { selectedCourt } = useCourt();
  const [stats, setStats] = useState<AdminStats>({
    totalUsers: 0,
    totalCourts: 0,
    totalCases: 0,
    activeUsers: 0
  });

  useEffect(() => {
    checkPermissions();
  }, []);

  async function checkPermissions() {
    try {
      const hasAdminRole = await hasRole('administrator');
      if (!hasAdminRole) {
        navigate('/');
        return;
      }
      setCanManageAccounts(hasAdminRole);
      await loadStats();
    } catch (error) {
      console.error('Error checking permissions:', error);
      setError('Failed to verify admin access');
    } finally {
      setLoading(false);
    }
  }

  async function loadStats() {
    try {
      // In a real implementation, these would be fetched from Supabase
      setStats({
        totalUsers: 1250,
        totalCourts: 324,
        totalCases: 15678,
        activeUsers: 892
      });
    } catch (err) {
      console.error('Error loading stats:', err);
      setError('Failed to load admin statistics');
    }
  }

  const handleViewDirectory = () => {
    if (selectedCourt) {
      setActiveView('directory');
    } else {
      navigate('/courts');
    }
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <Loader2 className="h-8 w-8 animate-spin text-blue-600" />
      </div>
    );
  }

  return (
    <div className="container mx-auto px-4 py-8">
      {activeView === 'main' && (
        <>
          <div className="flex justify-between items-start mb-8">
            <div>
              <h1 className="text-4xl font-bold mb-2">Admin Panel</h1>
              <p className="text-gray-600">System administration and management</p>
            </div>
            <div className="flex items-center space-x-2 bg-blue-50 text-blue-700 px-4 py-2 rounded-lg">
              <Shield className="h-5 w-5" />
              <span className="font-medium">Administrator Access</span>
            </div>
          </div>

          {error && (
            <div className="mb-8 p-4 bg-red-50 text-red-700 rounded-lg flex items-center">
              <AlertCircle className="h-5 w-5 mr-2" />
              {error}
            </div>
          )}

          {/* Stats Overview */}
          <div className="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
            <div className="bg-white p-6 rounded-lg shadow-lg">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm text-gray-600">Total Users</p>
                  <p className="text-2xl font-bold">{stats.totalUsers}</p>
                </div>
                <Users className="h-8 w-8 text-blue-600" />
              </div>
            </div>

            <div className="bg-white p-6 rounded-lg shadow-lg">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm text-gray-600">Court Locations</p>
                  <p className="text-2xl font-bold">{stats.totalCourts}</p>
                </div>
                <Building2 className="h-8 w-8 text-blue-600" />
              </div>
            </div>

            <div className="bg-white p-6 rounded-lg shadow-lg">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm text-gray-600">Active Cases</p>
                  <p className="text-2xl font-bold">{stats.totalCases}</p>
                </div>
                <FileText className="h-8 w-8 text-blue-600" />
              </div>
            </div>

            <div className="bg-white p-6 rounded-lg shadow-lg">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm text-gray-600">Active Users</p>
                  <p className="text-2xl font-bold">{stats.activeUsers}</p>
                </div>
                <Users className="h-8 w-8 text-blue-600" />
              </div>
            </div>
          </div>

          {/* Admin Modules */}
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <div className="bg-white p-6 rounded-lg shadow-lg">
              <div className="flex items-start justify-between">
                <div className="flex-1">
                  <div className="flex items-center mb-4">
                    <Users className="h-6 w-6 text-blue-600" />
                    <h3 className="text-lg font-bold ml-2">User Management</h3>
                  </div>
                  <p className="text-gray-600 mb-4">Manage user accounts, roles, and permissions</p>
                  <button
                    onClick={() => navigate('/administration/users')}
                    className="text-blue-600 hover:text-blue-700 flex items-center"
                  >
                    Manage
                    <ChevronRight className="h-4 w-4 ml-1" />
                  </button>
                </div>
              </div>
            </div>

            <div className="bg-white p-6 rounded-lg shadow-lg">
              <div className="flex items-start justify-between">
                <div className="flex-1">
                  <div className="flex items-center mb-4">
                    <Building2 className="h-6 w-6 text-blue-600" />
                    <h3 className="text-lg font-bold ml-2">Court Administration</h3>
                  </div>
                  <p className="text-gray-600 mb-4">Manage court locations, schedules, and resources</p>
                  <button
                    onClick={() => navigate('/administration/courts')}
                    className="text-blue-600 hover:text-blue-700 flex items-center"
                  >
                    Manage
                    <ChevronRight className="h-4 w-4 ml-1" />
                  </button>
                </div>
              </div>
            </div>

            <div className="bg-white p-6 rounded-lg shadow-lg">
              <div className="flex items-start justify-between">
                <div className="flex-1">
                  <div className="flex items-center mb-4">
                    <FileText className="h-6 w-6 text-blue-600" />
                    <h3 className="text-lg font-bold ml-2">Document Management</h3>
                  </div>
                  <p className="text-gray-600 mb-4">Manage legal documents, forms, and templates</p>
                  <button
                    onClick={() => setActiveView('documents')}
                    className="text-blue-600 hover:text-blue-700 flex items-center"
                  >
                    Manage
                    <ChevronRight className="h-4 w-4 ml-1" />
                  </button>
                </div>
              </div>
            </div>

            <div className="bg-white p-6 rounded-lg shadow-lg">
              <div className="flex items-start justify-between">
                <div className="flex-1">
                  <div className="flex items-center mb-4">
                    <Building2 className="h-6 w-6 text-blue-600" />
                    <h3 className="text-lg font-bold ml-2">Facility Management</h3>
                  </div>
                  <p className="text-gray-600 mb-4">Manage courthouse facilities and resources</p>
                  <button
                    onClick={() => navigate('/administration/facilities')}
                    className="text-blue-600 hover:text-blue-700 flex items-center"
                  >
                    Manage
                    <ChevronRight className="h-4 w-4 ml-1" />
                  </button>
                </div>
              </div>
            </div>

            <div className="bg-white p-6 rounded-lg shadow-lg">
              <div className="flex items-start justify-between">
                <div className="flex-1">
                  <div className="flex items-center mb-4">
                    <Shield className="h-6 w-6 text-blue-600" />
                    <h3 className="text-lg font-bold ml-2">Security Settings</h3>
                  </div>
                  <p className="text-gray-600 mb-4">Configure system security and access controls</p>
                  <button
                    onClick={() => navigate('/administration/security')}
                    className="text-blue-600 hover:text-blue-700 flex items-center"
                  >
                    Manage
                    <ChevronRight className="h-4 w-4 ml-1" />
                  </button>
                </div>
              </div>
            </div>
          </div>

          {canManageAccounts && (
            <div className="mt-12">
              <BankAccountManagement />
            </div>
          )}
        </>
      )}

      {activeView === 'directory' && (
        <div>
          <div className="flex items-center mb-6">
            <button 
              onClick={() => setActiveView('main')}
              className="text-blue-600 hover:text-blue-700 mr-4"
            >
              ← Back to Administration
            </button>
          </div>
          <StaffDirectory />
        </div>
      )}

      {activeView === 'documents' && (
        <div>
          <div className="flex items-center mb-6">
            <button 
              onClick={() => setActiveView('main')}
              className="text-blue-600 hover:text-blue-700 mr-4"
            >
              ← Back to Administration
            </button>
          </div>
          <DocumentUploadCenter />
        </div>
      )}
    </div>
  );
}