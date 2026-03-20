import React, { useState, useEffect } from 'react';
import { supabase } from '../lib/auth';
import { CheckCircle, AlertCircle, Loader2, ArrowRight, ArrowLeft, Award } from 'lucide-react';

interface Test {
  id: string;
  title: string;
  description: string;
  passing_score: number;
  program_id: string;
}

interface Question {
  id: string;
  question: string;
  options: string[];
  explanation: string;
  points: number;
  order_number: number;
}

interface TestResult {
  score: number;
  correct_answers: number;
  total_questions: number;
  answers: Record<string, string>;
  completed_at: string;
}

export default function TestTaking({ programId }: { programId: string }) {
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [test, setTest] = useState<Test | null>(null);
  const [questions, setQuestions] = useState<Question[]>([]);
  const [currentQuestion, setCurrentQuestion] = useState(0);
  const [answers, setAnswers] = useState<Record<string, string>>({});
  const [submitting, setSubmitting] = useState(false);
  const [result, setResult] = useState<TestResult | null>(null);
  const [previousResults, setPreviousResults] = useState<TestResult[]>([]);

  useEffect(() => {
    fetchTest();
  }, [programId]);

  async function fetchTest() {
    try {
      // Get the test for this program
      const { data: testData, error: testError } = await supabase
        .from('program_tests')
        .select('*')
        .eq('program_id', programId)
        .eq('is_active', true)
        .single();

      if (testError) throw testError;
      setTest(testData);

      // Get the questions
      const { data: questionData, error: questionError } = await supabase
        .from('test_questions')
        .select('*')
        .eq('test_id', testData.id)
        .order('order_number');

      if (questionError) throw questionError;
      setQuestions(questionData || []);

      // Get previous results
      const { data: resultData, error: resultError } = await supabase
        .from('user_test_results')
        .select('*')
        .eq('test_id', testData.id)
        .order('completed_at', { ascending: false });

      if (resultError) throw resultError;
      setPreviousResults(resultData || []);
    } catch (err) {
      console.error('Error fetching test:', err);
      setError('Failed to load test');
    } finally {
      setLoading(false);
    }
  }

  const handleAnswer = (questionId: string, answer: string) => {
    setAnswers(prev => ({
      ...prev,
      [questionId]: answer
    }));
  };

  const handleSubmit = async () => {
    if (!test) return;
    setSubmitting(true);
    setError(null);

    try {
      // Calculate score
      const { data: scoreData, error: scoreError } = await supabase.rpc(
        'calculate_test_score',
        {
          p_test_id: test.id,
          p_answers: answers
        }
      );

      if (scoreError) throw scoreError;

      const correctAnswers = Object.keys(answers).length;
      const result = {
        test_id: test.id,
        score: scoreData,
        correct_answers: correctAnswers,
        total_questions: questions.length,
        answers
      };

      // Save result
      const { error: saveError } = await supabase
        .from('user_test_results')
        .insert([result]);

      if (saveError) throw saveError;

      setResult(result as TestResult);
      await fetchTest(); // Refresh previous results
    } catch (err) {
      console.error('Error submitting test:', err);
      setError('Failed to submit test');
    } finally {
      setSubmitting(false);
    }
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center p-8">
        <Loader2 className="h-8 w-8 animate-spin text-blue-600" />
      </div>
    );
  }

  if (error) {
    return (
      <div className="p-4 bg-red-50 text-red-700 rounded-lg flex items-center">
        <AlertCircle className="h-5 w-5 mr-2" />
        {error}
      </div>
    );
  }

  if (!test || questions.length === 0) {
    return (
      <div className="text-center py-8">
        <Award className="h-12 w-12 text-gray-400 mx-auto mb-4" />
        <p className="text-lg font-medium">No test available</p>
        <p className="text-gray-600">This program doesn't have a test yet</p>
      </div>
    );
  }

  if (result) {
    const passed = result.score >= test.passing_score;
    return (
      <div className="bg-white rounded-lg shadow-lg p-6">
        <div className="text-center mb-8">
          <div className={`w-20 h-20 mx-auto mb-4 rounded-full flex items-center justify-center ${
            passed ? 'bg-green-100' : 'bg-red-100'
          }`}>
            <CheckCircle className={`h-10 w-10 ${
              passed ? 'text-green-600' : 'text-red-600'
            }`} />
          </div>
          <h2 className="text-2xl font-bold mb-2">
            {passed ? 'Congratulations!' : 'Test Complete'}
          </h2>
          <p className="text-gray-600">
            You scored {result.score}% ({result.correct_answers} out of {result.total_questions} correct)
          </p>
          {passed ? (
            <p className="text-green-600 font-medium mt-2">You passed the test!</p>
          ) : (
            <p className="text-red-600 font-medium mt-2">
              You need {test.passing_score}% to pass. Try again!
            </p>
          )}
        </div>

        <div className="mb-8">
          <h3 className="font-bold mb-4">Previous Attempts</h3>
          <div className="space-y-2">
            {previousResults.map((result, index) => (
              <div
                key={index}
                className="flex justify-between items-center p-3 bg-gray-50 rounded-lg"
              >
                <div>
                  <p className="font-medium">{result.score}%</p>
                  <p className="text-sm text-gray-600">
                    {new Date(result.completed_at).toLocaleDateString()}
                  </p>
                </div>
                <div className={`px-3 py-1 rounded-full text-sm font-medium ${
                  result.score >= test.passing_score
                    ? 'bg-green-100 text-green-800'
                    : 'bg-red-100 text-red-800'
                }`}>
                  {result.score >= test.passing_score ? 'Pass' : 'Fail'}
                </div>
              </div>
            ))}
          </div>
        </div>

        <button
          onClick={() => {
            setResult(null);
            setAnswers({});
            setCurrentQuestion(0);
          }}
          className="w-full bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 transition-colors"
        >
          Take Test Again
        </button>
      </div>
    );
  }

  const question = questions[currentQuestion];
  const progress = ((currentQuestion + 1) / questions.length) * 100;

  return (
    <div className="bg-white rounded-lg shadow-lg p-6">
      <div className="mb-6">
        <div className="flex justify-between items-center mb-2">
          <h2 className="text-2xl font-bold">{test.title}</h2>
          <span className="text-gray-600">
            Question {currentQuestion + 1} of {questions.length}
          </span>
        </div>
        <div className="w-full bg-gray-200 rounded-full h-2">
          <div
            className="bg-blue-600 h-2 rounded-full transition-all duration-300"
            style={{ width: `${progress}%` }}
          />
        </div>
      </div>

      <div className="mb-8">
        <h3 className="text-lg font-medium mb-4">{question.question}</h3>
        <div className="space-y-3">
          {question.options.map((option, index) => (
            <label
              key={index}
              className={`block p-4 border rounded-lg cursor-pointer transition-colors ${
                answers[question.id] === option
                  ? 'bg-blue-50 border-blue-500'
                  : 'hover:bg-gray-50'
              }`}
            >
              <input
                type="radio"
                name={`question_${question.id}`}
                value={option}
                checked={answers[question.id] === option}
                onChange={() => handleAnswer(question.id, option)}
                className="sr-only"
              />
              <span className="ml-2">{option}</span>
            </label>
          ))}
        </div>
      </div>

      <div className="flex justify-between">
        <button
          onClick={() => setCurrentQuestion(prev => prev - 1)}
          disabled={currentQuestion === 0}
          className="flex items-center px-4 py-2 text-blue-600 hover:text-blue-700 disabled:opacity-50"
        >
          <ArrowLeft className="h-5 w-5 mr-1" />
          Previous
        </button>

        {currentQuestion === questions.length - 1 ? (
          <button
            onClick={handleSubmit}
            disabled={submitting || Object.keys(answers).length !== questions.length}
            className="flex items-center px-6 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors disabled:opacity-50"
          >
            {submitting ? (
              <>
                <Loader2 className="h-5 w-5 animate-spin mr-2" />
                Submitting...
              </>
            ) : (
              'Submit Test'
            )}
          </button>
        ) : (
          <button
            onClick={() => setCurrentQuestion(prev => prev + 1)}
            disabled={!answers[question.id]}
            className="flex items-center px-4 py-2 text-blue-600 hover:text-blue-700 disabled:opacity-50"
          >
            Next
            <ArrowRight className="h-5 w-5 ml-1" />
          </button>
        )}
      </div>
    </div>
  );
}