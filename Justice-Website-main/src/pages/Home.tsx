import React from 'react';
import { Link } from 'react-router-dom';
import { Scale, Gavel, Users, FileText, BookOpen, HelpCircle, ArrowRight, Briefcase, Scroll } from 'lucide-react';

export default function Home() {
  return (
    <div>
      {/* Hero Section */}
      <div 
        className="relative h-[60vh] bg-cover bg-center"
        style={{
          backgroundImage: 'url("https://images.unsplash.com/photo-1589829545856-d10d557cf95f?auto=format&fit=crop&q=80")'
        }}
      >
        <div className="absolute inset-0 bg-black bg-opacity-50" />
        <div className="relative container mx-auto px-4 h-full flex items-center">
          <div className="text-white max-w-2xl">
            <h1 className="text-5xl font-bold mb-4">Justice For All</h1>
            <p className="text-xl mb-8">Access to justice is a fundamental right. We're here to serve and protect.</p>
            <Link
              to="/self-service"
              className="bg-blue-600 text-white px-8 py-3 rounded-lg text-lg font-semibold hover:bg-blue-700 transition"
            >
              Get Started
            </Link>
          </div>
        </div>
      </div>

      {/* Features Section */}
      <div className="py-16 bg-white">
        <div className="container mx-auto px-4">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
            <div className="text-center p-6">
              <Scale className="h-12 w-12 mx-auto mb-4 text-blue-600" />
              <h3 className="text-xl font-bold mb-2">Equal Justice</h3>
              <p className="text-gray-600">Justice served without prejudice or favor</p>
            </div>
            <div className="text-center p-6">
              <Gavel className="h-12 w-12 mx-auto mb-4 text-blue-600" />
              <h3 className="text-xl font-bold mb-2">Court Services</h3>
              <p className="text-gray-600">Efficient and accessible court proceedings</p>
            </div>
            <div className="text-center p-6">
              <Users className="h-12 w-12 mx-auto mb-4 text-blue-600" />
              <h3 className="text-xl font-bold mb-2">Community Focus</h3>
              <p className="text-gray-600">Serving the needs of our community</p>
            </div>
            <div className="text-center p-6">
              <FileText className="h-12 w-12 mx-auto mb-4 text-blue-600" />
              <h3 className="text-xl font-bold mb-2">Online Services</h3>
              <p className="text-gray-600">Digital access to justice services</p>
            </div>
          </div>
        </div>
      </div>

      {/* Your Day in Court Section */}
      <div className="py-16 bg-gray-50">
        <div className="container mx-auto px-4">
          <div className="max-w-4xl mx-auto">
            <div className="text-center mb-12">
              <Briefcase className="h-12 w-12 mx-auto mb-4 text-blue-600" />
              <h2 className="text-3xl font-bold mb-4">Your Day in Court</h2>
              <p className="text-gray-600">Essential information to help you prepare for and navigate your court appearance</p>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-8 mb-12">
              {/* Overview */}
              <div className="bg-white p-6 rounded-lg shadow-lg">
                <h3 className="text-xl font-bold mb-4 flex items-center">
                  <BookOpen className="h-6 w-6 text-blue-600 mr-2" />
                  Overview
                </h3>
                <ul className="space-y-3 text-gray-600">
                  <li className="flex items-start">
                    <ArrowRight className="h-5 w-5 text-blue-600 mr-2 flex-shrink-0 mt-0.5" />
                    Arrive at least 30 minutes early
                  </li>
                  <li className="flex items-start">
                    <ArrowRight className="h-5 w-5 text-blue-600 mr-2 flex-shrink-0 mt-0.5" />
                    Dress professionally and conservatively
                  </li>
                  <li className="flex items-start">
                    <ArrowRight className="h-5 w-5 text-blue-600 mr-2 flex-shrink-0 mt-0.5" />
                    Bring all required documents
                  </li>
                  <li className="flex items-start">
                    <ArrowRight className="h-5 w-5 text-blue-600 mr-2 flex-shrink-0 mt-0.5" />
                    Yes, but it must be silenced
                  </li>
                </ul>
              </div>

              {/* Your Rights */}
              <div className="bg-white p-6 rounded-lg shadow-lg">
                <h3 className="text-xl font-bold mb-4 flex items-center">
                  <Scale className="h-6 w-6 text-blue-600 mr-2" />
                  Your Rights
                </h3>
                <ul className="space-y-3 text-gray-600">
                  <li className="flex items-start">
                    <ArrowRight className="h-5 w-5 text-blue-600 mr-2 flex-shrink-0 mt-0.5" />
                    Right to be heard by the court
                  </li>
                  <li className="flex items-start">
                    <ArrowRight className="h-5 w-5 text-blue-600 mr-2 flex-shrink-0 mt-0.5" />
                    Right to present evidence
                  </li>
                  <li className="flex items-start">
                    <ArrowRight className="h-5 w-5 text-blue-600 mr-2 flex-shrink-0 mt-0.5" />
                    Right to legal representation
                  </li>
                  <li className="flex items-start">
                    <ArrowRight className="h-5 w-5 text-blue-600 mr-2 flex-shrink-0 mt-0.5" />
                    Right to appeal decisions
                  </li>
                </ul>
              </div>

              {/* Preparing for Trial */}
              <div className="bg-white p-6 rounded-lg shadow-lg">
                <h3 className="text-xl font-bold mb-4 flex items-center">
                  <Scroll className="h-6 w-6 text-blue-600 mr-2" />
                  Preparing for Trial
                </h3>
                <ul className="space-y-3 text-gray-600">
                  <li className="flex items-start">
                    <ArrowRight className="h-5 w-5 text-blue-600 mr-2 flex-shrink-0 mt-0.5" />
                    Organize all documents chronologically
                  </li>
                  <li className="flex items-start">
                    <ArrowRight className="h-5 w-5 text-blue-600 mr-2 flex-shrink-0 mt-0.5" />
                    Prepare witness statements
                  </li>
                  <li className="flex items-start">
                    <ArrowRight className="h-5 w-5 text-blue-600 mr-2 flex-shrink-0 mt-0.5" />
                    Review court procedures
                  </li>
                  <li className="flex items-start">
                    <ArrowRight className="h-5 w-5 text-blue-600 mr-2 flex-shrink-0 mt-0.5" />
                    Practice your presentation
                  </li>
                </ul>
              </div>

              {/* Presenting Your Case */}
              <div className="bg-white p-6 rounded-lg shadow-lg">
                <h3 className="text-xl font-bold mb-4 flex items-center">
                  <Gavel className="h-6 w-6 text-blue-600 mr-2" />
                  Presenting Your Case
                </h3>
                <ul className="space-y-3 text-gray-600">
                  <li className="flex items-start">
                    <ArrowRight className="h-5 w-5 text-blue-600 mr-2 flex-shrink-0 mt-0.5" />
                    Speak clearly and respectfully
                  </li>
                  <li className="flex items-start">
                    <ArrowRight className="h-5 w-5 text-blue-600 mr-2 flex-shrink-0 mt-0.5" />
                    Present evidence systematically
                  </li>
                  <li className="flex items-start">
                    <ArrowRight className="h-5 w-5 text-blue-600 mr-2 flex-shrink-0 mt-0.5" />
                    Listen carefully to questions
                  </li>
                  <li className="flex items-start">
                    <ArrowRight className="h-5 w-5 text-blue-600 mr-2 flex-shrink-0 mt-0.5" />
                    Stay focused on relevant facts
                  </li>
                </ul>
              </div>
            </div>

            {/* Common Terms and FAQ */}
            <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
              {/* Common Terms */}
              <div className="bg-white p-6 rounded-lg shadow-lg">
                <h3 className="text-xl font-bold mb-4">Common Terms</h3>
                <dl className="space-y-4">
                  <div>
                    <dt className="font-semibold text-blue-600">Plaintiff</dt>
                    <dd className="text-gray-600">The party who initiates a lawsuit</dd>
                  </div>
                  <div>
                    <dt className="font-semibold text-blue-600">Defendant</dt>
                    <dd className="text-gray-600">The party being sued or accused</dd>
                  </div>
                  <div>
                    <dt className="font-semibold text-blue-600">Motion</dt>
                    <dd className="text-gray-600">A formal request to the court</dd>
                  </div>
                  <div>
                    <dt className="font-semibold text-blue-600">Testimony</dt>
                    <dd className="text-gray-600">Spoken evidence given under oath</dd>
                  </div>
                </dl>
              </div>

              {/* FAQ */}
              <div className="bg-white p-6 rounded-lg shadow-lg">
                <h3 className="text-xl font-bold mb-4 flex items-center">
                  <HelpCircle className="h-6 w-6 text-blue-600 mr-2" />
                  Frequently Asked Questions
                </h3>
                <div className="space-y-4">
                  <div>
                    <h4 className="font-semibold text-blue-600">What should I wear to court?</h4>
                    <p className="text-gray-600">Professional, conservative attire is recommended. Avoid casual clothing.</p>
                  </div>
                  <div>
                    <h4 className="font-semibold text-blue-600">Can I bring my phone?</h4>
                    <p className="text-gray-600">Yes, but it must be silenced.</p>
                  </div>
                  <div>
                    <h4 className="font-semibold text-blue-600">What if I'm running late?</h4>
                    <p className="text-gray-600">Contact the court immediately if you'll be late. Tardiness may affect your case.</p>
                  </div>
                </div>
              </div>
            </div>

            <div className="mt-8 text-center">
              <Link
                to="/help"
                className="inline-flex items-center text-blue-600 hover:text-blue-700"
              >
                Need more help?
                <ArrowRight className="h-5 w-5 ml-1" />
              </Link>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}