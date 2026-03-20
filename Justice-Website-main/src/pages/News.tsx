import React from 'react';
import { Newspaper, Calendar, User, Tag } from 'lucide-react';

export default function News() {
  const news = [
    {
      title: "New Online Court Filing System Launched",
      date: "March 15, 2024",
      category: "Technology",
      excerpt: "The justice system introduces a new digital platform for court filing..."
    },
    {
      title: "Updates to Civil Procedure Rules",
      date: "March 12, 2024",
      category: "Legal Updates",
      excerpt: "Important changes to civil procedure rules take effect next month..."
    },
    {
      title: "Community Justice Initiative Announcement",
      date: "March 10, 2024",
      category: "Community",
      excerpt: "New program launched to improve access to justice in underserved areas..."
    }
  ];

  return (
    <div className="container mx-auto px-4 py-8">
      <h1 className="text-4xl font-bold mb-8">Latest News & Updates</h1>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-8 mb-12">
        {news.map((item, index) => (
          <div key={index} className="bg-white rounded-lg shadow-lg overflow-hidden">
            <div className="p-6">
              <div className="flex items-center space-x-2 text-sm text-gray-600 mb-3">
                <Calendar className="h-4 w-4" />
                <span>{item.date}</span>
                <Tag className="h-4 w-4 ml-2" />
                <span>{item.category}</span>
              </div>
              <h2 className="text-xl font-bold mb-3">{item.title}</h2>
              <p className="text-gray-600 mb-4">{item.excerpt}</p>
              <button className="text-blue-600 hover:text-blue-700 font-semibold">
                Read More →
              </button>
            </div>
          </div>
        ))}
      </div>

      <div className="bg-gray-50 p-8 rounded-lg">
        <div className="flex justify-between items-center mb-6">
          <h2 className="text-2xl font-bold">Press Releases</h2>
          <button className="text-blue-600 hover:text-blue-700">View All →</button>
        </div>
        <div className="space-y-6">
          {[
            "Supreme Court Announces New Term Calendar",
            "Justice System Modernization Project Update",
            "Annual Report on Court Performance Released",
            "New Judicial Appointments Announced"
          ].map((release, index) => (
            <div key={index} className="bg-white p-4 rounded-lg shadow">
              <div className="flex items-center justify-between">
                <div>
                  <h3 className="font-bold mb-1">{release}</h3>
                  <div className="flex items-center space-x-2 text-sm text-gray-600">
                    <Calendar className="h-4 w-4" />
                    <span>March {5 - index}, 2024</span>
                    <User className="h-4 w-4 ml-2" />
                    <span>Press Office</span>
                  </div>
                </div>
                <button className="text-blue-600 hover:text-blue-700">
                  Read →
                </button>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}