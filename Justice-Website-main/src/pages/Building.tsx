import React, { useState } from 'react';
import { Building2, Star, Phone, Mail, Globe, MapPin, DollarSign, CheckCircle, Filter, Search, Tag } from 'lucide-react';

interface Contractor {
  id: string;
  name: string;
  type: 'national' | 'local';
  specialties: string[];
  rating: number;
  experience: number;
  location: string;
  phone: string;
  email: string;
  website: string;
  employeeCount: number;
  bondingCapacity: string;
  certifications: string[];
  completedProjects: number;
  description: string;
  imageUrl: string;
}

export default function Building() {
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedSpecialties, setSelectedSpecialties] = useState<string[]>([]);
  const [selectedCertifications, setSelectedCertifications] = useState<string[]>([]);

  const specialtyOptions = [
    'Structural',
    'Mechanical',
    'Plumbing',
    'Electrical',
    'HVAC',
    'Civil',
    'Foundation',
    'Roofing',
    'Interior Systems',
    'Fire Protection',
    'Site Work',
    'Building Envelope'
  ];

  const certificationOptions = [
    'ISO 9001',
    'ISO 14001',
    'LEED Certified',
    'Energy Star Partner',
    'WELL Certified',
    'OSHA Certified',
    'BBB A+',
    'Safety Excellence'
  ];

  const contractors: Contractor[] = [
    {
      id: '1',
      name: 'Premier Construction Solutions',
      type: 'national',
      specialties: ['Structural', 'Mechanical', 'Electrical'],
      rating: 4.8,
      experience: 25,
      location: 'Multiple Locations Nationwide',
      phone: '(800) 555-0123',
      email: 'contact@premierconstruction.com',
      website: 'https://premierconstruction.com',
      employeeCount: 1500,
      bondingCapacity: '$500M+',
      certifications: ['ISO 9001', 'LEED Certified', 'Energy Star Partner'],
      completedProjects: 750,
      description: 'Leading national construction firm specializing in structural, mechanical, and electrical systems with a focus on sustainable building practices.',
      imageUrl: 'https://images.unsplash.com/photo-1504307651254-35680f356dfd?auto=format&fit=crop&q=80'
    },
    {
      id: '2',
      name: 'Local Build Masters',
      type: 'local',
      specialties: ['Plumbing', 'HVAC', 'Fire Protection'],
      rating: 4.9,
      experience: 15,
      location: 'Phoenix, AZ',
      phone: '(602) 555-0456',
      email: 'info@localbuildmasters.com',
      website: 'https://localbuildmasters.com',
      employeeCount: 75,
      bondingCapacity: '$50M',
      certifications: ['BBB A+', 'OSHA Certified', 'Safety Excellence'],
      completedProjects: 250,
      description: 'Trusted local contractor specializing in mechanical systems including plumbing, HVAC, and fire protection installations.',
      imageUrl: 'https://images.unsplash.com/photo-1531834685032-c34bf0d84c77?auto=format&fit=crop&q=80'
    },
    {
      id: '3',
      name: 'Innovative Builders Corp',
      type: 'national',
      specialties: ['Building Envelope', 'Interior Systems', 'Civil'],
      rating: 4.7,
      experience: 30,
      location: 'Multiple Locations Nationwide',
      phone: '(877) 555-0789',
      email: 'projects@innovativebuilders.com',
      website: 'https://innovativebuilders.com',
      employeeCount: 2000,
      bondingCapacity: '$750M+',
      certifications: ['ISO 14001', 'WELL Certified', 'Safety Excellence'],
      completedProjects: 1000,
      description: 'Industry leader in building envelope systems and interior finishes with expertise in civil engineering and site work.',
      imageUrl: 'https://images.unsplash.com/photo-1541976590-713941681591?auto=format&fit=crop&q=80'
    }
  ];

  const toggleSpecialty = (specialty: string) => {
    setSelectedSpecialties(prev =>
      prev.includes(specialty)
        ? prev.filter(s => s !== specialty)
        : [...prev, specialty]
    );
  };

  const toggleCertification = (certification: string) => {
    setSelectedCertifications(prev =>
      prev.includes(certification)
        ? prev.filter(c => c !== certification)
        : [...prev, certification]
    );
  };

  const filteredContractors = contractors.filter(contractor => {
    const matchesSearch = 
      contractor.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
      contractor.description.toLowerCase().includes(searchQuery.toLowerCase()) ||
      contractor.certifications.some(cert => 
        cert.toLowerCase().includes(searchQuery.toLowerCase())
      );

    const matchesSpecialties = selectedSpecialties.length === 0 ||
      selectedSpecialties.some(s => contractor.specialties.includes(s));

    const matchesCertifications = selectedCertifications.length === 0 ||
      selectedCertifications.some(c => contractor.certifications.includes(c));

    return matchesSearch && matchesSpecialties && matchesCertifications;
  });

  return (
    <div className="container mx-auto px-4 py-8">
      <div className="flex justify-between items-start mb-8">
        <div>
          <h1 className="text-4xl font-bold mb-2">Building Services</h1>
          <p className="text-gray-600">Find qualified contractors for construction and renovation</p>
        </div>
        <div className="flex items-center space-x-2 bg-blue-50 text-blue-700 px-4 py-2 rounded-lg">
          <Building2 className="h-5 w-5" />
          <span className="font-medium">Verified Contractors</span>
        </div>
      </div>

      {/* Search and Filter Section */}
      <div className="bg-white rounded-lg shadow-lg p-6 mb-8">
        <div className="flex flex-wrap gap-4">
          <div className="flex-1">
            <div className="relative">
              <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400 h-5 w-5" />
              <input
                type="text"
                placeholder="Search contractors, specialties, or certifications..."
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                className="w-full pl-10 pr-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
              />
            </div>
          </div>
        </div>

        {/* Specialties Filter */}
        <div className="mt-4">
          <div className="flex items-center space-x-2 mb-2">
            <Filter className="h-5 w-5 text-gray-400" />
            <span className="text-gray-700 font-medium">Filter by Specialty:</span>
          </div>
          <div className="flex flex-wrap gap-2">
            {specialtyOptions.map(specialty => (
              <button
                key={specialty}
                onClick={() => toggleSpecialty(specialty)}
                className={`px-3 py-1 rounded-full text-sm font-medium transition-colors ${
                  selectedSpecialties.includes(specialty)
                    ? 'bg-blue-600 text-white'
                    : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
                }`}
              >
                {specialty}
              </button>
            ))}
          </div>
        </div>

        {/* Certifications Filter */}
        <div className="mt-4">
          <div className="flex items-center space-x-2 mb-2">
            <Tag className="h-5 w-5 text-gray-400" />
            <span className="text-gray-700 font-medium">Filter by Certification:</span>
          </div>
          <div className="flex flex-wrap gap-2">
            {certificationOptions.map(certification => (
              <button
                key={certification}
                onClick={() => toggleCertification(certification)}
                className={`px-3 py-1 rounded-full text-sm font-medium transition-colors ${
                  selectedCertifications.includes(certification)
                    ? 'bg-green-600 text-white'
                    : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
                }`}
              >
                {certification}
              </button>
            ))}
          </div>
        </div>
      </div>

      {/* Contractors Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {filteredContractors.map(contractor => (
          <div key={contractor.id} className="bg-white rounded-lg shadow-lg overflow-hidden">
            <div className="h-48 overflow-hidden">
              <img
                src={contractor.imageUrl}
                alt={contractor.name}
                className="w-full h-full object-cover"
              />
            </div>
            <div className="p-6">
              <div className="flex justify-between items-start mb-4">
                <div>
                  <h3 className="text-xl font-bold mb-2">{contractor.name}</h3>
                  <div className="flex items-center text-yellow-500 mb-2">
                    <Star className="h-5 w-5 fill-current" />
                    <span className="ml-1 text-gray-600">{contractor.rating.toFixed(1)}</span>
                  </div>
                </div>
                <span className={`px-3 py-1 rounded-full text-sm font-medium ${
                  contractor.type === 'national'
                    ? 'bg-blue-100 text-blue-800'
                    : 'bg-green-100 text-green-800'
                }`}>
                  {contractor.type === 'national' ? 'National' : 'Local'}
                </span>
              </div>

              <p className="text-gray-600 mb-4">{contractor.description}</p>

              <div className="space-y-2 mb-4">
                <div className="flex items-center text-gray-600">
                  <MapPin className="h-4 w-4 mr-2" />
                  {contractor.location}
                </div>
                <div className="flex items-center text-gray-600">
                  <Phone className="h-4 w-4 mr-2" />
                  {contractor.phone}
                </div>
                <div className="flex items-center text-gray-600">
                  <Mail className="h-4 w-4 mr-2" />
                  {contractor.email}
                </div>
                <div className="flex items-center text-gray-600">
                  <Globe className="h-4 w-4 mr-2" />
                  {contractor.website}
                </div>
              </div>

              <div className="border-t pt-4">
                <div className="grid grid-cols-2 gap-4 mb-4">
                  <div>
                    <p className="text-sm text-gray-500">Experience</p>
                    <p className="font-semibold">{contractor.experience} Years</p>
                  </div>
                  <div>
                    <p className="text-sm text-gray-500">Completed Projects</p>
                    <p className="font-semibold">{contractor.completedProjects}+</p>
                  </div>
                  <div>
                    <p className="text-sm text-gray-500">Employees</p>
                    <p className="font-semibold">{contractor.employeeCount}</p>
                  </div>
                  <div>
                    <p className="text-sm text-gray-500">Bonding Capacity</p>
                    <p className="font-semibold">{contractor.bondingCapacity}</p>
                  </div>
                </div>

                <div className="space-y-2">
                  <p className="text-sm font-medium text-gray-700">Certifications:</p>
                  <div className="flex flex-wrap gap-2">
                    {contractor.certifications.map((cert, index) => (
                      <span
                        key={index}
                        className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800"
                      >
                        <CheckCircle className="h-3 w-3 mr-1" />
                        {cert}
                      </span>
                    ))}
                  </div>
                </div>

                <div className="mt-4 flex justify-between items-center">
                  <span className="text-sm text-gray-500">
                    Specialties: {contractor.specialties.join(', ')}
                  </span>
                  <button className="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                    <DollarSign className="h-4 w-4 mr-1" />
                    Request Quote
                  </button>
                </div>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}