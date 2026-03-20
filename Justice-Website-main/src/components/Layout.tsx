import React, { useState, useEffect } from 'react';
import { Link, Outlet, useNavigate, useLocation } from 'react-router-dom';
import { Scale, User, LogOut, Settings, ChevronDown, Shield } from 'lucide-react';
import { getCurrentUser, signOut } from '../lib/auth';
import type { UserProfile } from '../lib/auth';
import SelectedCourtBanner from './SelectedCourtBanner';

const formatName = (fullName: string) => {
  if (!fullName) return '';
  
  // Split the name into parts
  const parts = fullName.trim().split(' ');
  
  if (parts.length === 1) {
    // Just first name
    return parts[0].substring(0, 20);
  } else if (parts.length === 2) {
    // First and last name
    return `${parts[0]} ${parts[1]}`.substring(0, 20);
  } else {
    // First, middle (abbreviated), and last name
    const firstName = parts[0];
    const middleInitial = parts.slice(1, -1).map(name => `${name[0]}.`).join(' ');
    const lastName = parts[parts.length - 1];
    return `${firstName} ${middleInitial} ${lastName}`.substring(0, 20);
  }
};

const formatRole = (role: string) => {
  // Convert snake_case to Title Case and handle special cases
  if (role.toLowerCase() === 'user') return 'Citizen';
  return role
    .split('_')
    .map(word => word.charAt(0).toUpperCase() + word.slice(1))
    .join(' ');
};

const Header = () => {
  const [user, setUser] = useState<UserProfile | null>(null);
  const [showDropdown, setShowDropdown] = useState(false);
  const navigate = useNavigate();
  const location = useLocation();

  useEffect(() => {
    loadUser();
  }, []);

  async function loadUser() {
    try {
      const userData = await getCurrentUser();
      setUser(userData);
    } catch (error) {
      console.error('Error loading user:', error);
    }
  }

  const handleSignOut = async () => {
    try {
      await signOut();
      setUser(null);
      navigate('/');
    } catch (error) {
      console.error('Error signing out:', error);
    }
  };

  const isActive = (path: string) => {
    return location.pathname === path;
  };

  const navItems = [
    { path: '/', label: 'Home' },
    { path: '/courts', label: 'Courts' },
    { path: '/self-service', label: 'Service' },
    { path: '/programs', label: 'Programs' },
    { path: '/licensing', label: 'Licensing' },
    { path: '/regulation', label: 'Regulation' },
    { path: '/building', label: 'Building' },
    { path: '/administration', label: 'Administration' }
  ];

  return (
    <header className="bg-slate-900 text-white relative z-50">
      <div className="container mx-auto px-4">
        <div className="flex items-center justify-between h-20">
          <Link to="/" className="flex items-center space-x-3 -ml-2">
            <Scale className="h-10 w-10" />
            <span className="text-2xl font-bold">Justice</span>
          </Link>
          
          <div className="flex items-center">
            <nav className="hidden md:flex items-center mr-8">
              <div className="flex items-center justify-center space-x-4">
                {navItems.map(item => (
                  <Link 
                    key={item.path}
                    to={item.path} 
                    className={`
                      flex items-center justify-center h-[40px] px-2
                      hover:text-blue-400 transition
                      ${isActive(item.path) ? 'text-blue-400 border-b-2 border-blue-400' : ''}
                    `}
                  >
                    {item.label}
                  </Link>
                ))}
              </div>
            </nav>

            <div className="relative">
              {user ? (
                <div>
                  <button
                    onClick={() => setShowDropdown(!showDropdown)}
                    className="flex items-center space-x-2 bg-slate-800 hover:bg-slate-700 px-4 py-2 rounded-lg transition-colors"
                  >
                    <User className="h-5 w-5" />
                    <span className="max-w-[150px] truncate">
                      {formatName(user.full_name || user.email)}
                    </span>
                    <ChevronDown className={`h-4 w-4 transition-transform ${showDropdown ? 'rotate-180' : ''}`} />
                  </button>

                  {showDropdown && (
                    <div className="absolute right-0 mt-2 w-64 bg-white rounded-lg shadow-lg py-1 text-gray-700 z-50">
                      <div className="px-4 py-2 border-b">
                        <p className="font-medium truncate">{formatName(user.full_name)}</p>
                        <p className="text-sm text-gray-500 truncate">{user.email}</p>
                      </div>
                      
                      {/* Role Status Section */}
                      <div className="px-4 py-3 border-b">
                        <div className="flex items-center text-sm text-gray-600 mb-2">
                          <Shield className="h-4 w-4 mr-2 text-blue-600" />
                          <span>Role Status</span>
                        </div>
                        <div className="space-y-1">
                          {user.roles?.length > 0 ? (
                            user.roles.map((role, index) => (
                              <div key={index} className="flex items-center text-sm">
                                <div className="w-2 h-2 rounded-full bg-green-500 mr-2"></div>
                                <span className="font-medium">{formatRole(role)}</span>
                              </div>
                            ))
                          ) : (
                            <div className="flex items-center text-sm">
                              <div className="w-2 h-2 rounded-full bg-blue-500 mr-2"></div>
                              <span className="font-medium">Citizen</span>
                            </div>
                          )}
                        </div>
                      </div>

                      {user.roles?.includes('administrator') && (
                        <Link
                          to="/administration"
                          className="flex items-center px-4 py-2 hover:bg-gray-100 transition-colors"
                          onClick={() => setShowDropdown(false)}
                        >
                          <Settings className="h-4 w-4 mr-2" />
                          Administration
                        </Link>
                      )}
                      <button
                        onClick={handleSignOut}
                        className="flex items-center w-full px-4 py-2 hover:bg-gray-100 transition-colors text-red-600"
                      >
                        <LogOut className="h-4 w-4 mr-2" />
                        Sign Out
                      </button>
                    </div>
                  )}
                </div>
              ) : (
                <Link
                  to="/login"
                  className="flex items-center space-x-2 bg-blue-600 hover:bg-blue-700 px-4 py-2 rounded-lg transition-colors"
                >
                  <User className="h-5 w-5" />
                  <span>Sign In</span>
                </Link>
              )}
            </div>
          </div>
        </div>
      </div>
    </header>
  );
};

