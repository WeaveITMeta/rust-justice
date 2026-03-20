import React, { useState, useEffect } from 'react';
import { supabase } from '../lib/auth';
import { Plus, X, Save, Loader2, AlertCircle, CheckCircle, Edit, Trash2 } from 'lucide-react';

interface TestForm {
  title: string;
  description: string;
  passing_score: number;
  program_id: string;
  questions: {
    question: string;
    options: string[];
    correct_answer: string;
    explanation: string;
    points: number;
    order_number: number;
  }[];
}

export default function TestManagement() {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState(false);
  const [programs, setPrograms] = useState<{ id: string; title: string; }[]>([]);
  const [formData, setFormData] = useState<TestForm>({
    title: '',
    description: '',
    passing_score: 70,
    program_id: '',
    questions: [{
      question: '',
      options: ['', '', '', ''],
      correct_answer: '',
      explanation: '',
      points: 1,
      order_number: 1
    }]
  });

  useEffect(() => {
    fetchPrograms();
  }, []);

  async function fetchPrograms() {
    try {
      const { data, error } = await supabase
        .from('programs')
        .select('id, title')
        .eq('is_active', true);

      if (error) throw error;
      setPrograms(data || []);
    } catch (err) {
      console.error('Error fetching programs:', err);
      setError('Failed to load programs');
    }
  }

  const handleAddQuestion = () => {
    setFormData(prev => ({
      ...prev,
      questions: [
        ...prev.questions,
        {
          question: '',
          options: ['', '', '', ''],
          correct_answer: '',
          explanation: '',
          points: 1,
          order_number: prev.questions.length + 1
        }
      ]
    }));
  };

  const handleRemoveQuestion = (index: number) => {
    setFormData(prev => ({
      ...prev,
      questions: prev.questions.filter((_, i) => i !== index).map((q, i) => ({
        ...q,
        order_number: i + 1
      }))
    }));
  };

  const handleQuestionChange = (index: number, field: string, value: any) => {
    setFormData(prev => ({
      ...prev,
      questions: prev.questions.map((q, i) => 
        i === index ? { ...q, [field]: value } : q
      )
    }));
  };

  const handleOptionChange = (questionIndex: number, optionIndex: number, value: string) => {
    setFormData(prev => ({
      ...prev,
      questions: prev.questions.map((q, i) => 
        i === questionIndex ? {
          ...q,
          options: q.options.map((opt, j) => j === optionIndex ? value : opt)
        } : q
      )
    }));
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError(null);
    setSuccess(false);

    try {
      // Create the test
      const { data: testData, error: testError } = await supabase
        .from('program_tests')
        .insert([{
          title: formData.title,
          description: formData.description,
          passing_score: formData.passing_score,
          program_id: formData.program_id
        }])
        .select()
        .single();

      if (testError) throw testError;

      // Create the questions
      const { error: questionsError } = await supabase
        .from('test_questions')
        .insert(
          formData.questions.map(q => ({
            test_id: testData.id,
            question: q.question,
            options: q.options,
            correct_answer: q.correct_answer,
            explanation: q.explanation,
            points: q.points,
            order_number: q.order_number
          }))
        );

      if (questionsError) throw questionsError;

      setSuccess(true);
      // Reset form
      setFormData({
        title: '',
        description: '',
        passing_score: 70,
        program_id: '',
        questions: [{
          question: '',
          options: ['', '', '', ''],
          correct_answer: '',
          explanation: '',
          points: 1,
          order_number: 1
        }]
      });
    } catch (err) {
      console.error('Error creating test:', err);
      setError('Failed to create test. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="bg-white rounded-lg shadow-lg p-6">
      <h2 className="text-2xl font-bold mb-6">Create Program Test</h2>

      {error && (
        <div className="mb-6 p-4 bg-red-50 text-red-700 rounded-lg flex items-center">
          <AlertCircle className="h-5 w-5 mr-2" />
          {error}
        </div>
      )}

      {success && (
        <div className="mb-6 p-4 bg-green-50 text-green-700 rounded-lg flex items-center">
          <CheckCircle className="h-5 w-5 mr-2" />
          Test created successfully!
        </div>
      )}

      <form onSubmit={handleSubmit} className="space-y-6">
        {/* Basic Information */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Program
            </label>
            <select
              value={formData.program_id}
              onChange={(e) => setFormData(prev => ({ ...prev, program_id: e.target.value }))}
              className="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
              required
            >
              <option value="">Select a program...</option>
              {programs.map(program => (
                <option key={program.id} value={program.id}>
                  {program.title}
                </option>
              ))}
            </select>
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Passing Score (%)
            </label>
            <input
              type="number"
              min="0"
              max="100"
              value={formData.passing_score}
              onChange={(e) => setFormData(prev => ({ ...prev, passing_score: parseInt(e.target.value) }))}
              className="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
              required
            />
          </div>
        </div>

        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            Test Title
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

        {/* Questions */}
        <div>
          <div className="flex justify-between items-center mb-4">
            <h3 className="text-lg font-medium">Test Questions</h3>
            <button
              type="button"
              onClick={handleAddQuestion}
              className="text-blue-600 hover:text-blue-700 flex items-center"
            >
              <Plus className="h-4 w-4 mr-1" />
              Add Question
            </button>
          </div>

          {formData.questions.map((question, qIndex) => (
            <div key={qIndex} className="mb-8 p-6 border rounded-lg">
              <div className="flex justify-between items-start mb-4">
                <h4 className="font-medium">Question {qIndex + 1}</h4>
                {formData.questions.length > 1 && (
                  <button
                    type="button"
                    onClick={() => handleRemoveQuestion(qIndex)}
                    className="text-red-600 hover:text-red-700"
                  >
                    <Trash2 className="h-5 w-5" />
                  </button>
                )}
              </div>

              <div className="space-y-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">
                    Question Text
                  </label>
                  <input
                    type="text"
                    value={question.question}
                    onChange={(e) => handleQuestionChange(qIndex, 'question', e.target.value)}
                    className="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                    required
                  />
                </div>

                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">
                    Options
                  </label>
                  <div className="space-y-2">
                    {question.options.map((option, oIndex) => (
                      <div key={oIndex} className="flex items-center gap-2">
                        <input
                          type="radio"
                          name={`correct_${qIndex}`}
                          checked={question.correct_answer === option}
                          onChange={() => handleQuestionChange(qIndex, 'correct_answer', option)}
                          className="h-4 w-4 text-blue-600"
                          required
                        />
                        <input
                          type="text"
                          value={option}
                          onChange={(e) => handleOptionChange(qIndex, oIndex, e.target.value)}
                          className="flex-1 border rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                          placeholder={`Option ${oIndex + 1}`}
                          required
                        />
                      </div>
                    ))}
                  </div>
                </div>

                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">
                    Explanation
                  </label>
                  <textarea
                    value={question.explanation}
                    onChange={(e) => handleQuestionChange(qIndex, 'explanation', e.target.value)}
                    className="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                    rows={2}
                    required
                  />
                </div>

                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">
                    Points
                  </label>
                  <input
                    type="number"
                    min="1"
                    value={question.points}
                    onChange={(e) => handleQuestionChange(qIndex, 'points', parseInt(e.target.value))}
                    className="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                    required
                  />
                </div>
              </div>
            </div>
          ))}
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
                Creating Test...
              </>
            ) : (
              <>
                <Save className="h-5 w-5 mr-2" />
                Create Test
              </>
            )}
          </button>
        </div>
      </form>
    </div>
  );
}