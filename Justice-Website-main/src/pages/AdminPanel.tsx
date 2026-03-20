import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { Shield, Users, Gavel, FileText, Building2, Settings, ChevronRight, AlertCircle, Loader2 } from 'lucide-react';
import { hasRole, getUserRoleByEmail } from '../lib/auth';

interface AdminStats {
  totalUsers: number;
  totalCourts: number;
  totalCases: number;
  activeUsers: number;
}

export default function AdminPanel() {
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [stats, setStats] = useState<AdminStats>({
    totalUsers: 0,
    totalCourts: 0,
    totalCases: 0,
    activeUsers: 0
  });
  const navigate = useNavigate();

  useEffect(() => {
    checkAdminAccess();
  }, []);

  async function checkAdminAccess() {
    try {
      const isAdmin = await hasRole('administrator');
      if (!isAdmin) {
        navigate('/');
        return;
      }
      
      // Load admin stats
      await loadStats();
    } catch (err) {
      console.error('Error checking admin access:', err);
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

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <Loader2 className="h-8 w-8 animate-spin text-blue-600" />
      </div>
    );
  }

  const adminModules = [
    {
      title: 'User Management',
      icon: <Users className="h-6 w-6 text-blue-600" />,
      description: 'Manage user accounts, roles, and permissions',
      link: '/administration/users'
    },
    {
      title: 'Court Administration',
      icon: <Gavel className="h-6 w-6 text-blue-600" />,
      description: 'Manage court locations, schedules, and resources',
      link: '/administration/courts'
    },
    {
      title: 'Document Management',
      icon: <FileText className="h-6 w-6 text-blue-600" />,
      description: 'Manage legal documents, forms, and templates',
      link: '/administration/documents'
    },
    {
      title: 'Facility Management',
      icon: <Building2 className="h-6 w-6 text-blue-600" />,
      description: 'Manage courthouse facilities and resources',
      link: '/administration/facilities'
    },
    {
      title: 'System Settings',
      icon: <Settings className="h-6 w-6 text-blue-600" />,
      description: 'Configure system settings and preferences',
      link: '/administration/settings'
    }
  ];

  return (
    <div className="container mx-auto px-4 py-8">
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
            <Gavel className="h-8 w-8 text-blue-600" />
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
        {adminModules.map((module, index) => (
          <div key={index} className="bg-white p-6 rounded-lg shadow-lg">
            <div className="flex items-start justify-between">
              <div className="flex-1">
                <div className="flex items-center mb-4">
                  {module.icon}
                  <h3 className="text-lg font-bold ml-2">{module.title}</h3>
                </div>
                <p className="text-gray-600 mb-4">{module.description}</p>
                <button
                  onClick={() => navigate(module.link)}
                  className="text-blue-600 hover:text-blue-700 flex items-center"
                >
                  Manage
                  <ChevronRight className="h-4 w-4 ml-1" />
                </button>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}