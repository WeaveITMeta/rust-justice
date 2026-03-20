import React, { useState, useRef, useEffect } from 'react';
import { MessageCircle, Send, Loader2, AlertCircle, X, Maximize2, Minimize2, Volume2, VolumeX } from 'lucide-react';
import OpenAI from 'openai';
import Anthropic from '@anthropic-ai/sdk';

interface Message {
  text: string;
  isUser: boolean;
  timestamp: Date;
}

export default function ChatBot() {
  const [isOpen, setIsOpen] = useState(false);
  const [messages, setMessages] = useState<Message[]>([]);
  const [input, setInput] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [isExpanded, setIsExpanded] = useState(false);
  const [isSpeechEnabled, setIsSpeechEnabled] = useState(false);
  const messagesEndRef = useRef<HTMLDivElement>(null);
  const inputRef = useRef<HTMLTextAreaElement>(null);

  useEffect(() => {
    scrollToBottom();
  }, [messages]);

  useEffect(() => {
    if (isOpen && inputRef.current) {
      inputRef.current.focus();
    }
  }, [isOpen]);

  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!input.trim() || isLoading) return;

    const userMessage = input.trim();
    setMessages(prev => [...prev, { text: userMessage, isUser: true, timestamp: new Date() }]);
    setInput('');
    setError(null);
    setIsLoading(true);

    try {
      // Try OpenAI first
      try {
        const apiKey = import.meta.env.VITE_OPENAI_API_KEY;
        if (!apiKey) {
          throw new Error('OpenAI API key not configured');
        }

        const openai = new OpenAI({
          apiKey,
          dangerouslyAllowBrowser: true
        });

        const completion = await openai.chat.completions.create({
          messages: [
            { 
              role: "system", 
              content: "You are a knowledgeable legal assistant helping users navigate the justice system. Provide clear, accurate information about legal procedures, forms, and regulations. Always include relevant legal citations when applicable. Be concise but thorough." 
            },
            ...messages.map(msg => ({
              role: msg.isUser ? "user" : "assistant" as const,
              content: msg.text
            })),
            { role: "user", content: userMessage }
          ],
          model: "gpt-3.5-turbo",
          temperature: 0.7,
          max_tokens: 500
        });

        const response = completion.choices[0]?.message?.content || "I apologize, but I couldn't process your request.";
        addResponse(response);

        if (isSpeechEnabled) {
          speakResponse(response);
        }
      } catch (openaiError) {
        // Fallback to Claude if OpenAI fails
        const apiKey = import.meta.env.VITE_ANTHROPIC_API_KEY;
        if (!apiKey) {
          throw new Error('Anthropic API key not configured');
        }

        const anthropic = new Anthropic({
          apiKey,
        });

        const message = await anthropic.messages.create({
          model: "claude-3-sonnet-20240229",
          max_tokens: 500,
          temperature: 0.7,
          messages: [
            {
              role: "system",
              content: "You are a knowledgeable legal assistant helping users navigate the justice system. Provide clear, accurate information about legal procedures, forms, and regulations. Always include relevant legal citations when applicable. Be concise but thorough."
            },
            ...messages.map(msg => ({
              role: msg.isUser ? "user" : "assistant" as const,
              content: msg.text
            })),
            { role: "user", content: userMessage }
          ],
        });

        const response = message.content[0]?.text || "I apologize, but I couldn't process your request.";
        addResponse(response);

        if (isSpeechEnabled) {
          speakResponse(response);
        }
      }
    } catch (error) {
      console.error('Error:', error);
      setError('I apologize, but I\'m having trouble connecting right now. Please make sure the API keys are properly configured.');
    } finally {
      setIsLoading(false);
    }
  };

  const addResponse = (text: string) => {
    setMessages(prev => [...prev, { text, isUser: false, timestamp: new Date() }]);
  };

  const speakResponse = (text: string) => {
    const utterance = new SpeechSynthesisUtterance(text);
    utterance.rate = 0.9;
    utterance.pitch = 1;
    window.speechSynthesis.speak(utterance);
  };

  const toggleExpanded = () => {
    setIsExpanded(!isExpanded);
  };

  const toggleSpeech = () => {
    setIsSpeechEnabled(!isSpeechEnabled);
    if (isSpeechEnabled) {
      window.speechSynthesis.cancel();
    }
  };

  const handleKeyPress = (e: React.KeyboardEvent) => {
    if (e.key === 'Enter' && !e.shiftKey) {
      e.preventDefault();
      handleSubmit(e);
    }
  };

  return (
    <div className="fixed bottom-4 right-4 z-50">
      {!isOpen ? (
        <button
          onClick={() => setIsOpen(true)}
          className="bg-blue-600 text-white rounded-full p-4 shadow-lg hover:bg-blue-700 transition-colors duration-200 flex items-center space-x-2"
        >
          <MessageCircle className="h-6 w-6" />
          <span className="hidden md:inline">Legal Assistant</span>
        </button>
      ) : (
        <div 
          className={`bg-white rounded-lg shadow-xl flex flex-col transition-all duration-200 ${
            isExpanded ? 'w-[800px] h-[800px]' : 'w-96 h-[500px]'
          }`}
        >
          <div className="bg-blue-600 text-white p-4 rounded-t-lg flex justify-between items-center">
            <h3 className="font-bold flex items-center space-x-2">
              <MessageCircle className="h-5 w-5" />
              <span>Legal Assistant</span>
            </h3>
            <div className="flex items-center space-x-2">
              <button 
                onClick={toggleSpeech}
                className="text-white hover:text-gray-200 transition-colors duration-200"
                title={isSpeechEnabled ? "Disable voice responses" : "Enable voice responses"}
              >
                {isSpeechEnabled ? <Volume2 className="h-5 w-5" /> : <VolumeX className="h-5 w-5" />}
              </button>
              <button 
                onClick={toggleExpanded}
                className="text-white hover:text-gray-200 transition-colors duration-200"
              >
                {isExpanded ? <Minimize2 className="h-5 w-5" /> : <Maximize2 className="h-5 w-5" />}
              </button>
              <button 
                onClick={() => setIsOpen(false)} 
                className="text-white hover:text-gray-200 transition-colors duration-200"
              >
                <X className="h-5 w-5" />
              </button>
            </div>
          </div>
          
          <div className="flex-1 overflow-y-auto p-4 space-y-4">
            {messages.length === 0 && (
              <div className="text-gray-500 text-center space-y-2">
                <p className="font-medium">Welcome to the Legal Assistant</p>
                <p className="text-sm">Ask me about:</p>
                <ul className="text-sm">
                  <li>• Legal procedures and requirements</li>
                  <li>• Court forms and documentation</li>
                  <li>• Regulations and compliance</li>
                  <li>• General legal information</li>
                </ul>
              </div>
            )}
            {messages.map((msg, idx) => (
              <div
                key={idx}
                className={`${
                  msg.isUser 
                    ? 'ml-auto bg-blue-600 text-white' 
                    : 'mr-auto bg-gray-100'
                } rounded-lg p-3 max-w-[80%] shadow-sm relative group`}
              >
                {msg.text}
                <span className="absolute -bottom-5 text-xs text-gray-500">
                  {msg.timestamp.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}
                </span>
              </div>
            ))}
            {isLoading && (
              <div className="mr-auto bg-gray-100 rounded-lg p-3 flex items-center space-x-2">
                <Loader2 className="h-4 w-4 animate-spin" />
                <span>Analyzing your question...</span>
              </div>
            )}
            {error && (
              <div className="bg-red-50 text-red-700 p-3 rounded-lg flex items-center space-x-2">
                <AlertCircle className="h-4 w-4" />
                <span>{error}</span>
              </div>
            )}
            <div ref={messagesEndRef} />
          </div>

          <form onSubmit={handleSubmit} className="p-4 border-t">
            <div className="flex space-x-2">
              <textarea
                ref={inputRef}
                value={input}
                onChange={(e) => setInput(e.target.value)}
                onKeyPress={handleKeyPress}
                placeholder="Ask about legal matters..."
                className="flex-1 border rounded-lg px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-600 resize-none"
                rows={1}
                disabled={isLoading}
              />
              <button
                type="submit"
                disabled={isLoading || !input.trim()}
                className="bg-blue-600 text-white rounded-lg px-4 py-2 hover:bg-blue-700 transition-colors duration-200 disabled:opacity-50 disabled:cursor-not-allowed flex items-center justify-center w-12"
              >
                {isLoading ? (
                  <Loader2 className="h-5 w-5 animate-spin" />
                ) : (
                  <Send className="h-5 w-5" />
                )}
              </button>
            </div>
          </form>
        </div>
      )}
    </div>
  );
}