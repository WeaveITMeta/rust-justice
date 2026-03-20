import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useCourt } from '../context/CourtContext';
import { 
  Dice1 as License, 
  Clock, 
  DollarSign, 
  CheckCircle, 
  Building2, 
  ArrowRight,
  Upload,
  FileText,
  CreditCard,
  Calendar,
  User,
  Mail,
  Phone,
  MapPin,
  Briefcase,
  X,
  AlertCircle
} from 'lucide-react';

interface ApplicationStep {
  title: string;
  description: string;
}

interface FormData {
  personalInfo: {
    firstName: string;
    lastName: string;
    email: string;
    phone: string;
    address: string;
    city: string;
    state: string;
    zip: string;
  };
  businessInfo: {
    businessName: string;
    businessType: string;
    ein: string;
    yearsInBusiness: string;
    currentLicenses: string[];
  };
  documents: {
    identificationFile: File | null;
    businessRegistrationFile: File | null;
    insuranceFile: File | null;
    taxDocumentsFile: File | null;
  };
  payment: {
    amount: number;
    cardNumber: string;
    expiryDate: string;
    cvv: string;
    nameOnCard: string;
  };
}

export default function Licensing() {
  const { selectedCourt } = useCourt();
  const navigate = useNavigate();
  const [showApplication, setShowApplication] = useState(false);
  const [currentStep, setCurrentStep] = useState(0);
  const [error, setError] = useState<string | null>(null);
  const [formData, setFormData] = useState<FormData>({
    personalInfo: {
      firstName: '',
      lastName: '',
      email: '',
      phone: '',
      address: '',
      city: '',
      state: '',
      zip: ''
    },
    businessInfo: {
      businessName: '',
      businessType: '',
      ein: '',
      yearsInBusiness: '',
      currentLicenses: []
    },
    documents: {
      identificationFile: null,
      businessRegistrationFile: null,
      insuranceFile: null,
      taxDocumentsFile: null
    },
    payment: {
      amount: 250,
      cardNumber: '',
      expiryDate: '',
      cvv: '',
      nameOnCard: ''
    }
  });

  const applicationSteps: ApplicationStep[] = [
    {
      title: 'Personal Information',
      description: 'Provide your basic contact information'
    },
    {
      title: 'Business Details',
      description: 'Tell us about your business'
    },
    {
      title: 'Required Documents',
      description: 'Upload necessary documentation'
    },
    {
      title: 'Review & Payment',
      description: 'Review your application and submit payment'
    }
  ];

  const handleCourtSelection = () => {
    navigate('/courts');
  };

  const handleFileUpload = (field: keyof FormData['documents']) => (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      setFormData(prev => ({
        ...prev,
        documents: {
          ...prev.documents,
          [field]: file
        }
      }));
    }
  };

  const handleSubmit = async () => {
    setError(null);
    // Here you would implement the actual submission logic
    // For now, we'll just simulate a success
    try {
      await new Promise(resolve => setTimeout(resolve, 1500));
      setShowApplication(false);
      setCurrentStep(0);
      // Reset form data
      setFormData({
        personalInfo: {
          firstName: '',
          lastName: '',
          email: '',
          phone: '',
          address: '',
          city: '',
          state: '',
          zip: ''
        },
        businessInfo: {
          businessName: '',
          businessType: '',
          ein: '',
          yearsInBusiness: '',
          currentLicenses: []
        },
        documents: {
          identificationFile: null,
          businessRegistrationFile: null,
          insuranceFile: null,
          taxDocumentsFile: null
        },
        payment: {
          amount: 250,
          cardNumber: '',
          expiryDate: '',
          cvv: '',
          nameOnCard: ''
        }
      });
    } catch (err) {
      setError('Failed to submit application. Please try again.');
    }
  };

  const renderStep = () => {
    switch (currentStep) {
      case 0:
        return (
          <div className="space-y-4">
            <div className="grid grid-cols-2 gap-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">First Name</label>
                <input
                  type="text"
                  value={formData.personalInfo.firstName}
                  onChange={(e) => setFormData(prev => ({
                    ...prev,
                    personalInfo: { ...prev.personalInfo, firstName: e.target.value }
                  }))}
                  className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                  required
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Last Name</label>
                <input
                  type="text"
                  value={formData.personalInfo.lastName}
                  onChange={(e) => setFormData(prev => ({
                    ...prev,
                    personalInfo: { ...prev.personalInfo, lastName: e.target.value }
                  }))}
                  className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                  required
                />
              </div>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Email</label>
              <input
                type="email"
                value={formData.personalInfo.email}
                onChange={(e) => setFormData(prev => ({
                  ...prev,
                  personalInfo: { ...prev.personalInfo, email: e.target.value }
                }))}
                className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                required
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Phone</label>
              <input
                type="tel"
                value={formData.personalInfo.phone}
                onChange={(e) => setFormData(prev => ({
                  ...prev,
                  personalInfo: { ...prev.personalInfo, phone: e.target.value }
                }))}
                className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                required
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Address</label>
              <input
                type="text"
                value={formData.personalInfo.address}
                onChange={(e) => setFormData(prev => ({
                  ...prev,
                  personalInfo: { ...prev.personalInfo, address: e.target.value }
                }))}
                className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                required
              />
            </div>
            <div className="grid grid-cols-3 gap-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">City</label>
                <input
                  type="text"
                  value={formData.personalInfo.city}
                  onChange={(e) => setFormData(prev => ({
                    ...prev,
                    personalInfo: { ...prev.personalInfo, city: e.target.value }
                  }))}
                  className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                  required
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">State</label>
                <input
                  type="text"
                  value={formData.personalInfo.state}
                  onChange={(e) => setFormData(prev => ({
                    ...prev,
                    personalInfo: { ...prev.personalInfo, state: e.target.value }
                  }))}
                  className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                  required
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">ZIP Code</label>
                <input
                  type="text"
                  value={formData.personalInfo.zip}
                  onChange={(e) => setFormData(prev => ({
                    ...prev,
                    personalInfo: { ...prev.personalInfo, zip: e.target.value }
                  }))}
                  className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                  required
                />
              </div>
            </div>
          </div>
        );

      case 1:
        return (
          <div className="space-y-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Business Name</label>
              <input
                type="text"
                value={formData.businessInfo.businessName}
                onChange={(e) => setFormData(prev => ({
                  ...prev,
                  businessInfo: { ...prev.businessInfo, businessName: e.target.value }
                }))}
                className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                required
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Business Type</label>
              <select
                value={formData.businessInfo.businessType}
                onChange={(e) => setFormData(prev => ({
                  ...prev,
                  businessInfo: { ...prev.businessInfo, businessType: e.target.value }
                }))}
                className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                required
              >
                <option value="">Select Business Type</option>
                <option value="sole_proprietorship">Sole Proprietorship</option>
                <option value="llc">LLC</option>
                <option value="corporation">Corporation</option>
                <option value="partnership">Partnership</option>
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">EIN Number</label>
              <input
                type="text"
                value={formData.businessInfo.ein}
                onChange={(e) => setFormData(prev => ({
                  ...prev,
                  businessInfo: { ...prev.businessInfo, ein: e.target.value }
                }))}
                className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                required
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Years in Business</label>
              <input
                type="number"
                value={formData.businessInfo.yearsInBusiness}
                onChange={(e) => setFormData(prev => ({
                  ...prev,
                  businessInfo: { ...prev.businessInfo, yearsInBusiness: e.target.value }
                }))}
                className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                required
              />
            </div>
          </div>
        );

      case 2:
        return (
          <div className="space-y-6">
            <div>
              <h3 className="font-medium text-gray-900 mb-4">Required Documents</h3>
              <div className="space-y-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    Government-Issued ID
                  </label>
                  <div className="flex items-center space-x-4">
                    <label className="flex-1 flex items-center px-4 py-2 border border-gray-300 rounded-lg cursor-pointer hover:bg-gray-50">
                      <Upload className="h-5 w-5 text-gray-400 mr-2" />
                      <span className="text-sm text-gray-600">Upload ID</span>
                      <input
                        type="file"
                        className="hidden"
                        onChange={handleFileUpload('identificationFile')}
                        accept=".pdf,.jpg,.jpeg,.png"
                      />
                    </label>
                    {formData.documents.identificationFile && (
                      <span className="text-sm text-green-600 flex items-center">
                        <CheckCircle className="h-4 w-4 mr-1" />
                        Uploaded
                      </span>
                    )}
                  </div>
                </div>

                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    Business Registration
                  </label>
                  <div className="flex items-center space-x-4">
                    <label className="flex-1 flex items-center px-4 py-2 border border-gray-300 rounded-lg cursor-pointer hover:bg-gray-50">
                      <Upload className="h-5 w-5 text-gray-400 mr-2" />
                      <span className="text-sm text-gray-600">Upload Registration</span>
                      <input
                        type="file"
                        className="hidden"
                        onChange={handleFileUpload('businessRegistrationFile')}
                        accept=".pdf"
                      />
                    </label>
                    {formData.documents.businessRegistrationFile && (
                      <span className="text-sm text-green-600 flex items-center">
                        <CheckCircle className="h-4 w-4 mr-1" />
                        Uploaded
                      </span>
                    )}
                  </div>
                </div>

                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    Insurance Documentation
                  </label>
                  <div className="flex items-center space-x-4">
                    <label className="flex-1 flex items-center px-4 py-2 border border-gray-300 rounded-lg cursor-pointer hover:bg-gray-50">
                      <Upload className="h-5 w-5 text-gray-400 mr-2" />
                      <span className="text-sm text-gray-600">Upload Insurance</span>
                      <input
                        type="file"
                        className="hidden"
                        onChange={handleFileUpload('insuranceFile')}
                        accept=".pdf"
                      />
                    </label>
                    {formData.documents.insuranceFile && (
                      <span className="text-sm text-green-600 flex items-center">
                        <CheckCircle className="h-4 w-4 mr-1" />
                        Uploaded
                      </span>
                    )}
                  </div>
                </div>

                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    Tax Documents
                  </label>
                  <div className="flex items-center space-x-4">
                    <label className="flex-1 flex items-center px-4 py-2 border border-gray-300 rounded-lg cursor-pointer hover:bg-gray-50">
                      <Upload className="h-5 w-5 text-gray-400 mr-2" />
                      <span className="text-sm text-gray-600">Upload Tax Documents</span>
                      <input
                        type="file"
                        className="hidden"
                        onChange={handleFileUpload('taxDocumentsFile')}
                        accept=".pdf"
                      />
                    </label>
                    {formData.documents.taxDocumentsFile && (
                      <span className="text-sm text-green-600 flex items-center">
                        <CheckCircle className="h-4 w-4 mr-1" />
                        Uploaded
                      </span>
                    )}
                  </div>
                </div>
              </div>
            </div>
          </div>
        );

      case 3:
        return (
          <div className="space-y-6">
            <div className="bg-gray-50 p-4 rounded-lg">
              <h3 className="font-medium text-gray-900 mb-4">Application Summary</h3>
              <div className="space-y-4">
                <div>
                  <h4 className="text-sm font-medium text-gray-700">Personal Information</h4>
                  <div className="mt-2 text-sm text-gray-600">
                    <p>{formData.personalInfo.firstName} {formData.personalInfo.lastName}</p>
                    <p>{formData.personalInfo.email}</p>
                    <p>{formData.personalInfo.phone}</p>
                    <p>{formData.personalInfo.address}</p>
                    <p>{formData.personalInfo.city}, {formData.personalInfo.state} {formData.personalInfo.zip}</p>
                  </div>
                </div>
                <div>
                  <h4 className="text-sm font-medium text-gray-700">Business Information</h4>
                  <div className="mt-2 text-sm text-gray-600">
                    <p>{formData.businessInfo.businessName}</p>
                    <p>Type: {formData.businessInfo.businessType}</p>
                    <p>EIN: {formData.businessInfo.ein}</p>
                    <p>Years in Business: {formData.businessInfo.yearsInBusiness}</p>
                  </div>
                </div>
                <div>
                  <h4 className="text-sm font-medium text-gray-700">Documents</h4>
                  <div className="mt-2 space-y-1">
                    {Object.entries(formData.documents).map(([key, value]) => (
                      <div key={key} className="flex items-center text-sm">
                        <FileText className="h-4 w-4 mr-2 text-gray-400" />
                        <span className={value ? 'text-green-600' : 'text-red-600'}>
                          {key.replace(/File$/, '')}: {value ? 'Uploaded' : 'Missing'}
                        </span>
                      </div>
                    ))}
                  </div>
                </div>
              </div>
            </div>

            <div className="border-t pt-6">
              <h3 className="font-medium text-gray-900 mb-4">Payment Information</h3>
              <div className="space-y-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">Card Number</label>
                  <input
                    type="text"
                    value={formData.payment.cardNumber}
                    onChange={(e) => setFormData(prev => ({
                      ...prev,
                      payment: { ...prev.payment, cardNumber: e.target.value }
                    }))}
                    className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                    required
                  />
                </div>
                <div className="grid grid-cols-3 gap-4">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">Expiry Date</label>
                    <input
                      type="text"
                      placeholder="MM/YY"
                      value={formData.payment.expiryDate}
                      onChange={(e) => setFormData(prev => ({
                        ...prev,
                        payment: { ...prev.payment, expiryDate: e.target.value }
                      }))}
                      className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                      required
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">CVV</label>
                    <input
                      type="text"
                      value={formData.payment.cvv}
                      onChange={(e) => setFormData(prev => ({
                        ...prev,
                        payment: { ...prev.payment, cvv: e.target.value }
                      }))}
                      className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                      required
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">Amount</label>
                    <input
                      type="text"
                      value={`$${formData.payment.amount}`}
                      disabled
                      className="w-full px-3 py-2 border rounded-lg bg-gray-50"
                    />
                  </div>
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">Name on Card</label>
                  <input
                    type="text"
                    value={formData.payment.nameOnCard}
                    onChange={(e) => setFormData(prev => ({
                      ...prev,
                      payment: { ...prev.payment, nameOnCard: e.target.value }
                    }))}
                    className="w-full px-3 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500"
                    required
                  />
                </div>
              </div>
            </div>
          </div>
        );

      default:
        return null;
    }
  };

  if (!selectedCourt) {
    return (
      <div className="container mx-auto px-4 py-8">
        <div className="bg-white rounded-lg shadow-lg p-8 text-center">
          <Building2 className="h-12 w-12 text-gray-400 mx-auto mb-4" />
          <h3 className="text-lg font-medium text-gray-900 mb-2">Select a Court</h3>
          <p className="text-gray-600 mb-6">Please select a court to view available licensing services</p>
          <button
            onClick={handleCourtSelection}
            className="inline-flex items-center px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors"
          >
            Select Court
            <ArrowRight className="ml-2 h-5 w-5" />
          </button>
        </div>
      </div>
    );
  }

  return (
    <div className="container mx-auto px-4 py-8">
      {showApplication ? (
        <div className="max-w-3xl mx-auto">
          <div className="bg-white rounded-lg shadow-lg p-6">
            <div className="flex justify-between items-center mb-6">
              <h2 className="text-2xl font-bold">License Application</h2>
              <button
                onClick={() => setShowApplication(false)}
                className="text-gray-400 hover:text-gray-500"
              >
                <X className="h-6 w-6" />
              </button>
            </div>

            {error && (
              <div className="mb-6 p-4 bg-red-50 text-red-700 rounded-lg flex items-center">
                <AlertCircle className="h-5 w-5 mr-2" />
                {error}
              </div>
            )}

            <div className="mb-8">
              <div className="flex items-center justify-between mb-8">
                {applicationSteps.map((step, index) => (
                  <div
                    key={index}
                    className={`flex-1 relative ${
                      index !== applicationSteps.length - 1 ? 'after:content-[""] after:absolute after:top-4 after:w-full after:h-0.5 after:bg-gray-200' : ''
                    }`}
                  >
                    <div className="relative flex flex-col items-center">
                      <div
                        className={`w-8 h-8 rounded-full flex items-center justify-center ${
                          index === currentStep
                            ? 'bg-blue-600 text-white'
                            : index < currentStep
                            ? 'bg-green-500 text-white'
                            : 'bg-gray-200 text-gray-600'
                        }`}
                      >
                        {index < currentStep ? (
                          <CheckCircle className="h-5 w-5" />
                        ) : (
                          index + 1
                        )}
                      </div>
                      <div className="mt-2 text-center">
                        <div className="text-sm font-medium text-gray-900">
                          {step.title}
                        </div>
                        <div className="text-xs text-gray-500">
                          {step.description}
                        </div>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            </div>

            {renderStep()}

            <div className="mt-8 flex justify-between">
              <button
                onClick={() => setCurrentStep(prev => prev - 1)}
                disabled={currentStep === 0}
                className="px-4 py-2 text-gray-600 disabled:opacity-50"
              >
                Back
              </button>
              <button
                onClick={() => {
                  if (currentStep === applicationSteps.length - 1) {
                    handleSubmit();
                  } else {
                    setCurrentStep(prev => prev + 1);
                  }
                }}
                className="px-6 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors"
              >
                {currentStep === applicationSteps.length - 1 ? 'Submit Application' : 'Continue'}
              </button>
            </div>
          </div>
        </div>
      ) : (
        <>
          <div className="flex justify-between items-start mb-8">
            <div>
              <h1 className="text-4xl font-bold mb-2">Licensing Services</h1>
              <p className="text-gray-600">{selectedCourt.name}</p>
            </div>
            <div className="text-right">
              <p className="text-sm text-gray-600">{selectedCourt.address}</p>
              <p className="text-sm text-gray-600">{selectedCourt.city}</p>
            </div>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-8 mb-12">
            <div className="bg-white p-6 rounded-lg shadow">
              <License className="h-8 w-8 text-blue-600 mb-4" />
              <h2 className="text-xl font-bold mb-2">Apply for License</h2>
              <p className="text-gray-600 mb-4">Start your license application process at {selectedCourt.name}</p>
              <button 
                onClick={() => setShowApplication(true)}
                className="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 transition w-full"
              >
                Start Application
              </button>
            </div>

            <div className="bg-white p-6 rounded-lg shadow">
              <Clock className="h-8 w-8 text-blue-600 mb-4" />
              <h2 className="text-xl font-bold mb-2">Renew License</h2>
              <p className="text-gray-600 mb-4">Renew your existing licenses at {selectedCourt.name}</p>
              <button className="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 transition w-full">
                Renew Now
              </button>
            </div>

            <div className="bg-white p-6 rounded-lg shadow">
              <DollarSign className="h-8 w-8 text-blue-600 mb-4" />
              <h2 className="text-xl font-bold mb-2">Fee Calculator</h2>
              <p className="text-gray-600 mb-4">Calculate licensing fees for {selectedCourt.name}</p>
              <button className="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 transition w-full">
                Calculate Fees
              </button>
            </div>
          </div>

          <div className="bg-gray-50 p-8 rounded-lg mb-12">
            <h2 className="text-2xl font-bold mb-6">Available Licenses at {selectedCourt.name}</h2>
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
              {[
                {
                  title: "Business License",
                  description: "Apply for or renew your business license",
                  available: true
                },
                {
                  title: "Professional License",
                  description: "Licensing for professional services",
                  available: true
                },
                {
                  title: "Marriage License",
                  description: "Apply for a marriage license",
                  available: true
                },
                {
                  title: "Hunting & Fishing",
                  description: "Recreational licensing and permits",
                  available: false
                },
                {
                  title: "Contractor License",
                  description: "Construction and contractor licensing",
                  available: true
                },
                {
                  title: "Liquor License",
                  description: "Alcohol sales and service permits",
                  available: true
                }
              ].map((license, index) => (
                <div key={index} className="bg-white p-4 rounded-lg shadow flex items-start space-x-3">
                  <div className={`p-2 rounded-full ${
                    license.available ? 'bg-green-100' : 'bg-gray-100'
                  }`}>
                    <CheckCircle className={`h-6 w-6 ${
                      license.available ? 'text-green-600' : 'text-gray-400'
                    }`} />
                  </div>
                  <div>
                    <h3 className="font-bold mb-1">{license.title}</h3>
                    <p className="text-gray-600 text-sm">{license.description}</p>
                    {!license.available && (
                      <p className="text-sm text-red-600 mt-1">Not available at this location</p>
                    )}
                  </div>
                </div>
              ))}
            </div>
          </div>
        </>
      )}
    </div>
  );