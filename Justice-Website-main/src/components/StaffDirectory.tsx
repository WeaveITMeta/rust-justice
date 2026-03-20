import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useCourt } from '../context/CourtContext';
import { supabase } from '../lib/auth';
import { Users, Building2, Phone, Mail, ArrowRight, Loader2, AlertCircle } from 'lucide-react';

interface StaffMember {
  id: string;
  full_name: string;
  title: string;
  email: string;
  phone: string;
  department: string;
  role: string;
}

export default function StaffDirectory() {
  const { selectedCourt } = useCourt();
  const navigate = useNavigate();
  const [staff, setStaff] = useState<StaffMember[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (selectedCourt) {
      fetchStaffMembers();
    }
  }, [selectedCourt]);

  async function fetchStaffMembers() {
    try {
      // First get all court administrators
      const { data: adminData, error: adminError } = await supabase
        .from('court_administrators')
        .select('id, role, user_id')
        .eq('court_location_id', selectedCourt.id)
        .eq('is_active', true)
        .order('role');

      if (adminError) throw adminError;

      if (!adminData?.length) {
        setStaff([]);
        return;
      }

      // Then get the profile information for each administrator
      const userIds = adminData.map(admin => admin.user_id);
      const { data: profileData, error: profileError } = await supabase
        .from('profiles')
        .select('id, full_name, email, phone, title')
        .in('id', userIds);

      if (profileError) throw profileError;

      // Combine the data
      const formattedStaff = adminData.map(admin => {
        const profile = profileData?.find(p => p.id === admin.user_id);
        return {
          id: admin.id,
          full_name: profile?.full_name || '',
          title: profile?.title || '',
          email: profile?.email || '',
          phone: profile?.phone || '',
          role: admin.role,
          department: getDepartment(admin.role)
        };
      });

      setStaff(formattedStaff);
    } catch (err) {
      console.error('Error fetching staff:', err);
      setError('Failed to load staff directory');
    } finally {
      setLoading(false);
    }
  }

  function getDepartment(role: string): string {
    switch (role) {
      case 'chief_judge':
        return 'Judicial';
      case 'judge':
        return 'Judicial';
      case 'administrator':
        return 'Administration';
      default:
        return 'General';
    }
  }

  const handleCourtSelection = () => {
    navigate('/courts');
  };

  if (!selectedCourt) {
    return (
      <div className="bg-white rounded-lg shadow-lg p-8 text-center">
        <Building2 className="h-12 w-12 text-gray-400 mx-auto mb-4" />
        <h3 className="text-lg font-medium text-gray-900 mb-2">No Court Selected</h3>
        <p className="text-gray-600 mb-6">Please select a court to view its administrative staff</p>
        <button
          onClick={handleCourtSelection}
          className="inline-flex items-center px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors"
        >
          Select Court
          <ArrowRight className="ml-2 h-5 w-5" />
        </button>
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
    <div className="bg-white rounded-lg shadow-lg p-6">
      <div className="flex justify-between items-start mb-6">
        <div>
          <h2 className="text-2xl font-bold mb-2">Staff Directory</h2>
          <p className="text-gray-600">{selectedCourt.name}</p>
        </div>
        <div className="text-right">
          <p className="text-sm text-gray-600">{selectedCourt.address}</p>
          <p className="text-sm text-gray-600">{selectedCourt.city}</p>
        </div>
      </div>

      {staff.length === 0 ? (
        <div className="text-center py-8">
          <Users className="h-12 w-12 text-gray-400 mx-auto mb-4" />
          <p className="text-lg font-medium">No staff members found</p>
          <p className="text-gray-600">The staff directory is currently empty</p>
        </div>
      ) : (
        <div className="space-y-6">
          {['Judicial', 'Administration', 'General'].map(department => {
            const departmentStaff = staff.filter(member => member.department === department);
            if (departmentStaff.length === 0) return null;

            return (
              <div key={department}>
                <h3 className="text-lg font-semibold mb-4">{department} Department</h3>
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                  {departmentStaff.map(member => (
                    <div
                      key={member.id}
                      className="border rounded-lg p-4 hover:shadow-md transition-shadow"
                    >
                      <h4 className="font-bold text-lg mb-1">{member.full_name}</h4>
                      <p className="text-blue-600 mb-2">{member.title || member.role}</p>
                      <div className="space-y-2 text-gray-600">
                        {member.email && (
                          <div className="flex items-center">
                            <Mail className="h-4 w-4 mr-2" />
                            <a
                              href={`mailto:${member.email}`}
                              className="hover:text-blue-600"
                            >
                              {member.email}
                            </a>
                          </div>
                        )}
                        {member.phone && (
                          <div className="flex items-center">
                            <Phone className="h-4 w-4 mr-2" />
                            <a
                              href={`tel:${member.phone}`}
                              className="hover:text-blue-600"
                            >
                              {member.phone}
                            </a>
                          </div>
                        )}
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            );
          })}
        </div>
      )}
    </div>
  );
}