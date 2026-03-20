import React, { useState, useMemo } from 'react';
import { Search, FileText, Download, Tag, ArrowRight, SortAsc, Filter, Loader2 } from 'lucide-react';
import { downloadForm } from '../lib/supabase';

interface LegalForm {
  id: string;
  title: string;
  category: string;
  description: string;
  tags: string[];
  citation?: string;
  dateUpdated: string;
  popularity: number;
}

type SortOption = 'alphabetical' | 'recent' | 'popular';

const categories = [
  'Civil Procedure',
  'Criminal Law',
  'Family Law',
  'Probate',
  'Small Claims',
  'Traffic',
  'Bankruptcy',
  'Real Estate',
  'Employment',
  'Immigration'
];

const allTags = [
  'Complaint',
  'Motion',
  'Petition',
  'Response',
  'Appeal',
  'Discovery',
  'Emergency',
  'Financial',
  'Domestic',
  'Property',
  'Contract',
  'Employment',
  'Immigration',
  'Criminal',
  'Administrative'
];

const legalForms: LegalForm[] = [
  // Civil Procedure Forms
  {
    id: 'civil-complaint',
    title: 'Civil Complaint Form',
    category: 'Civil Procedure',
    description: 'Standard form for filing a civil complaint in court',
    tags: ['Complaint', 'Civil'],
    citation: 'Fed. R. Civ. P. 3',
    dateUpdated: '2024-03-15',
    popularity: 95
  },
  {
    id: 'motion-dismiss',
    title: 'Motion to Dismiss',
    category: 'Civil Procedure',
    description: 'Motion to dismiss a case under FRCP 12(b)',
    tags: ['Motion', 'Civil'],
    citation: 'Fed. R. Civ. P. 12(b)',
    dateUpdated: '2024-03-08',
    popularity: 85
  },
  {
    id: 'discovery-request',
    title: 'Discovery Request Package',
    category: 'Civil Procedure',
    description: 'Complete package for requesting documents, interrogatories, and admissions',
    tags: ['Discovery', 'Civil'],
    citation: 'Fed. R. Civ. P. 26-37',
    dateUpdated: '2024-03-01',
    popularity: 82
  },

  // Family Law Forms
  {
    id: 'divorce-petition',
    title: 'Divorce Petition',
    category: 'Family Law',
    description: 'Petition to initiate divorce proceedings',
    tags: ['Petition', 'Family', 'Domestic'],
    dateUpdated: '2024-03-10',
    popularity: 88
  },
  {
    id: 'child-custody',
    title: 'Child Custody Agreement',
    category: 'Family Law',
    description: 'Template for establishing child custody arrangements',
    tags: ['Family', 'Domestic', 'Contract'],
    dateUpdated: '2024-03-05',
    popularity: 90
  },
  {
    id: 'child-support',
    title: 'Child Support Calculation Worksheet',
    category: 'Family Law',
    description: 'Official worksheet for calculating child support payments',
    tags: ['Family', 'Financial', 'Domestic'],
    dateUpdated: '2024-02-28',
    popularity: 87
  },

  // Small Claims Forms
  {
    id: 'small-claims',
    title: 'Small Claims Complaint',
    category: 'Small Claims',
    description: 'Form to file a small claims court case',
    tags: ['Complaint', 'Small Claims'],
    dateUpdated: '2024-03-12',
    popularity: 92
  },
  {
    id: 'small-claims-answer',
    title: 'Small Claims Answer',
    category: 'Small Claims',
    description: 'Response form for small claims complaints',
    tags: ['Response', 'Small Claims'],
    dateUpdated: '2024-03-11',
    popularity: 86
  },

  // Criminal Law Forms
  {
    id: 'criminal-appeal',
    title: 'Criminal Appeal Notice',
    category: 'Criminal Law',
    description: 'Notice of appeal for criminal convictions',
    tags: ['Appeal', 'Criminal'],
    citation: 'Fed. R. App. P. 4(b)',
    dateUpdated: '2024-03-14',
    popularity: 78
  },
  {
    id: 'expungement',
    title: 'Expungement Petition',
    category: 'Criminal Law',
    description: 'Petition to expunge criminal records',
    tags: ['Petition', 'Criminal'],
    dateUpdated: '2024-03-09',
    popularity: 83
  },

  // Probate Forms
  {
    id: 'probate-will',
    title: 'Will Probate Petition',
    category: 'Probate',
    description: 'Petition to probate a last will and testament',
    tags: ['Petition', 'Probate'],
    dateUpdated: '2024-03-07',
    popularity: 75
  },
  {
    id: 'estate-inventory',
    title: 'Estate Inventory Form',
    category: 'Probate',
    description: 'Detailed inventory of estate assets and liabilities',
    tags: ['Financial', 'Probate'],
    dateUpdated: '2024-03-04',
    popularity: 72
  },

  // Bankruptcy Forms
  {
    id: 'bankruptcy-petition',
    title: 'Bankruptcy Petition (Chapter 7)',
    category: 'Bankruptcy',
    description: 'Primary petition for Chapter 7 bankruptcy filing',
    tags: ['Petition', 'Financial', 'Bankruptcy'],
    citation: '11 U.S.C. § 701',
    dateUpdated: '2024-03-13',
    popularity: 89
  },
  {
    id: 'means-test',
    title: 'Means Test Calculation',
    category: 'Bankruptcy',
    description: 'Required form for determining Chapter 7 eligibility',
    tags: ['Financial', 'Bankruptcy'],
    citation: '11 U.S.C. § 707(b)',
    dateUpdated: '2024-03-06',
    popularity: 84
  },

  // Real Estate Forms
  {
    id: 'eviction-notice',
    title: 'Eviction Notice',
    category: 'Real Estate',
    description: 'Notice to vacate property for tenants',
    tags: ['Property', 'Contract'],
    dateUpdated: '2024-03-03',
    popularity: 88
  },
  {
    id: 'lease-agreement',
    title: 'Residential Lease Agreement',
    category: 'Real Estate',
    description: 'Standard residential property lease contract',
    tags: ['Property', 'Contract'],
    dateUpdated: '2024-02-29',
    popularity: 91
  },

  // Employment Forms
  {
    id: 'discrimination-complaint',
    title: 'Employment Discrimination Complaint',
    category: 'Employment',
    description: 'EEOC complaint form for workplace discrimination',
    tags: ['Complaint', 'Employment'],
    citation: '42 U.S.C. § 2000e-5',
    dateUpdated: '2024-03-02',
    popularity: 81
  },
  {
    id: 'wage-claim',
    title: 'Wage Claim Form',
    category: 'Employment',
    description: 'Form for filing unpaid wage claims',
    tags: ['Complaint', 'Employment', 'Financial'],
    dateUpdated: '2024-02-27',
    popularity: 79
  },

  // Immigration Forms
  {
    id: 'naturalization',
    title: 'Naturalization Application',
    category: 'Immigration',
    description: 'Application for U.S. citizenship',
    tags: ['Immigration', 'Administrative'],
    citation: '8 U.S.C. § 1427',
    dateUpdated: '2024-03-16',
    popularity: 94
  },
  {
    id: 'visa-petition',
    title: 'Family-Based Visa Petition',
    category: 'Immigration',
    description: 'Petition for family member immigration',
    tags: ['Immigration', 'Petition', 'Family'],
    citation: '8 U.S.C. § 1153',
    dateUpdated: '2024-03-17',
    popularity: 93
  }
];

