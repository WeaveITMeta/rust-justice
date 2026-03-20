import React, { useState, useEffect } from 'react';
import { supabase } from '../lib/auth';
import { useCourt } from '../context/CourtContext';
import { DollarSign, CreditCard, Calendar, AlertCircle, CheckCircle, Loader2, Building2, ArrowRight } from 'lucide-react';

interface TrafficTicket {
  id: string;
  citation_number: string;
  violation_date: string;
  violation_description: string;
  fine_amount: number;
  status: string;
  due_date: string;
  court_location_id: string;
}

interface PaymentFormData {
  cardNumber: string;
  expiryDate: string;
  cvv: string;
  nameOnCard: string;
}

export default function TrafficTicketPayment() {
  const { selectedCourt } = useCourt();
  const [tickets, setTickets] = useState<TrafficTicket[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [selectedTicket, setSelectedTicket] = useState<TrafficTicket | null>(null);
  const [showPaymentForm, setShowPaymentForm] = useState(false);
  const [processing, setProcessing] = useState(false);
  const [paymentForm, setPaymentForm] = useState<PaymentFormData>({
    cardNumber: '',
    expiryDate: '',
    cvv: '',
    nameOnCard: '',
  });

  useEffect(() => {
    if (selectedCourt) {
      fetchTickets();
    }
  }, [selectedCourt]);

  async function fetchTickets() {
    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) throw new Error('Not authenticated');

      const { data, error } = await supabase
        .from('traffic_tickets')
        .select('*')
        .eq('status', 'unpaid')
        .eq('court_location_id', selectedCourt?.id)
        .eq('user_id', user.id)
        .order('due_date', { ascending: true });

      if (error) throw error;
      setTickets(data || []);
    } catch (err) {
      console.error('Error:', err);
      setError('Failed to load tickets. Please try again later.');
    } finally {
      setLoading(false);
    }
  }

  const handlePayment = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!selectedTicket) return;

    setProcessing(true);
    setError(null);

    try {
      // In a real application, you would:
      // 1. Validate the payment information
      // 2. Process the payment through a payment gateway
      // 3. Update the ticket status upon successful payment

      // Simulating payment processing
      await new Promise(resolve => setTimeout(resolve, 2000));

      const { error } = await supabase
        .from('traffic_tickets')
        .update({
          status: 'paid',
          payment_date: new Date().toISOString(),
          payment_reference: `PAY-${Math.random().toString(36).substr(2, 9)}`,
        })
        .eq('id', selectedTicket.id);

      if (error) throw error;

      // Refresh tickets list
      await fetchTickets();
      setShowPaymentForm(false);
      setSelectedTicket(null);
      setPaymentForm({
        cardNumber: '',
        expiryDate: '',
        cvv: '',
        nameOnCard: '',
      });
    } catch (err) {
      console.error('Error:', err);
      setError('Payment failed. Please try again later.');
    } finally {
      setProcessing(false);
    }
  };

  if (!selectedCourt) {
    return (
      <div className="bg-white rounded-lg shadow-lg p-8 text-center">
        <Building2 className="h-12 w-12 text-gray-400 mx-auto mb-4" />
        <h3 className="text-lg font-medium text-gray-900 mb-2">Select a Court</h3>
        <p className="text-gray-600 mb-6">Please select a court to view and pay traffic tickets</p>
        <a
          href="/courts"
          className="inline-flex items-center text-blue-600 hover:text-blue-700"
        >
          Select Court <ArrowRight className="ml-2 h-5 w-5" />
        </a>
      </div>
    );
  }

  if (loading) {
    return (
      <div className="flex items-center justify-center p-8">
        <Loader2 className="h-8 w-8 animate-spin text-blue-600" />
      </div>
    );
  }

  return (
    <div className="bg-white rounded-lg shadow-lg p-6">
      <div className="mb-6">
        <h2 className="text-2xl font-bold mb-2">Traffic Ticket Payments</h2>
        <p className="text-gray-600">Pay your traffic citations for {selectedCourt.name}</p>
      </div>

      {error && (
        <div className="mb-6 p-4 bg-red-50 text-red-700 rounded-lg flex items-center">
          <AlertCircle className="h-5 w-5 mr-2" />
          {error}
        </div>
      )}

      {tickets.length === 0 ? (
        <div className="text-center py-8">
          <CheckCircle className="h-12 w-12 text-green-600 mx-auto mb-4" />
          <p className="text-lg font-medium">No unpaid tickets found</p>
          <p className="text-gray-600">You're all caught up!</p>
        </div>
      ) : (
        <div className="space-y-6">
          {!showPaymentForm ? (
            <div className="grid gap-4">
              {tickets.map(ticket => (
                <div
                  key={ticket.id}
                  className="border rounded-lg p-4 hover:shadow-md transition-shadow"
                >
                  <div className="flex justify-between items-start">
                    <div>
                      <h3 className="font-bold text-lg mb-2">
                        Citation #{ticket.citation_number}
                      </h3>
                      <p className="text-gray-600 mb-2">
                        {ticket.violation_description}
                      </p>
                      <div className="flex items-center text-sm text-gray-500 space-x-4">
                        <span className="flex items-center">
                          <Calendar className="h-4 w-4 mr-1" />
                          Violation Date: {new Date(ticket.violation_date).toLocaleDateString()}
                        </span>
                        <span className="flex items-center">
                          <Calendar className="h-4 w-4 mr-1" />
                          Due Date: {new Date(ticket.due_date).toLocaleDateString()}
                        </span>
                      </div>
                    </div>
                    <div className="text-right">
                      <p className="text-2xl font-bold text-green-600">
                        ${ticket.fine_amount.toFixed(2)}
                      </p>
                      <button
                        onClick={() => {
                          setSelectedTicket(ticket);
                          setShowPaymentForm(true);
                        }}
                        className="mt-2 bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 transition-colors"
                      >
                        Pay Now
                      </button>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          ) : (
            <div className="max-w-md mx-auto">
              <div className="mb-6">
                <h3 className="text-xl font-bold mb-2">Payment Details</h3>
                <p className="text-gray-600">
                  Citation #{selectedTicket?.citation_number} - ${selectedTicket?.fine_amount.toFixed(2)}
                </p>
              </div>

              <form onSubmit={handlePayment} className="space-y-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">
                    Name on Card
                  </label>
                  <input
                    type="text"
                    value={paymentForm.nameOnCard}
                    onChange={e => setPaymentForm({ ...paymentForm, nameOnCard: e.target.value })}
                    className="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                    required
                  />
                </div>

                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">
                    Card Number
                  </label>
                  <input
                    type="text"
                    value={paymentForm.cardNumber}
                    onChange={e => setPaymentForm({ ...paymentForm, cardNumber: e.target.value })}
                    className="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                    required
                  />
                </div>

                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">
                      Expiry Date
                    </label>
                    <input
                      type="text"
                      placeholder="MM/YY"
                      value={paymentForm.expiryDate}
                      onChange={e => setPaymentForm({ ...paymentForm, expiryDate: e.target.value })}
                      className="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                      required
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">
                      CVV
                    </label>
                    <input
                      type="text"
                      value={paymentForm.cvv}
                      onChange={e => setPaymentForm({ ...paymentForm, cvv: e.target.value })}
                      className="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                      required
                    />
                  </div>
                </div>

                <div className="flex space-x-4 pt-4">
                  <button
                    type="button"
                    onClick={() => {
                      setShowPaymentForm(false);
                      setSelectedTicket(null);
                    }}
                    className="flex-1 px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors"
                    disabled={processing}
                  >
                    Cancel
                  </button>
                  <button
                    type="submit"
                    disabled={processing}
                    className="flex-1 bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 transition-colors disabled:opacity-50"
                  >
                    {processing ? (
                      <span className="flex items-center justify-center">
                        <Loader2 className="h-5 w-5 animate-spin mr-2" />
                        Processing...
                      </span>
                    ) : (
                      <span className="flex items-center justify-center">
                        <CreditCard className="h-5 w-5 mr-2" />
                        Pay ${selectedTicket?.fine_amount.toFixed(2)}
                      </span>
                    )}
                  </button>
                </div>
              </form>
            </div>
          )}
        </div>
      )}
    </div>
  );
}