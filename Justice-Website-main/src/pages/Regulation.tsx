import React, { useState } from 'react';
import { BookOpen, Scale, Shield, AlertCircle, FileText, Search, Filter, ChevronDown, ChevronRight, ExternalLink } from 'lucide-react';
import RegulationAnalysis from '../components/RegulationAnalysis';

interface LegalFramework {
  title: string;
  description: string;
  sections: {
    name: string;
    content: string[];
  }[];
  lastUpdated: string;
}

export default function Regulation() {
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedCategory, setSelectedCategory] = useState<string>('');
  const [expandedTitle, setExpandedTitle] = useState<string | null>(null);
  const [activeView, setActiveView] = useState<'uscode' | 'framework' | 'compliance' | 'analysis'>('uscode');

  const categories = [
    'All',
    'Constitutional Law',
    'Criminal Law',
    'Civil Law',
    'Administrative Law',
    'Tax Law',
    'Immigration Law',
    'Environmental Law',
    'Labor Law'
  ];

  const uscTitles = [
    {
      title: "Title 1",
      name: "General Provisions",
      description: "Rules of construction, definitions, and general provisions",
      sections: [
        "§ 1-100 - Words denoting number, gender, and tense",
        "§ 101-200 - Definitions and rules of construction",
        "§ 201-300 - Territorial application of laws",
        "§ 301-400 - Administrative provisions"
      ]
    },
    {
      title: "Title 2",
      name: "The Congress",
      description: "Organization and operation of Congress",
      sections: [
        "§ 1-100 - Congressional organization",
        "§ 101-200 - House of Representatives",
        "§ 201-300 - Senate procedures",
        "§ 301-400 - Legislative process"
      ]
    },
    {
      title: "Title 3",
      name: "The President",
      description: "Presidential powers and duties",
      sections: [
        "§ 1-100 - Presidential succession",
        "§ 101-200 - Executive powers",
        "§ 201-300 - White House operations",
        "§ 301-400 - Executive orders"
      ]
    },
    { title: "Title 4", name: "Flag and Seal, Seat of Government", description: "National symbols and capital" },
    { title: "Title 5", name: "Government Organization and Employees", description: "Federal agencies and civil service" },
    { title: "Title 6", name: "Domestic Security", description: "Homeland security and domestic safety" },
    { title: "Title 7", name: "Agriculture", description: "Farming, food, and agriculture" },
    { title: "Title 8", name: "Aliens and Nationality", description: "Immigration and citizenship" },
    { title: "Title 9", name: "Arbitration", description: "Commercial arbitration and proceedings" },
    { title: "Title 10", name: "Armed Forces", description: "Military organization and procedure" },
    { title: "Title 11", name: "Bankruptcy", description: "Bankruptcy and insolvency" },
    { title: "Title 12", name: "Banks and Banking", description: "Financial institutions and operations" },
    { title: "Title 13", name: "Census", description: "Census Bureau and demographic data" },
    { title: "Title 14", name: "Coast Guard", description: "Coast Guard organization and operations" },
    { title: "Title 15", name: "Commerce and Trade", description: "Business and commercial regulations" },
    { title: "Title 16", name: "Conservation", description: "Environmental protection and wildlife" },
    { title: "Title 17", name: "Copyrights", description: "Copyright law and intellectual property" },
    { title: "Title 18", name: "Crimes and Criminal Procedure", description: "Criminal law and procedure" },
    { title: "Title 19", name: "Customs Duties", description: "Import/export and tariffs" },
    { title: "Title 20", name: "Education", description: "Educational programs and institutions" },
    { title: "Title 21", name: "Food and Drugs", description: "Food safety and drug regulation" },
    { title: "Title 22", name: "Foreign Relations and Intercourse", description: "International relations" },
    { title: "Title 23", name: "Highways", description: "Federal highway programs" },
    { title: "Title 24", name: "Hospitals and Asylums", description: "Healthcare facilities" },
    { title: "Title 25", name: "Indians", description: "Native American tribes and relations" },
    { title: "Title 26", name: "Internal Revenue Code", description: "Federal tax law" },
    { title: "Title 27", name: "Intoxicating Liquors", description: "Alcohol regulation" },
    { title: "Title 28", name: "Judiciary and Judicial Procedure", description: "Courts and civil procedure" },
    { title: "Title 29", name: "Labor", description: "Employment and labor law" },
    { title: "Title 30", name: "Mineral Lands and Mining", description: "Mining and mineral resources" },
    { title: "Title 31", name: "Money and Finance", description: "Treasury and financial management" },
    { title: "Title 32", name: "National Guard", description: "State militia and National Guard" },
    { title: "Title 33", name: "Navigation and Navigable Waters", description: "Waterway regulation" },
    { title: "Title 34", name: "Crime Control and Law Enforcement", description: "Law enforcement and public safety" },
    { title: "Title 35", name: "Patents", description: "Patent law and intellectual property" },
    { title: "Title 36", name: "Patriotic and National Observances", description: "Patriotic organizations and observances" },
    { title: "Title 37", name: "Pay and Allowances of the Uniformed Services", description: "Military compensation" },
    { title: "Title 38", name: "Veterans' Benefits", description: "Veterans' rights and benefits" },
    { title: "Title 39", name: "Postal Service", description: "Postal system operations" },
    { title: "Title 40", name: "Public Buildings, Property, and Works", description: "Public property management" },
    { title: "Title 41", name: "Public Contracts", description: "Government procurement" },
    { title: "Title 42", name: "The Public Health and Welfare", description: "Public health and social programs" },
    { title: "Title 43", name: "Public Lands", description: "Public land management" },
    { title: "Title 44", name: "Public Printing and Documents", description: "Government publishing" },
    { title: "Title 45", name: "Railroads", description: "Railroad transportation" },
    { title: "Title 46", name: "Shipping", description: "Maritime law and shipping" },
    { title: "Title 47", name: "Telecommunications", description: "Communications regulation" },
    { title: "Title 48", name: "Territories and Insular Possessions", description: "U.S. territories" },
    { title: "Title 49", name: "Transportation", description: "Transportation regulation" },
    { title: "Title 50", name: "War and National Defense", description: "Military and national security" },
    { title: "Title 51", name: "National and Commercial Space Programs", description: "Space exploration" },
    { title: "Title 52", name: "Voting and Elections", description: "Federal election law" },
    { title: "Title 53", name: "Small Business", description: "Small business programs" },
    { title: "Title 54", name: "National Park Service", description: "National parks and monuments" }
  ].map(title => ({
    ...title,
    sections: title.sections || [
      `§ 1-100 - General Provisions`,
      `§ 101-200 - Definitions and Rules`,
      `§ 201-300 - Administration`,
      `§ 301-400 - Enforcement`
    ]
  }));

  const legalFramework: LegalFramework[] = [
    {
      title: "Administrative Procedure Act",
      description: "Governs the process for federal administrative agencies to propose and establish regulations",
      sections: [
        {
          name: "Rulemaking",
          content: [
            "Notice of Proposed Rulemaking (NPRM)",
            "Public Comment Period",
            "Final Rule Publication",
            "Administrative Record"
          ]
        },
        {
          name: "Adjudication",
          content: [
            "Formal Hearings",
            "Informal Proceedings",
            "Administrative Appeals",
            "Judicial Review"
          ]
        }
      ],
      lastUpdated: "2024"
    },
    {
      title: "Code of Federal Regulations",
      description: "Codification of general and permanent rules by federal agencies",
      sections: [
        {
          name: "Structure",
          content: [
            "50 Titles",
            "Chapter Organization",
            "Part and Section Numbering",
            "Authority Citations"
          ]
        },
        {
          name: "Updates",
          content: [
            "Annual Revisions",
            "Federal Register Integration",
            "Electronic Access",
            "Historical Archives"
          ]
        }
      ],
      lastUpdated: "2024"
    },
    {
      title: "Federal Register System",
      description: "Official journal of federal government rules, proposed rules, and notices",
      sections: [
        {
          name: "Publication Requirements",
          content: [
            "Daily Publication",
            "Document Categories",
            "Format Standards",
            "Public Inspection"
          ]
        },
        {
          name: "Notice Types",
          content: [
            "Proposed Rules",
            "Final Rules",
            "Notices",
            "Presidential Documents"
          ]
        }
      ],
      lastUpdated: "2024"
    }
  ];

  const filteredTitles = uscTitles.filter(title => {
    const searchLower = searchQuery.toLowerCase();
    return (
      title.title.toLowerCase().includes(searchLower) ||
      title.name.toLowerCase().includes(searchLower) ||
      title.description.toLowerCase().includes(searchLower)
    );
  });

  return (
    <div className="container mx-auto px-4 py-8">
      <h1 className="text-4xl font-bold mb-8">Regulations & Compliance</h1>

      <div className="grid grid-cols-1 md:grid-cols-4 gap-8 mb-12">
        <div 
          className={`bg-white p-6 rounded-lg shadow cursor-pointer transition-all ${
            activeView === 'uscode' ? 'ring-2 ring-blue-500' : 'hover:shadow-lg'
          }`}
          onClick={() => setActiveView('uscode')}
        >
          <BookOpen className="h-8 w-8 text-blue-600 mb-4" />
          <h2 className="text-xl font-bold mb-2">U.S. Code Reference</h2>
          <p className="text-gray-600">Complete reference of federal statutes</p>
        </div>

        <div 
          className={`bg-white p-6 rounded-lg shadow cursor-pointer transition-all ${
            activeView === 'framework' ? 'ring-2 ring-blue-500' : 'hover:shadow-lg'
          }`}
          onClick={() => setActiveView('framework')}
        >
          <Scale className="h-8 w-8 text-blue-600 mb-4" />
          <h2 className="text-xl font-bold mb-2">Legal Framework</h2>
          <p className="text-gray-600">Administrative rules and regulations</p>
        </div>

        <div 
          className={`bg-white p-6 rounded-lg shadow cursor-pointer transition-all ${
            activeView === 'compliance' ? 'ring-2 ring-blue-500' : 'hover:shadow-lg'
          }`}
          onClick={() => setActiveView('compliance')}
        >
          <Shield className="h-8 w-8 text-blue-600 mb-4" />
          <h2 className="text-xl font-bold mb-2">Compliance Guide</h2>
          <p className="text-gray-600">Regulatory compliance guidelines</p>
        </div>

        <div 
          className={`bg-white p-6 rounded-lg shadow cursor-pointer transition-all ${
            activeView === 'analysis' ? 'ring-2 ring-blue-500' : 'hover:shadow-lg'
          }`}
          onClick={() => setActiveView('analysis')}
        >
          <Scale className="h-8 w-8 text-blue-600 mb-4" />
          <h2 className="text-xl font-bold mb-2">Analysis Tools</h2>
          <p className="text-gray-600">Analyze regulations and assess compliance</p>
        </div>
      </div>

      {activeView === 'uscode' && (
        <>
          {/* Search and Filter Section */}
          <div className="bg-white rounded-lg shadow-lg p-6 mb-8">
            <div className="flex flex-wrap gap-4 items-center">
              <div className="flex-1">
                <div className="relative">
                  <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400 h-5 w-5" />
                  <input
                    type="text"
                    placeholder="Search U.S. Code titles..."
                    value={searchQuery}
                    onChange={(e) => setSearchQuery(e.target.value)}
                    className="w-full pl-10 pr-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                  />
                </div>
              </div>
              <div className="flex gap-4">
                <select
                  value={selectedCategory}
                  onChange={(e) => setSelectedCategory(e.target.value)}
                  className="border rounded-lg px-4 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                >
                  {categories.map(category => (
                    <option key={category} value={category}>{category}</option>
                  ))}
                </select>
              </div>
            </div>
          </div>

          {/* U.S. Code Titles */}
          <div className="bg-white rounded-lg shadow-lg">
            <div className="p-6 border-b">
              <h2 className="text-2xl font-bold">United States Code</h2>
              <p className="text-gray-600">Complete listing of all U.S. Code titles and their contents</p>
            </div>

            <div className="divide-y">
              {filteredTitles.map((title, index) => (
                <div key={index} className="p-6">
                  <div className="flex justify-between items-start mb-4">
                    <div>
                      <h3 className="text-xl font-bold mb-2">{title.title} - {title.name}</h3>
                      <p className="text-gray-600">{title.description}</p>
                    </div>
                    <a
                      href={`https://www.law.cornell.edu/uscode/text/${title.title.split(' ')[1]}`}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="text-blue-600 hover:text-blue-700 flex items-center"
                    >
                      View Full Title
                      <ExternalLink className="h-4 w-4 ml-1" />
                    </a>
                  </div>
                  <div className="mt-4 space-y-2">
                    {title.sections.map((section, sIndex) => (
                      <div key={sIndex} className="flex items-center text-gray-700">
                        <ChevronRight className="h-4 w-4 text-blue-600 mr-2" />
                        {section}
                      </div>
                    ))}
                  </div>
                </div>
              ))}
            </div>
          </div>
        </>
      )}

      {activeView === 'framework' && (
        <div className="bg-white rounded-lg shadow-lg">
          <div className="p-6 border-b">
            <h2 className="text-2xl font-bold">Legal Framework</h2>
            <p className="text-gray-600">Federal administrative and regulatory framework</p>
          </div>

          <div className="divide-y">
            {legalFramework.map((framework, index) => (
              <div key={index} className="p-6">
                <div className="flex justify-between items-start mb-4">
                  <div>
                    <h3 className="text-xl font-bold mb-2">{framework.title}</h3>
                    <p className="text-gray-600">{framework.description}</p>
                  </div>
                  <span className="text-sm text-gray-500">
                    Updated: {framework.lastUpdated}
                  </span>
                </div>

                <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mt-4">
                  {framework.sections.map((section, sIndex) => (
                    <div key={sIndex} className="bg-gray-50 rounded-lg p-4">
                      <h4 className="font-semibold mb-3">{section.name}</h4>
                      <ul className="space-y-2">
                        {section.content.map((item, iIndex) => (
                          <li key={iIndex} className="flex items-center text-gray-700">
                            <ChevronRight className="h-4 w-4 text-blue-600 mr-2" />
                            {item}
                          </li>
                        ))}
                      </ul>
                    </div>
                  ))}
                </div>
              </div>
            ))}
          </div>
        </div>
      )}

      {activeView === 'compliance' && (
        <div className="bg-white rounded-lg shadow-lg p-6">
          <h2 className="text-2xl font-bold mb-4">Compliance Guide</h2>
          <p className="text-gray-600 mb-6">Coming soon...</p>
        </div>
      )}

      {activeView === 'analysis' && (
        <RegulationAnalysis />
      )}
    </div>
  );
}