import React, { useState } from 'react';
import { Search, Book, HelpCircle, FileText, Phone, Mail, ExternalLink, ChevronRight, ChevronDown, Loader2 } from 'lucide-react';
import OpenAI from 'openai';

interface HelpCategory {
  title: string;
  icon: React.ReactNode;
  articles: HelpArticle[];
}

interface HelpArticle {
  id: string;
  title: string;
  content: string;
  tags: string[];
}

export default function HelpCenter() {
  const [searchQuery, setSearchQuery] = useState('');
  const [expandedCategory, setExpandedCategory] = useState<string | null>(null);
  const [selectedArticle, setSelectedArticle] = useState<HelpArticle | null>(null);
  const [isCallingAI, setIsCallingAI] = useState(false);
  const [callStatus, setCallStatus] = useState<'idle' | 'connecting' | 'connected' | 'error'>('idle');

  const helpCategories: HelpCategory[] = [
    {
      title: 'Getting Started',
      icon: <Book className="h-5 w-5" />,
      articles: [
        {
          id: 'gs-1',
          title: 'How to Navigate the Justice Portal',
          content: `The Justice Portal provides easy access to court services and legal resources. Here's how to get started:
          
          1. Create an Account: Sign up using your email address
          2. Browse Services: Explore available court services and resources
          3. Access Forms: Find and complete necessary legal forms
          4. Track Cases: Monitor your case status and upcoming court dates
          5. Get Help: Contact support or use our chat assistance for help`,
          tags: ['navigation', 'basics', 'introduction']
        },
        {
          id: 'gs-2',
          title: 'Understanding Court Procedures',
          content: `Learn about basic court procedures and what to expect:
          
          • Types of Courts and Their Functions
          • Filing Documents with the Court
          • Court Appearances and Etiquette
          • Legal Deadlines and Timelines
          • Working with Court Staff`,
          tags: ['procedures', 'courts', 'basics']
        }
      ]
    },
    {
      title: 'Forms & Documents',
      icon: <FileText className="h-5 w-5" />,
      articles: [
        {
          id: 'fd-1',
          title: 'Guide to Legal Forms',
          content: `Find and complete the right legal forms:
          
          1. Search for Forms: Use the form finder tool
          2. Fill Out Forms: Complete all required fields
          3. Review: Check for accuracy and completeness
          4. Submit: File forms with the appropriate court
          5. Track: Monitor the status of your submissions`,
          tags: ['forms', 'documents', 'filing']
        },
        {
          id: 'fd-2',
          title: 'Document Requirements',
          content: `Ensure your documents meet court requirements:
          
          • Proper Formatting
          • Required Information
          • Signature Requirements
          • Supporting Documentation
          • Filing Fees and Fee Waivers`,
          tags: ['requirements', 'documents', 'guidelines']
        }
      ]
    },
    {
      title: 'Court Services',
      icon: <HelpCircle className="h-5 w-5" />,
      articles: [
        {
          id: 'cs-1',
          title: 'Available Court Services',
          content: `Explore the range of services available:
          
          • Case Filing and Management
          • Document Retrieval
          • Court Calendar Access
          • Payment Processing
          • Legal Research Resources`,
          tags: ['services', 'court', 'assistance']
        },
        {
          id: 'cs-2',
          title: 'Remote Court Services',
          content: `Access court services remotely:
          
          1. Virtual Hearings
          2. Online Document Filing
          3. Remote Payment Options
          4. Digital Case Access
          5. Virtual Consultations`,
          tags: ['remote', 'virtual', 'online']
        }
      ]
    }
  ];

  const filteredCategories = helpCategories.map(category => ({
    ...category,
    articles: category.articles.filter(article =>
      article.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
      article.content.toLowerCase().includes(searchQuery.toLowerCase()) ||
      article.tags.some(tag => tag.toLowerCase().includes(searchQuery.toLowerCase()))
    )
  })).filter(category => category.articles.length > 0);

  const initiateAICall = async () => {
    setIsCallingAI(true);
    setCallStatus('connecting');

    try {
      const openai = new OpenAI({
        apiKey: import.meta.env.VITE_OPENAI_API_KEY,
        dangerouslyAllowBrowser: true
      });

      // Initialize OpenAI Phone Service call
      const call = await openai.phone.calls.create({
        purpose: 'customer_support',
        recipient_phone_number: '+1234567890', // User's phone number would be collected here
        expected_duration_seconds: 300, // 5 minutes
        agent_name: 'Justice Portal Assistant',
        agent_role: 'Legal Support Specialist',
        initial_message: "Hello, I'm your Justice Portal Assistant. How can I help you today?",
        language: 'en-US'
      });

      setCallStatus('connected');

      // Monitor call status
      const interval = setInterval(async () => {
        const status = await openai.phone.calls.retrieve(call.id);
        if (status.status === 'completed' || status.status === 'failed') {
          clearInterval(interval);
          setCallStatus('idle');
          setIsCallingAI(false);
        }
      }, 5000);

    } catch (error) {
      console.error('AI Call Error:', error);
      setCallStatus('error');
      setIsCallingAI(false);
    }
  };

  return (
    <div className="bg-white rounded-lg shadow-lg">
      {/* Search Bar */}
      <div className="p-6 border-b">
        <div className="relative">
          <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400 h-5 w-5" />
          <input
            type="text"
            placeholder="Search help articles..."
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            className="w-full pl-10 pr-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
          />
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-0">
        {/* Categories and Articles List */}
        <div className="md:col-span-1 border-r">
          <div className="p-4">
            <h2 className="text-lg font-bold mb-4">Help Topics</h2>
            <div className="space-y-2">
              {filteredCategories.map((category) => (
                <div key={category.title} className="border rounded-lg">
                  <button
                    onClick={() => setExpandedCategory(
                      expandedCategory === category.title ? null : category.title
                    )}
                    className="w-full px-4 py-3 flex items-center justify-between hover:bg-gray-50 transition-colors"
                  >
                    <div className="flex items-center space-x-3">
                      {category.icon}
                      <span className="font-medium">{category.title}</span>
                    </div>
                    {expandedCategory === category.title ? (
                      <ChevronDown className="h-5 w-5 text-gray-400" />
                    ) : (
                      <ChevronRight className="h-5 w-5 text-gray-400" />
                    )}
                  </button>
                  
                  {expandedCategory === category.title && (
                    <div className="border-t">
                      {category.articles.map((article) => (
                        <button
                          key={article.id}
                          onClick={() => setSelectedArticle(article)}
                          className={`w-full px-4 py-2 text-left hover:bg-gray-50 transition-colors ${
                            selectedArticle?.id === article.id ? 'bg-blue-50' : ''
                          }`}
                        >
                          {article.title}
                        </button>
                      ))}
                    </div>
                  )}
                </div>
              ))}
            </div>
          </div>
        </div>

        {/* Article Content */}
        <div className="md:col-span-2 p-6">
          {selectedArticle ? (
            <div>
              <h2 className="text-2xl font-bold mb-4">{selectedArticle.title}</h2>
              <div className="prose max-w-none">
                {selectedArticle.content.split('\n').map((paragraph, index) => (
                  <p key={index} className="mb-4">{paragraph}</p>
                ))}
              </div>
              <div className="mt-6 pt-6 border-t">
                <div className="flex flex-wrap gap-2">
                  {selectedArticle.tags.map((tag) => (
                    <span
                      key={tag}
                      className="px-2 py-1 bg-gray-100 text-gray-600 text-sm rounded-full"
                    >
                      {tag}
                    </span>
                  ))}
                </div>
              </div>
            </div>
          ) : (
            <div className="text-center py-12">
              <HelpCircle className="h-12 w-12 text-gray-400 mx-auto mb-4" />
              <h3 className="text-lg font-medium text-gray-900">Select an Article</h3>
              <p className="mt-2 text-gray-500">
                Choose a help article from the list to view its content
              </p>
            </div>
          )}
        </div>
      </div>

      {/* Contact Support */}
      <div className="border-t p-6 bg-gray-50">
        <div className="flex flex-col md:flex-row items-center justify-between">
          <div className="flex items-center space-x-4">
            <Phone className="h-5 w-5 text-blue-600" />
            <div>
              <p className="font-medium">Need more help?</p>
              <p className="text-gray-600">Contact our support team</p>
            </div>
          </div>
          <div className="flex space-x-4 mt-4 md:mt-0">
            <a
              href="mailto:support@justice-portal.gov"
              className="inline-flex items-center px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors"
            >
              <Mail className="h-5 w-5 mr-2" />
              Email Support
            </a>
            <button
              onClick={initiateAICall}
              disabled={isCallingAI}
              className={`inline-flex items-center px-4 py-2 rounded-lg transition-colors ${
                isCallingAI 
                  ? 'bg-gray-400 cursor-not-allowed' 
                  : 'bg-blue-600 hover:bg-blue-700'
              } text-white`}
            >
              {isCallingAI ? (
                <>
                  <Loader2 className="h-5 w-5 mr-2 animate-spin" />
                  {callStatus === 'connecting' ? 'Connecting...' : 'On Call'}
                </>
              ) : (
                <>
                  <Phone className="h-5 w-5 mr-2" />
                  AI Phone Support
                </>
              )}
            </button>
          </div>
        </div>
        {callStatus === 'error' && (
          <div className="mt-4 p-4 bg-red-50 text-red-700 rounded-lg">
            Failed to connect to AI Phone Support. Please try again later.
          </div>
        )}
      </div>
    </div>
  );
}