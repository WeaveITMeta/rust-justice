import React from 'react';
import { useNavigate } from 'react-router-dom';
import { ArrowLeft } from 'lucide-react';
import HelpCenter from '../components/HelpCenter';

export default function Help() {
  const navigate = useNavigate();

  return (
    <div className="container mx-auto px-4 py-8">
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-4xl font-bold">Help Center</h1>
        <button 
          onClick={() => navigate('/self-service')}
          className="text-blue-600 hover:text-blue-700 flex items-center"
        >
          <ArrowLeft className="h-5 w-5 mr-2" />
          Back to Service
        </button>
      </div>
      <HelpCenter />
    </div>
  );
}