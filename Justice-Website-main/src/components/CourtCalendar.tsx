import React, { useState, useEffect } from 'react';
import { useGoogleLogin } from '@react-oauth/google';
import { supabase } from '../lib/auth';
import { useCourt } from '../context/CourtContext';
import { Calendar, Clock, MapPin, User, AlertCircle, CheckCircle, Loader2, Calendar as CalendarIcon } from 'lucide-react';

interface CalendarEvent {
  id: string;
  title: string;
  description: string;
  start_time: string;
  end_time: string;
  location: string;
  judge_name: string;
  event_type: string;
  is_available: boolean;
  max_appointments: number;
  court_location_id: string;
}

interface Appointment {
  id: string;
  calendar_id: string;
  status: string;
  notes: string;
  created_at: string;
}

export default function CourtCalendar() {
  const [events, setEvents] = useState<CalendarEvent[]>([]);
  const [appointments, setAppointments] = useState<Appointment[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [selectedDate, setSelectedDate] = useState<Date>(new Date());
  const [scheduling, setScheduling] = useState(false);
  const [selectedEvent, setSelectedEvent] = useState<CalendarEvent | null>(null);
  const [notes, setNotes] = useState('');
  const [googleToken, setGoogleToken] = useState<string | null>(null);
  const [isCourtAdmin, setIsCourtAdmin] = useState(false);
  const { selectedCourt } = useCourt();

  const login = useGoogleLogin({
    onSuccess: tokenResponse => setGoogleToken(tokenResponse.access_token),
    scope: [
      'https://www.googleapis.com/auth/calendar.events',
      'https://www.googleapis.com/auth/calendar.readonly',
      'https://www.googleapis.com/auth/calendar.settings.readonly'
    ].join(' '),
    onError: () => {
      setError('Failed to connect to Google Calendar');
    }
  });

  useEffect(() => {
    if (selectedCourt) {
      fetchEvents();
      fetchUserAppointments();
      checkCourtAdminStatus();
    } else {
      setEvents([]);
      setAppointments([]);
      setError(null);
    }
  }, [selectedDate, selectedCourt]);

  async function checkCourtAdminStatus() {
    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user || !selectedCourt) return;

      // Use RPC function to check admin status
      const { data, error } = await supabase.rpc('is_court_administrator', {
        court_id: selectedCourt.id
      });

      if (error) throw error;
      setIsCourtAdmin(!!data);
    } catch (err) {
      console.error('Error checking admin status:', err);
      setIsCourtAdmin(false);
    }
  }

  async function fetchEvents() {
    if (!selectedCourt) return;
    
    try {
      const startOfDay = new Date(selectedDate);
      startOfDay.setHours(0, 0, 0, 0);
      
      const endOfDay = new Date(selectedDate);
      endOfDay.setHours(23, 59, 59, 999);

      const { data, error } = await supabase
        .from('court_calendars')
        .select('*')
        .eq('court_location_id', selectedCourt.id)
        .gte('start_time', startOfDay.toISOString())
        .lte('start_time', endOfDay.toISOString())
        .order('start_time', { ascending: true });

      if (error) throw error;
      setEvents(data || []);
    } catch (err) {
      console.error('Error fetching events:', err);
      setError('Failed to load calendar events');
    } finally {
      setLoading(false);
    }
  }

  async function fetchUserAppointments() {
    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) return;

      const { data, error } = await supabase
        .from('court_appointments')
        .select('*')
        .eq('user_id', user.id);

      if (error) throw error;
      setAppointments(data || []);
    } catch (err) {
      console.error('Error fetching appointments:', err);
      setError('Failed to load appointments');
    }
  }

  const isEventBooked = (eventId: string) => {
    return appointments.some(apt => apt.calendar_id === eventId);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!selectedEvent) return;

    setScheduling(true);
    setError(null);

    try {
      const { data: available } = await supabase.rpc('check_appointment_availability', {
        calendar_id: selectedEvent.id
      });

      if (!available) {
        setError('This time slot is no longer available');
        return;
      }

      const { data: { user } } = await supabase.auth.getUser();
      if (!user) {
        setError('Please sign in to schedule appointments');
        return;
      }

      const { error } = await supabase
        .from('court_appointments')
        .insert([{
          calendar_id: selectedEvent.id,
          notes: notes.trim(),
          user_id: user.id
        }]);

      if (error) throw error;

      // Add to Google Calendar if token exists and user is court admin
      if (googleToken && isCourtAdmin) {
        await addToGoogleCalendar(selectedEvent);
      }

      await fetchUserAppointments();
      setSelectedEvent(null);
      setNotes('');
    } catch (err) {
      console.error('Error scheduling appointment:', err);
      setError('Failed to schedule appointment');
    } finally {
      setScheduling(false);
    }
  };

  async function addToGoogleCalendar(event: CalendarEvent) {
    if (!googleToken) {
      login();
      return;
    }

    try {
      const response = await fetch('https://www.googleapis.com/calendar/v3/calendars/primary/events', {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${googleToken}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          summary: event.title,
          description: event.description,
          location: event.location,
          start: {
            dateTime: event.start_time,
            timeZone: Intl.DateTimeFormat().resolvedOptions().timeZone,
          },
          end: {
            dateTime: event.end_time,
            timeZone: Intl.DateTimeFormat().resolvedOptions().timeZone,
          },
        }),
      });

      if (!response.ok) {
        throw new Error('Failed to add event to Google Calendar');
      }
    } catch (err) {
      console.error('Error adding to Google Calendar:', err);
      setError('Failed to add event to Google Calendar');
    }
  }

  if (!selectedCourt) {
    return (
      <div className="bg-white rounded-lg shadow-lg p-6">
        <div className="text-center py-12">
          <Calendar className="h-12 w-12 text-gray-400 mx-auto mb-4" />
          <h3 className="text-lg font-medium">Select a Court</h3>
          <p className="text-gray-600 mt-2">
            Please select a court to view its calendar and schedule appointments
          </p>
        </div>
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
        <h2 className="text-2xl font-bold mb-2">Court Calendar</h2>
        <p className="text-gray-600">Schedule court appointments and view availability</p>
      </div>

      {error && (
        <div className="mb-6 p-4 bg-red-50 text-red-700 rounded-lg flex items-center">
          <AlertCircle className="h-5 w-5 mr-2" />
          {error}
        </div>
      )}

      <div className="mb-6 flex items-center justify-between">
        <input
          type="date"
          value={selectedDate.toISOString().split('T')[0]}
          onChange={(e) => setSelectedDate(new Date(e.target.value))}
          className="border rounded-lg px-4 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
        />
        
        {isCourtAdmin && !googleToken && (
          <button
            onClick={() => login()}
            className="flex items-center px-4 py-2 bg-white border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors"
          >
            <CalendarIcon className="h-5 w-5 mr-2 text-blue-600" />
            Connect Google Calendar
          </button>
        )}
      </div>

      <div className="space-y-4">
        {events.length === 0 ? (
          <div className="text-center py-12">
            <Calendar className="h-12 w-12 text-gray-400 mx-auto mb-4" />
            <p className="text-lg font-medium">No events scheduled</p>
            <p className="text-gray-600">Try selecting a different date</p>
          </div>
        ) : (
          events.map(event => (
            <div
              key={event.id}
              className="border rounded-lg p-4 hover:shadow-md transition-shadow"
            >
              <div className="flex justify-between items-start">
                <div>
                  <h3 className="font-bold text-lg mb-2">{event.title}</h3>
                  <p className="text-gray-600 mb-3">{event.description}</p>
                  <div className="space-y-2 text-sm text-gray-500">
                    <div className="flex items-center">
                      <Clock className="h-4 w-4 mr-2" />
                      {new Date(event.start_time).toLocaleTimeString()} - {new Date(event.end_time).toLocaleTimeString()}
                    </div>
                    <div className="flex items-center">
                      <MapPin className="h-4 w-4 mr-2" />
                      {event.location}
                    </div>
                    {event.judge_name && (
                      <div className="flex items-center">
                        <User className="h-4 w-4 mr-2" />
                        Judge {event.judge_name}
                      </div>
                    )}
                  </div>
                </div>
                <div>
                  {isEventBooked(event.id) ? (
                    <span className="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-green-100 text-green-800">
                      <CheckCircle className="h-4 w-4 mr-1" />
                      Scheduled
                    </span>
                  ) : event.is_available ? (
                    <button
                      onClick={() => setSelectedEvent(event)}
                      className="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 transition-colors"
                    >
                      Schedule
                    </button>
                  ) : (
                    <span className="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-gray-100 text-gray-800">
                      Unavailable
                    </span>
                  )}
                </div>
              </div>
            </div>
          ))
        )}
      </div>

      {/* Scheduling Modal */}
      {selectedEvent && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4">
          <div className="bg-white rounded-lg p-6 max-w-md w-full">
            <h3 className="text-lg font-bold mb-4">Schedule Appointment</h3>
            <p className="text-gray-600 mb-4">{selectedEvent.title}</p>
            
            <div className="mb-4">
              <label className="block text-sm font-medium text-gray-700 mb-1">
                Notes (optional)
              </label>
              <textarea
                value={notes}
                onChange={(e) => setNotes(e.target.value)}
                className="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                rows={3}
                placeholder="Add any special requests or notes..."
              />
            </div>

            {isCourtAdmin && !googleToken && (
              <div className="mb-4 p-4 bg-blue-50 text-blue-700 rounded-lg">
                <p className="text-sm">
                  Connect your Google Calendar to automatically add appointments
                </p>
                <button
                  onClick={() => login()}
                  className="mt-2 text-sm font-medium text-blue-600 hover:text-blue-500"
                >
                  Connect Now
                </button>
              </div>
            )}

            <div className="flex justify-end space-x-4">
              <button
                onClick={() => {
                  setSelectedEvent(null);
                  setNotes('');
                }}
                className="px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors"
                disabled={scheduling}
              >
                Cancel
              </button>
              <button
                onClick={handleSubmit}
                disabled={scheduling}
                className="bg-blue-600 text-white px-6 py-2 rounded-lg hover:bg-blue-700 transition-colors disabled:opacity-50 flex items-center"
              >
                {scheduling ? (
                  <>
                    <Loader2 className="h-5 w-5 animate-spin mr-2" />
                    Scheduling...
                  </>
                ) : (
                  'Confirm Appointment'
                )}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}