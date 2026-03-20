import React, { useState } from 'react';
import { supabase } from '../lib/auth';
import { Plus, X, Award, Save, Loader2, AlertCircle, CheckCircle } from 'lucide-react';

interface ProgramForm {
  title: string;
  description: string;
  requirements: string[];
  steps: string[];
  completion_criteria: string[];
  badge: {
    name: string;
    description: string;
  } | null;
}

export default function ProgramManagement() {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState(false);
  const [formData, setFormData] = useState<ProgramForm>({
    title: '',
    description: '',
    requirements: [''],
    steps: [''],
    completion_criteria: [''],
    badge: null
  });

  const handleAddField = (field: 'requirements' | 'steps' | 'completion_criteria') => {
    setFormData(prev => ({
      ...prev,
      [field]: [...prev[field], '']
    }));
  };

  const handleRemoveField = (field: 'requirements' | 'steps' | 'completion_criteria', index: number) => {
    setFormData(prev => ({
      ...prev,
      [field]: prev[field].filter((_, i) => i !== index)
    }));
  };

  const handleFieldChange = (
    field: 'requirements' | 'steps' | 'completion_criteria',
    index: number,
    value: string
  ) => {
    setFormData(prev => ({
      ...prev,
      [field]: prev[field].map((item, i) => i === index ? value : item)
    }));
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError(null);
    setSuccess(false);

    try {
      // First create the badge if one is specified
      let badgeId: string | null = null;
      if (formData.badge) {
        const { data: badgeData, error: badgeError } = await supabase
          .from('badges')
          .insert([{
            name: formData.badge.name,
            description: formData.badge.description
          }])
          .select()
          .single();

        if (badgeError) throw badgeError;
        badgeId = badgeData.id;
      }

      // Then create the program
      const { error: programError } = await supabase
        .from('programs')
        .insert([{
          title: formData.title,
          description: formData.description,
          requirements: formData.requirements.filter(r => r.trim()),
          steps: formData.steps.filter(s => s.trim()),
          completion_criteria: formData.completion_criteria.filter(c => c.trim()),
          badge_id: badgeId
        }]);

      if (programError) throw programError;

      setSuccess(true);
      // Reset form
      setFormData({
        title: '',
        description: '',
        requirements: [''],
        steps: [''],
        completion_criteria: [''],
        badge: null
      });
    } catch (err) {
      console.error('Error creating program:', err);
      setError('Failed to create program. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="bg-white rounded-lg shadow-lg p-6">
      <h2 className="text-2xl font-bold mb-6">Create New Program</h2>

      {error && (
        <div className="mb-6 p-4 bg-red-50 text-red-700 rounded-lg flex items-center">
          <AlertCircle className="h-5 w-5 mr-2" />
          {error}
        </div>
      )}

      {success && (
        <div className="mb-6 p-4 bg-green-50 text-green-700 rounded-lg flex items-center">
          <CheckCircle className="h-5 w-5 mr-2" />
          Program created successfully!
        </div>
      )}

      <form onSubmit={handleSubmit} className="space-y-6">
        {/* Basic Information */}
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            Program Title
          </label>
          <input
            type="text"
            value={formData.title}
            onChange={(e) => setFormData(prev => ({ ...prev, title: e.target.value }))}
            className="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
            required
          />
        </div>

        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            Description
          </label>
          <textarea
            value={formData.description}
            onChange={(e) => setFormData(prev => ({ ...prev, description: e.target.value }))}
            className="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
            rows={3}
            required
          />
        </div>

        {/* Requirements */}
        <div>
          <div className="flex justify-between items-center mb-2">
            <label className="block text-sm font-medium text-gray-700">
              Requirements
            </label>
            <button
              type="button"
              onClick={() => handleAddField('requirements')}
              className="text-blue-600 hover:text-blue-700 flex items-center"
            >
              <Plus className="h-4 w-4 mr-1" />
              Add Requirement
            </button>
          </div>
          {formData.requirements.map((req, index) => (
            <div key={index} className="flex gap-2 mb-2">
              <input
                type="text"
                value={req}
                onChange={(e) => handleFieldChange('requirements', index, e.target.value)}
                className="flex-1 border rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                placeholder="Enter requirement"
                required
              />
              {formData.requirements.length > 1 && (
                <button
                  type="button"
                  onClick={() => handleRemoveField('requirements', index)}
                  className="text-red-600 hover:text-red-700 p-2"
                >
                  <X className="h-5 w-5" />
                </button>
              )}
            </div>
          ))}
        </div>

        {/* Steps */}
        <div>
          <div className="flex justify-between items-center mb-2">
            <label className="block text-sm font-medium text-gray-700">
              Program Steps
            </label>
            <button
              type="button"
              onClick={() => handleAddField('steps')}
              className="text-blue-600 hover:text-blue-700 flex items-center"
            >
              <Plus className="h-4 w-4 mr-1" />
              Add Step
            </button>
          </div>
          {formData.steps.map((step, index) => (
            <div key={index} className="flex gap-2 mb-2">
              <input
                type="text"
                value={step}
                onChange={(e) => handleFieldChange('steps', index, e.target.value)}
                className="flex-1 border rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                placeholder="Enter program step"
                required
              />
              {formData.steps.length > 1 && (
                <button
                  type="button"
                  onClick={() => handleRemoveField('steps', index)}
                  className="text-red-600 hover:text-red-700 p-2"
                >
                  <X className="h-5 w-5" />
                </button>
              )}
            </div>
          ))}
        </div>

        {/* Completion Criteria */}
        <div>
          <div className="flex justify-between items-center mb-2">
            <label className="block text-sm font-medium text-gray-700">
              Completion Criteria
            </label>
            <button
              type="button"
              onClick={() => handleAddField('completion_criteria')}
              className="text-blue-600 hover:text-blue-700 flex items-center"
            >
              <Plus className="h-4 w-4 mr-1" />
              Add Criterion
            </button>
          </div>
          {formData.completion_criteria.map((criterion, index) => (
            <div key={index} className="flex gap-2 mb-2">
              <input
                type="text"
                value={criterion}
                onChange={(e) => handleFieldChange('completion_criteria', index, e.target.value)}
                className="flex-1 border rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                placeholder="Enter completion criterion"
                required
              />
              {formData.completion_criteria.length > 1 && (
                <button
                  type="button"
                  onClick={() => handleRemoveField('completion_criteria', index)}
                  className="text-red-600 hover:text-red-700 p-2"
                >
                  <X className="h-5 w-5" />
                </button>
              )}
            </div>
          ))}
        </div>

        {/* Badge Information */}
        <div className="border-t pt-6">
          <div className="flex items-center mb-4">
            <Award className="h-5 w-5 text-blue-600 mr-2" />
            <h3 className="text-lg font-medium">Program Badge</h3>
          </div>

          {formData.badge ? (
            <div className="space-y-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Badge Name
                </label>
                <input
                  type="text"
                  value={formData.badge.name}
                  onChange={(e) => setFormData(prev => ({
                    ...prev,
                    badge: { ...prev.badge!, name: e.target.value }
                  }))}
                  className="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                  required
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Badge Description
                </label>
                <textarea
                  value={formData.badge.description}
                  onChange={(e) => setFormData(prev => ({
                    ...prev,
                    badge: { ...prev.badge!, description: e.target.value }
                  }))}
                  className="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                  rows={2}
                  required
                />
              </div>
              <button
                type="button"
                onClick={() => setFormData(prev => ({ ...prev, badge: null }))}
                className="text-red-600 hover:text-red-700"
              >
                Remove Badge
              </button>
            </div>
          ) : (
            <button
              type="button"
              onClick={() => setFormData(prev => ({
                ...prev,
                badge: { name: '', description: '' }
              }))}
              className="text-blue-600 hover:text-blue-700 flex items-center"
            >
              <Plus className="h-4 w-4 mr-1" />
              Add Program Badge
            </button>
          )}
        </div>

        <div className="pt-6 border-t">
          <button
            type="submit"
            disabled={loading}
            className="w-full bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 transition-colors disabled:opacity-50 flex items-center justify-center"
          >
            {loading ? (
              <>
                <Loader2 className="h-5 w-5 animate-spin mr-2" />
                Creating Program...
              </>
            ) : (
              <>
                <Save className="h-5 w-5 mr-2" />
                Create Program
              </>
            )}
          </button>
        </div>
      </form>
    </div>
  );
}