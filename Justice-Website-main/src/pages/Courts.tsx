import React from 'react';
import { Link } from 'react-router-dom';
import { Scale, Calendar, MapPin, BookOpen, Gavel, FileText } from 'lucide-react';
import CourtCalendar from '../components/CourtCalendar';
import LocationSelector from '../components/LocationSelector';
import CourtList from '../components/CourtList';

export default function Courts() {
  const jurisdictions = [
    {
      title: "Federal District Courts",
      description: "U.S.C. Title 28, Chapter 5",
      details: "Original jurisdiction for federal cases, civil actions, and criminal proceedings"
    },
    {
      title: "Courts of Appeals",
      description: "U.S.C. Title 28, Chapter 3",
      details: "Appellate jurisdiction over district courts and federal administrative agencies"
    },
    {
      title: "Supreme Court",
      description: "U.S.C. Title 28, Chapter 1",
      details: "Highest court of the United States with ultimate appellate jurisdiction"
    }
  ];

  const procedures = [
    {
      title: "Civil Procedure",
      code: "Title 28, Part IV",
      description: "Federal Rules of Civil Procedure and jurisdictional requirements"
    },
    {
      title: "Criminal Procedure",
      code: "Title 18, Part II",
      description: "Federal criminal procedure and rights of defendants"
    },
    {
      title: "Evidence Rules",
      code: "Title 28, Appendix",
      description: "Federal Rules of Evidence for court proceedings"
    }
  ];

  return (
    <div className="container mx-auto px-4 py-8">
      <h1 className="text-4xl font-bold mb-8">Courts</h1>
      
      {/* Court Selection Section */}
      <div className="bg-white rounded-lg shadow-lg p-6 mb-12">
        <h2 className="text-2xl font-bold mb-6 flex items-center">
          <MapPin className="h-6 w-6 mr-2 text-blue-600" />
          Select Your Court
        </h2>
        <div className="space-y-8">
          <LocationSelector />
          <CourtList />
        </div>
      </div>

      {/* Court Calendar Section */}
      <div id="calendar" className="mb-12">
        <CourtCalendar />
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-8 mb-12">
        <div>
          <h2 className="text-2xl font-bold mb-6 flex items-center">
            <Gavel className="h-6 w-6 mr-2 text-blue-600" />
            Federal Court System
          </h2>
          <div className="space-y-4">
            {jurisdictions.map((court, index) => (
              <div key={index} className="bg-white p-6 border rounded-lg shadow-sm">
                <h3 className="font-bold text-lg mb-2">{court.title}</h3>
                <p className="text-blue-600 text-sm mb-2">{court.description}</p>
                <p className="text-gray-600">{court.details}</p>
              </div>
            ))}
          </div>
        </div>
        
        <div>
          <h2 className="text-2xl font-bold mb-6 flex items-center">
            <BookOpen className="h-6 w-6 mr-2 text-blue-600" />
            Federal Rules & Procedures
          </h2>
          <div className="bg-gray-50 p-6 rounded-lg">
            {procedures.map((procedure, index) => (
              <div key={index} className="mb-6 last:mb-0">
                <h3 className="font-bold text-lg mb-2">{procedure.title}</h3>
                <p className="text-blue-600 text-sm mb-1">{procedure.code}</p>
                <p className="text-gray-600">{procedure.description}</p>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}