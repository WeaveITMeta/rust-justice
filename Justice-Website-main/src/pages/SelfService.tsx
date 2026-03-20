import React, { useState, useEffect } from 'react';
import { Link, useLocation, useNavigate } from 'react-router-dom';
import { FileText, Search, HelpCircle, Calendar, DollarSign, Gavel, ArrowRight, ArrowLeft } from 'lucide-react';
import LegalFormsBrowser from '../components/LegalFormsBrowser';
import CaseSearch from '../components/CaseSearch';
import TrafficTicketPayment from '../components/TrafficTicketPayment';

type View = 'main' | 'forms' | 'case-search' | 'traffic-tickets';

export default function SelfService() {
  const [currentView, setCurrentView] = useState<View>('main');
  const location = useLocation();
  const navigate = useNavigate();

  // Reset view when navigating to the page
  useEffect(() => {
    const params = new URLSearchParams(location.search);
    const view = params.get('view');
    if (view === 'forms') {
      setCurrentView('forms');
    } else {
      setCurrentView('main');
    }
  }, [location]);

  const resetView = () => {
    setCurrentView('main');
    navigate('/self-service');
  };

  const quickLinks = [
    {
      title: "Case Search",
      description: "Look up case information and status",
      icon: <Search className="h-6 w-6" />,
      action: () => setCurrentView('case-search')
    },
    {
      title: "Help Center",
      description: "Get assistance with court services",
      icon: <HelpCircle className="h-6 w-6" />,
      action: () => navigate('/help')
    }
  ];

  const popularServices = [
    {
      title: "Pay Traffic Tickets",
      icon: <DollarSign className="h-6 w-6" />,
      description: "Pay citations and view payment history",
      action: () => setCurrentView('traffic-tickets')
    },
    {
      title: "Court Calendar",
      icon: <Calendar className="h-6 w-6" />,
      description: "View upcoming court dates and schedules",
      action: () => navigate('/courts#calendar')
    },
    {
      title: "Legal Resources",
      icon: <Gavel className="h-6 w-6" />,
      description: "Access guides and legal information",
      action: () => navigate('/help')
    }
  ];

  const renderView = () => {
    switch (currentView) {
      case 'forms':
        return <LegalFormsBrowser />;
      case 'case-search':
        return <CaseSearch />;
      case 'traffic-tickets':
        return <TrafficTicketPayment />;
      default:
        return (
          <>
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8 mb-12">
              <div className="bg-white p-6 rounded-lg shadow-lg">
                <FileText className="h-8 w-8 text-blue-600 mb-4" />
                <h2 className="text-xl font-bold mb-2">Legal Forms</h2>
                <p className="text-gray-600 mb-4">Access and complete court forms online</p>
                <button 
                  onClick={() => setCurrentView('forms')}
                  className="text-blue-600 hover:text-blue-700 flex items-center"
                >
                  Browse Forms <ArrowRight className="h-4 w-4 ml-1" />
                </button>
              </div>

              {popularServices.map((service, index) => (
                <div key={index} className="bg-white p-6 rounded-lg shadow-lg">
                  <div className="text-blue-600">{service.icon}</div>
                  <h2 className="text-xl font-bold mb-2">{service.title}</h2>
                  <p className="text-gray-600 mb-4">{service.description}</p>
                  <button 
                    onClick={service.action}
                    className="text-blue-600 hover:text-blue-700 flex items-center"
                  >
                    Access Service <ArrowRight className="h-4 w-4 ml-1" />
                  </button>
                </div>
              ))}
            </div>

            <div className="bg-gray-50 p-8 rounded-lg mb-12">
              <h2 className="text-2xl font-bold mb-6">Quick Links</h2>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                {quickLinks.map((link, index) => (
                  <button
                    key={index}
                    onClick={link.action}
                    className="bg-white p-4 rounded-lg shadow hover:shadow-md transition-shadow duration-200 flex items-start space-x-3 w-full text-left"
                  >
                    <div className="text-blue-600">{link.icon}</div>
                    <div>
                      <h3 className="font-bold mb-1">{link.title}</h3>
                      <p className="text-gray-600">{link.description}</p>
                    </div>
                  </button>
                ))}
              </div>
            </div>
          </>
        );
    }
  };

  return (
    <div className="container mx-auto px-4 py-8">
      <div className="flex items-center justify-between mb-8">
        <h1 className="text-4xl font-bold">Self Service Portal</h1>
        {currentView !== 'main' && (
          <button
            onClick={resetView}
            className="flex items-center text-blue-600 hover:text-blue-700 transition-colors duration-200"
          >
            <ArrowLeft className="h-5 w-5 mr-2" />
            Back to Self Service
          </button>
        )}
      </div>

      {renderView()}
    </div>
  );
}