const Footer = () => (
  <footer className="bg-slate-900 text-white mt-auto">
    <div className="container mx-auto px-4 py-8">
      <div className="grid grid-cols-1 md:grid-cols-4 gap-8">
        <div>
          <h3 className="text-lg font-bold mb-4">Contact Us</h3>
          <p>123 Justice Way</p>
          <p>Courthouse Square</p>
          <p>Phone: (555) 123-4567</p>
        </div>
        <div>
          <h3 className="text-lg font-bold mb-4">Quick Links</h3>
          <ul className="space-y-2">
            <li><Link to="/self-service" className="hover:text-blue-400">Forms & Documents</Link></li>
            <li><Link to="/courts" className="hover:text-blue-400">Court Calendar</Link></li>
            <li><Link to="/licensing" className="hover:text-blue-400">License Applications</Link></li>
          </ul>
        </div>
        <div>
          <h3 className="text-lg font-bold mb-4">Resources</h3>
          <ul className="space-y-2">
            <li><Link to="/regulation" className="hover:text-blue-400">Legal Resources</Link></li>
            <li><Link to="/administration" className="hover:text-blue-400">Administrative Office</Link></li>
            <li><Link to="/programs" className="hover:text-blue-400">Programs</Link></li>
          </ul>
        </div>
        <div>
          <h3 className="text-lg font-bold mb-4">Connect With Us</h3>
          <div className="flex space-x-4">
            {/* Social media links would go here */}
          </div>
        </div>
      </div>
      <div className="border-t border-slate-700 mt-8 pt-8 text-center">
        <p>&copy; {new Date().getFullYear()} Justice Portal. All rights reserved.</p>
      </div>
    </div>
  </footer>
);

export default function Layout() {
  // Close dropdown when clicking outside
  useEffect(() => {
    function handleClick(e: MouseEvent) {
      const target = e.target as HTMLElement;
      if (!target.closest('.profile-menu')) {
        const dropdowns = document.querySelectorAll('.profile-dropdown');
        dropdowns.forEach(dropdown => {
          if (dropdown.classList.contains('show')) {
            dropdown.classList.remove('show');
          }
        });
      }
    }

    document.addEventListener('click', handleClick);
    return () => document.removeEventListener('click', handleClick);
  }, []);

  return (
    <div className="min-h-screen flex flex-col">
      <Header />
      <SelectedCourtBanner />
      <main className="flex-grow">
        <Outlet />
      </main>
      <Footer />
    </div>
  );
}