export default function LegalFormsBrowser() {
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedCategory, setSelectedCategory] = useState<string>('');
  const [selectedTags, setSelectedTags] = useState<string[]>([]);
  const [sortBy, setSortBy] = useState<SortOption>('alphabetical');
  const [downloading, setDownloading] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);

  const toggleTag = (tag: string) => {
    setSelectedTags(prev =>
      prev.includes(tag)
        ? prev.filter(t => t !== tag)
        : [...prev, tag]
    );
  };

  const filteredForms = useMemo(() => {
    return legalForms
      .filter(form => {
        const matchesSearch = searchQuery === '' ||
          form.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
          form.description.toLowerCase().includes(searchQuery.toLowerCase());

        const matchesCategory = selectedCategory === '' ||
          form.category === selectedCategory;

        const matchesTags = selectedTags.length === 0 ||
          selectedTags.every(tag => form.tags.includes(tag));

        return matchesSearch && matchesCategory && matchesTags;
      })
      .sort((a, b) => {
        switch (sortBy) {
          case 'recent':
            return new Date(b.dateUpdated).getTime() - new Date(a.dateUpdated).getTime();
          case 'popular':
            return b.popularity - a.popularity;
          default:
            return a.title.localeCompare(b.title);
        }
      });
  }, [searchQuery, selectedCategory, selectedTags, sortBy]);

  const handleDownload = async (formId: string) => {
    setDownloading(formId);
    setError(null);
    try {
      const url = await downloadForm(formId);
      
      // Create a temporary link and trigger download
      const link = document.createElement('a');
      link.href = url;
      link.download = `${formId}.pdf`;
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
      
      // Clean up the temporary URL
      URL.revokeObjectURL(url);
    } catch (err) {
      setError('Failed to download form. Please try again later.');
      console.error('Download error:', err);
    } finally {
      setDownloading(null);
    }
  };

  return (
    <div className="bg-white rounded-lg shadow-lg p-6">
      {/* Search and Filters */}
      <div className="mb-6 space-y-4">
        <div className="relative">
          <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400 h-5 w-5" />
          <input
            type="text"
            placeholder="Search forms..."
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            className="w-full pl-10 pr-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
          />
        </div>

        <div className="flex flex-wrap gap-4">
          <select
            value={selectedCategory}
            onChange={(e) => setSelectedCategory(e.target.value)}
            className="border rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
          >
            <option value="">All Categories</option>
            {categories.map(category => (
              <option key={category} value={category}>{category}</option>
            ))}
          </select>

          <select
            value={sortBy}
            onChange={(e) => setSortBy(e.target.value as SortOption)}
            className="border rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
          >
            <option value="alphabetical">Sort: A-Z</option>
            <option value="recent">Sort: Most Recent</option>
            <option value="popular">Sort: Most Popular</option>
          </select>
        </div>

        <div className="flex flex-wrap gap-2">
          {allTags.map(tag => (
            <button
              key={tag}
              onClick={() => toggleTag(tag)}
              className={`inline-flex items-center px-3 py-1 rounded-full text-sm font-medium transition-colors duration-200 ${
                selectedTags.includes(tag)
                  ? 'bg-blue-600 text-white'
                  : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
              }`}
            >
              <Tag className="h-3 w-3 mr-1" />
              {tag}
            </button>
          ))}
        </div>
      </div>

      {error && (
        <div className="mb-4 p-4 bg-red-50 text-red-700 rounded-lg">
          {error}
        </div>
      )}

      {/* Forms Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        {filteredForms.map(form => (
          <div key={form.id} className="border rounded-lg p-4 hover:shadow-md transition-shadow">
            <div className="flex items-start justify-between">
              <div className="flex-1">
                <h3 className="font-bold text-lg mb-2 flex items-center">
                  <FileText className="h-5 w-5 text-blue-600 mr-2" />
                  {form.title}
                </h3>
                <p className="text-blue-600 text-sm mb-2">{form.category}</p>
                <p className="text-gray-600 mb-3">{form.description}</p>
                {form.citation && (
                  <p className="text-sm text-gray-500 mb-3">Citation: {form.citation}</p>
                )}
                <div className="flex flex-wrap gap-2 mb-4">
                  {form.tags.map(tag => (
                    <span
                      key={tag}
                      className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800"
                    >
                      <Tag className="h-3 w-3 mr-1" />
                      {tag}
                    </span>
                  ))}
                </div>
                <p className="text-sm text-gray-500">
                  Updated: {new Date(form.dateUpdated).toLocaleDateString()}
                </p>
              </div>
            </div>
            <div className="flex justify-between items-center mt-4 pt-4 border-t">
              <button className="text-blue-600 hover:text-blue-700 flex items-center">
                Preview Form
                <ArrowRight className="h-4 w-4 ml-1" />
              </button>
              <button
                onClick={() => handleDownload(form.id)}
                disabled={downloading === form.id}
                className="flex items-center text-green-600 hover:text-green-700 disabled:opacity-50 disabled:cursor-not-allowed"
              >
                {downloading === form.id ? (
                  <>
                    <Loader2 className="h-4 w-4 mr-1 animate-spin" />
                    Downloading...
                  </>
                ) : (
                  <>
                    <Download className="h-4 w-4 mr-1" />
                    Download
                  </>
                )}
              </button>
            </div>
          </div>
        ))}
      </div>

      {filteredForms.length === 0 && (
        <div className="text-center py-8">
          <p className="text-gray-500">No forms found matching your search criteria.</p>
        </div>
      )}
    </div>
  );
}