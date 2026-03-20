import React, { useState, useEffect } from 'react';
import { supabase } from '../lib/auth';
import { Building, DollarSign, Plus, Trash2, Edit, Loader2, AlertCircle } from 'lucide-react';

interface BankAccount {
  id: string;
  account_name: string;
  account_number: string;
  routing_number: string;
  institution_name: string;
  is_active: boolean;
  created_at: string;
  updated_at: string;
}

export default function BankAccountManagement() {
  const [accounts, setAccounts] = useState<BankAccount[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [showForm, setShowForm] = useState(false);
  const [processing, setProcessing] = useState(false);
  const [editingAccount, setEditingAccount] = useState<BankAccount | null>(null);
  const [formData, setFormData] = useState({
    account_name: '',
    account_number: '',
    routing_number: '',
    institution_name: '',
  });

  useEffect(() => {
    fetchAccounts();
  }, []);

  async function fetchAccounts() {
    try {
      const { data, error } = await supabase
        .from('bank_accounts')
        .select('*')
        .order('created_at', { ascending: false });

      if (error) throw error;
      setAccounts(data || []);
    } catch (err) {
      setError('Failed to load bank accounts. Please try again later.');
      console.error('Error:', err);
    } finally {
      setLoading(false);
    }
  }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setProcessing(true);
    setError(null);

    try {
      if (editingAccount) {
        const { error } = await supabase
          .from('bank_accounts')
          .update({
            ...formData,
            updated_at: new Date().toISOString(),
          })
          .eq('id', editingAccount.id);

        if (error) throw error;
      } else {
        const { error } = await supabase
          .from('bank_accounts')
          .insert([formData]);

        if (error) throw error;
      }

      await fetchAccounts();
      resetForm();
    } catch (err) {
      setError('Failed to save bank account. Please try again later.');
      console.error('Error:', err);
    } finally {
      setProcessing(false);
    }
  };

  const handleDelete = async (id: string) => {
    if (!confirm('Are you sure you want to delete this bank account?')) return;

    setProcessing(true);
    setError(null);

    try {
      const { error } = await supabase
        .from('bank_accounts')
        .delete()
        .eq('id', id);

      if (error) throw error;
      await fetchAccounts();
    } catch (err) {
      setError('Failed to delete bank account. Please try again later.');
      console.error('Error:', err);
    } finally {
      setProcessing(false);
    }
  };

  const resetForm = () => {
    setFormData({
      account_name: '',
      account_number: '',
      routing_number: '',
      institution_name: '',
    });
    setEditingAccount(null);
    setShowForm(false);
  };

  const startEdit = (account: BankAccount) => {
    setEditingAccount(account);
    setFormData({
      account_name: account.account_name,
      account_number: account.account_number,
      routing_number: account.routing_number,
      institution_name: account.institution_name,
    });
    setShowForm(true);
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center p-8">
        <Loader2 className="h-8 w-8 animate-spin text-blue-600" />
      </div>
    );
  }

  return (
    <div className="bg-white rounded-lg shadow-lg p-6">
      <div className="flex justify-between items-center mb-6">
        <div>
          <h2 className="text-2xl font-bold mb-2">Bank Account Management</h2>
          <p className="text-gray-600">Manage court system bank accounts</p>
        </div>
        {!showForm && (
          <button
            onClick={() => setShowForm(true)}
            className="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 transition-colors flex items-center"
          >
            <Plus className="h-5 w-5 mr-2" />
            Add Account
          </button>
        )}
      </div>

      {error && (
        <div className="mb-6 p-4 bg-red-50 text-red-700 rounded-lg flex items-center">
          <AlertCircle className="h-5 w-5 mr-2" />
          {error}
        </div>
      )}

      {showForm && (
        <div className="mb-8 bg-gray-50 p-6 rounded-lg">
          <h3 className="text-lg font-bold mb-4">
            {editingAccount ? 'Edit Bank Account' : 'Add New Bank Account'}
          </h3>
          <form onSubmit={handleSubmit} className="space-y-4">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Account Name
                </label>
                <input
                  type="text"
                  value={formData.account_name}
                  onChange={e => setFormData({ ...formData, account_name: e.target.value })}
                  className="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                  required
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Institution Name
                </label>
                <input
                  type="text"
                  value={formData.institution_name}
                  onChange={e => setFormData({ ...formData, institution_name: e.target.value })}
                  className="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                  required
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Account Number
                </label>
                <input
                  type="text"
                  value={formData.account_number}
                  onChange={e => setFormData({ ...formData, account_number: e.target.value })}
                  className="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                  required
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Routing Number
                </label>
                <input
                  type="text"
                  value={formData.routing_number}
                  onChange={e => setFormData({ ...formData, routing_number: e.target.value })}
                  className="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                  required
                />
              </div>
            </div>

            <div className="flex justify-end space-x-4 pt-4">
              <button
                type="button"
                onClick={resetForm}
                className="px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors"
                disabled={processing}
              >
                Cancel
              </button>
              <button
                type="submit"
                disabled={processing}
                className="bg-blue-600 text-white px-6 py-2 rounded-lg hover:bg-blue-700 transition-colors disabled:opacity-50 flex items-center"
              >
                {processing ? (
                  <>
                    <Loader2 className="h-5 w-5 animate-spin mr-2" />
                    Processing...
                  </>
                ) : (
                  <>
                    <DollarSign className="h-5 w-5 mr-2" />
                    {editingAccount ? 'Update' : 'Save'} Account
                  </>
                )}
              </button>
            </div>
          </form>
        </div>
      )}

      <div className="space-y-4">
        {accounts.map(account => (
          <div
            key={account.id}
            className="border rounded-lg p-4 hover:shadow-md transition-shadow"
          >
            <div className="flex justify-between items-start">
              <div>
                <h3 className="font-bold text-lg mb-2 flex items-center">
                  <Building className="h-5 w-5 text-blue-600 mr-2" />
                  {account.account_name}
                </h3>
                <p className="text-gray-600 mb-2">{account.institution_name}</p>
                <div className="text-sm text-gray-500">
                  <p>Account: ****{account.account_number.slice(-4)}</p>
                  <p>Routing: ****{account.routing_number.slice(-4)}</p>
                </div>
              </div>
              <div className="flex space-x-2">
                <button
                  onClick={() => startEdit(account)}
                  className="p-2 text-blue-600 hover:bg-blue-50 rounded-lg transition-colors"
                >
                  <Edit className="h-5 w-5" />
                </button>
                <button
                  onClick={() => handleDelete(account.id)}
                  className="p-2 text-red-600 hover:bg-red-50 rounded-lg transition-colors"
                >
                  <Trash2 className="h-5 w-5" />
                </button>
              </div>
            </div>
          </div>
        ))}

        {accounts.length === 0 && (
          <div className="text-center py-8">
            <DollarSign className="h-12 w-12 text-gray-400 mx-auto mb-4" />
            <p className="text-lg font-medium">No bank accounts configured</p>
            <p className="text-gray-600">Add a bank account to get started</p>
          </div>
        )}
      </div>
    </div>
  );
}