import React, { useState, useEffect } from 'react';
import { supabase } from '../lib/auth';
import { Upload, Download, FileText, Trash2, Search, Filter, AlertCircle, Loader2, CheckCircle, Tag, X } from 'lucide-react';

interface Document {
  id: string;
  name: string;
  description: string;
  file_path: string;
  category: string;
  tags: string[];
  uploaded_by: string;
  uploaded_at: string;
}

export default function DocumentUploadCenter() {
  const [documents, setDocuments] = useState<Document[]>([]);
  const [loading, setLoading] = useState(true);
  const [uploading, setUploading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedCategory, setSelectedCategory] = useState<string>('');
  const [uploadSuccess, setUploadSuccess] = useState(false);
  const [selectedTags, setSelectedTags] = useState<string[]>([]);
  const [newDocumentTags, setNewDocumentTags] = useState<string[]>([]);
  const [tagInput, setTagInput] = useState('');

  const categories = [
    'Civil Forms',
    'Criminal Forms',
    'Family Law Forms',
    'Probate Forms',
    'Small Claims Forms',
    'Traffic Forms',
    'General Forms'
  ];

  const availableTags = [
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

  useEffect(() => {
    fetchDocuments();
  }, []);

  async function fetchDocuments() {
    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) throw new Error('Not authenticated');

      const { data: filesData, error: filesError } = await supabase
        .storage
        .from('legal-forms')
        .list('forms');

      if (filesError) throw filesError;

      // Get document metadata including tags
      const { data: metadataData, error: metadataError } = await supabase
        .from('document_metadata')
        .select('*');

      if (metadataError) throw metadataError;

      const formattedDocs = filesData.map(doc => {
        const metadata = metadataData?.find(m => m.file_path === `forms/${doc.name}`);
        return {
          id: doc.id,
          name: doc.name,
          description: metadata?.description || '',
          file_path: `forms/${doc.name}`,
          category: metadata?.category || 'General Forms',
          tags: metadata?.tags || [],
          uploaded_by: user.id,
          uploaded_at: doc.created_at
        };
      });

      setDocuments(formattedDocs);
    } catch (err) {
      console.error('Error fetching documents:', err);
      setError('Failed to load documents');
    } finally {
      setLoading(false);
    }
  }

  const handleFileUpload = async (event: React.ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];
    if (!file) return;

    setUploading(true);
    setError(null);
    setUploadSuccess(false);

    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) throw new Error('Not authenticated');

      // Upload file to Supabase Storage
      const { error: uploadError } = await supabase.storage
        .from('legal-forms')
        .upload(`forms/${file.name}`, file);

      if (uploadError) throw uploadError;

      // Save document metadata including tags
      const { error: metadataError } = await supabase
        .from('document_metadata')
        .insert([{
          file_path: `forms/${file.name}`,
          category: selectedCategory || 'General Forms',
          tags: newDocumentTags,
          uploaded_by: user.id
        }]);

      if (metadataError) throw metadataError;

      setUploadSuccess(true);
      setNewDocumentTags([]);
      await fetchDocuments();
    } catch (err) {
      console.error('Error uploading document:', err);
      setError('Failed to upload document');
    } finally {
      setUploading(false);
    }
  };

  const handleDelete = async (filePath: string) => {
    if (!confirm('Are you sure you want to delete this document?')) return;

    setError(null);
    try {
      // Delete file from storage
      const { error: storageError } = await supabase.storage
        .from('legal-forms')
        .remove([filePath]);

      if (storageError) throw storageError;

      // Delete metadata
      const { error: metadataError } = await supabase
        .from('document_metadata')
        .delete()
        .eq('file_path', filePath);

      if (metadataError) throw metadataError;

      await fetchDocuments();
    } catch (err) {
      console.error('Error deleting document:', err);
      setError('Failed to delete document');
    }
  };

  const handleTagSelect = (tag: string) => {
    if (!newDocumentTags.includes(tag)) {
      setNewDocumentTags([...newDocumentTags, tag]);
    }
    setTagInput('');
  };

  const handleTagRemove = (tag: string) => {
    setNewDocumentTags(newDocumentTags.filter(t => t !== tag));
  };

  const handleFilterTagToggle = (tag: string) => {
    setSelectedTags(prev =>
      prev.includes(tag)
        ? prev.filter(t => t !== tag)
        : [...prev, tag]
    );
  };

  const filteredDocuments = documents.filter(doc => {
    const matchesSearch = doc.name.toLowerCase().includes(searchQuery.toLowerCase());
    const matchesCategory = !selectedCategory || doc.category === selectedCategory;
    const matchesTags = selectedTags.length === 0 || 
      selectedTags.every(tag => doc.tags.includes(tag));
    return matchesSearch && matchesCategory && matchesTags;
  });

  return (
    <div className="bg-white rounded-lg shadow-lg p-6">
      <div className="flex justify-between items-start mb-6">
        <div>
          <h2 className="text-2xl font-bold mb-2">Document Management</h2>
          <p className="text-gray-600">Upload and manage court forms and documents</p>
        </div>
        <div>
          <label className="relative inline-flex items-center px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 cursor-pointer">
            <Upload className="h-5 w-5 mr-2" />
            Upload Document
            <input
              type="file"
              className="hidden"
              accept=".pdf,.doc,.docx"
              onChange={handleFileUpload}
              disabled={uploading}
            />
          </label>
        </div>
      </div>

      {error && (
        <div className="mb-6 p-4 bg-red-50 text-red-700 rounded-lg flex items-center">
          <AlertCircle className="h-5 w-5 mr-2" />
          {error}
        </div>
      )}

      {uploadSuccess && (
        <div className="mb-6 p-4 bg-green-50 text-green-700 rounded-lg flex items-center">
          <CheckCircle className="h-5 w-5 mr-2" />
          Document uploaded successfully!
        </div>
      )}

      {/* Upload Form Tags */}
      <div className="mb-6 p-4 bg-gray-50 rounded-lg">
        <h3 className="font-semibold mb-4">Document Tags</h3>
        <div className="flex flex-wrap gap-2 mb-4">
          {newDocumentTags.map(tag => (
            <span
              key={tag}
              className="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-blue-100 text-blue-800"
            >
              <Tag className="h-3 w-3 mr-1" />
              {tag}
              <button
                onClick={() => handleTagRemove(tag)}
                className="ml-2 hover:text-blue-600"
              >
                <X className="h-3 w-3" />
              </button>
            </span>
          ))}
        </div>
        <div className="relative">
          <input
            type="text"
            value={tagInput}
            onChange={(e) => setTagInput(e.target.value)}
            placeholder="Type to add tags..."
            className="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
          />
          {tagInput && (
            <div className="absolute z-10 w-full mt-1 bg-white border rounded-lg shadow-lg">
              {availableTags
                .filter(tag => 
                  tag.toLowerCase().includes(tagInput.toLowerCase()) &&
                  !newDocumentTags.includes(tag)
                )
                .map(tag => (
                  <button
                    key={tag}
                    onClick={() => handleTagSelect(tag)}
                    className="w-full px-4 py-2 text-left hover:bg-gray-50"
                  >
                    {tag}
                  </button>
                ))}
            </div>
          )}
        </div>
      </div>

      <div className="mb-6 space-y-4">
        <div className="flex gap-4">
          <div className="flex-1 relative">
            <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400 h-5 w-5" />
            <input
              type="text"
              placeholder="Search documents..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="w-full pl-10 pr-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
            />
          </div>
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
        </div>

        {/* Filter Tags */}
        <div className="flex flex-wrap gap-2">
          {availableTags.map(tag => (
            <button
              key={tag}
              onClick={() => handleFilterTagToggle(tag)}
              className={`inline-flex items-center px-3 py-1 rounded-full text-sm font-medium transition-colors ${
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

      {loading ? (
        <div className="flex items-center justify-center p-12">
          <Loader2 className="h-8 w-8 animate-spin text-blue-600" />
        </div>
      ) : (
        <div className="space-y-4">
          {filteredDocuments.length === 0 ? (
            <div className="text-center py-12">
              <FileText className="h-12 w-12 text-gray-400 mx-auto mb-4" />
              <p className="text-lg font-medium">No documents found</p>
              <p className="text-gray-600">Upload documents or try a different search</p>
            </div>
          ) : (
            filteredDocuments.map((doc) => (
              <div
                key={doc.id}
                className="border rounded-lg p-4 hover:shadow-md transition-shadow"
              >
                <div className="flex justify-between items-start">
                  <div className="flex items-start space-x-4">
                    <div className="p-2 bg-blue-100 rounded-lg">
                      <FileText className="h-6 w-6 text-blue-600" />
                    </div>
                    <div>
                      <h3 className="font-bold text-lg">{doc.name}</h3>
                      <p className="text-gray-600 text-sm mb-2">
                        Uploaded {new Date(doc.uploaded_at).toLocaleDateString()}
                      </p>
                      <div className="flex flex-wrap gap-2">
                        {doc.tags.map(tag => (
                          <span
                            key={tag}
                            className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800"
                          >
                            <Tag className="h-3 w-3 mr-1" />
                            {tag}
                          </span>
                        ))}
                      </div>
                    </div>
                  </div>
                  <div className="flex items-center space-x-2">
                    <button
                      onClick={() => handleDelete(doc.file_path)}
                      className="p-2 text-red-600 hover:bg-red-50 rounded-lg transition-colors"
                    >
                      <Trash2 className="h-5 w-5" />
                    </button>
                    <a
                      href={`${supabase.storage.from('legal-forms').getPublicUrl(doc.file_path).data.publicUrl}`}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="p-2 text-blue-600 hover:bg-blue-50 rounded-lg transition-colors"
                    >
                      <Download className="h-5 w-5" />
                    </a>
                  </div>
                </div>
              </div>
            ))
          )}
        </div>
      )}
    </div>
  );
}