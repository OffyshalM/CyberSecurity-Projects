import React, { useState, useEffect } from 'react';
import { ShieldAlert, ShieldCheck, Activity, Search, RefreshCw, Cpu, Server } from 'lucide-react';
import { fetchAlerts } from './Api';

export default function App() {
  const [alerts, setAlerts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState('');
  const [severityFilter, setSeverityFilter] = useState('ALL');

  // Load data from backend on mount
  const loadData = async () => {
    setLoading(true);
    const data = await fetchAlerts();
    setAlerts(data);
    setLoading(false);
  };

  useEffect(() => {
    loadData();
  }, []);

  // Filter logic for search & severity
  const filteredAlerts = alerts.filter(alert => {
    const matchesSearch = 
      (alert.deviceId && alert.deviceId.toLowerCase().includes(searchTerm.toLowerCase())) ||
      (alert.processName && alert.processName.toLowerCase().includes(searchTerm.toLowerCase())) ||
      (alert.rawDetail && alert.rawDetail.toLowerCase().includes(searchTerm.toLowerCase()));
    
    const matchesSeverity = severityFilter === 'ALL' || alert.severity === severityFilter;

    return matchesSearch && matchesSeverity;
  });

  // Calculate quick stats
  const totalLogs = alerts.length;
  const highThreats = alerts.filter(a => a.severity === 'HIGH').length;
  const lowRisks = totalLogs - highThreats;

  return (
    <div className="min-h-screen bg-slate-950 text-slate-100 p-4 md:p-8 font-sans">
      {/* Header */}
      <header className="max-w-7xl mx-auto flex flex-col md:flex-row justify-between items-start md:items-center mb-8 pb-4 border-b border-slate-800 gap-4">
        <div>
          <div className="flex items-center gap-2">
            <ShieldAlert className="w-8 h-8 text-cyan-400" />
            <h1 className="text-2xl md:text-3xl font-bold tracking-tight bg-gradient-to-r from-cyan-400 to-blue-500 bg-clip-text text-transparent">
              Keylogger Detection Simulator
            </h1>
          </div>
          <p className="text-slate-400 text-sm mt-1">
            Real-time behavioral telemetry analysis & anomaly detection dashboard
          </p>
        </div>

        <button 
          onClick={loadData}
          className="flex items-center gap-2 bg-slate-800 hover:bg-slate-700 text-cyan-400 px-4 py-2 rounded-lg text-sm font-medium transition border border-slate-700 shadow-sm"
        >
          <RefreshCw className={`w-4 h-4 ${loading ? 'animate-spin' : ''}`} />
          Refresh Telemetry
        </button>
      </header>

      {/* Main Content Container */}
      <main className="max-w-7xl mx-auto space-y-6">
        
        {/* Stats Grid */}
        <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
          <div className="bg-slate-900 border border-slate-800 p-5 rounded-xl shadow-md flex items-center justify-between">
            <div>
              <p className="text-slate-400 text-xs font-semibold uppercase tracking-wider">Total Telemetry Logs</p>
              <p className="text-2xl font-bold mt-1 text-slate-100">{totalLogs}</p>
            </div>
            <Activity className="w-10 h-10 text-cyan-500 bg-cyan-950/50 p-2 rounded-lg border border-cyan-800/50" />
          </div>

          <div className="bg-slate-900 border border-slate-800 p-5 rounded-xl shadow-md flex items-center justify-between">
            <div>
              <p className="text-slate-400 text-xs font-semibold uppercase tracking-wider">High Severity Threats</p>
              <p className="text-2xl font-bold mt-1 text-rose-400">{highThreats}</p>
            </div>
            <ShieldAlert className="w-10 h-10 text-rose-500 bg-rose-950/50 p-2 rounded-lg border border-rose-800/50" />
          </div>

          <div className="bg-slate-900 border border-slate-800 p-5 rounded-xl shadow-md flex items-center justify-between">
            <div>
              <p className="text-slate-400 text-xs font-semibold uppercase tracking-wider">Low Risk / Normal</p>
              <p className="text-2xl font-bold mt-1 text-emerald-400">{lowRisks}</p>
            </div>
            <ShieldCheck className="w-10 h-10 text-emerald-500 bg-emerald-950/50 p-2 rounded-lg border border-emerald-800/50" />
          </div>
        </div>

        {/* Controls Toolbar (Search & Filter) */}
        <div className="bg-slate-900 border border-slate-800 p-4 rounded-xl flex flex-col md:flex-row gap-4 justify-between items-center">
          {/* Search bar */}
          <div className="relative w-full md:w-96">
            <Search className="absolute left-3 top-2.5 w-4 h-4 text-slate-400" />
            <input 
              type="text"
              placeholder="Search device, process, or detail..."
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className="w-full bg-slate-950 border border-slate-800 rounded-lg pl-9 pr-4 py-2 text-sm text-slate-200 focus:outline-none focus:border-cyan-500 transition"
            />
          </div>

          {/* Severity Filter Buttons */}
          <div className="flex items-center gap-2 w-full md:w-auto overflow-x-auto pb-1 md:pb-0">
            {['ALL', 'HIGH', 'LOW'].map((sev) => (
              <button
                key={sev}
                onClick={() => setSeverityFilter(sev)}
                className={`px-4 py-2 rounded-lg text-xs font-semibold transition border ${
                  severityFilter === sev 
                    ? 'bg-cyan-500 text-slate-950 border-cyan-400 font-bold shadow-sm' 
                    : 'bg-slate-950 text-slate-400 border-slate-800 hover:border-slate-700'
                }`}
              >
                {sev} SEVERITY
              </button>
            ))}
          </div>
        </div>

        {/* Data Table / Cards (Mobile Responsive) */}
        <div className="bg-slate-900 border border-slate-800 rounded-xl shadow-md overflow-hidden">
          {loading ? (
            <div className="p-12 text-center text-slate-400">Loading telemetry records from database...</div>
          ) : filteredAlerts.length === 0 ? (
            <div className="p-12 text-center text-slate-500">No security logs found matching your criteria.</div>
          ) : (
            <div className="overflow-x-auto">
              <table className="w-full text-left border-collapse">
                <thead>
                  <tr className="bg-slate-950/70 border-b border-slate-800 text-xs font-semibold text-slate-400 uppercase tracking-wider">
                    <th className="p-4">Timestamp</th>
                    <th className="p-4">Device ID</th>
                    <th className="p-4">Process Name</th>
                    <th className="p-4">Event Type</th>
                    <th className="p-4">Anomaly Score</th>
                    <th className="p-4">Severity</th>
                    <th className="p-4">Raw Detail</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-slate-800 text-sm">
                  {filteredAlerts.map((alert) => (
                    <tr key={alert.id || Math.random()} className="hover:bg-slate-800/50 transition">
                      <td className="p-4 text-slate-300 whitespace-nowrap">{alert.timestamp}</td>
                      <td className="p-4 font-mono text-cyan-400 flex items-center gap-1.5">
                        <Cpu className="w-3.5 h-3.5 text-slate-500" />
                        {alert.deviceId}
                      </td>
                      <td className="p-4 font-mono text-slate-200">{alert.processName}</td>
                      <td className="p-4">
                        <span className="bg-slate-800 text-slate-300 border border-slate-700 px-2 py-1 rounded text-xs">
                          {alert.eventType}
                        </span>
                      </td>
                      <td className="p-4 font-mono">
                        <span className={alert.anomalyScore > 0.5 ? 'text-rose-400 font-bold' : 'text-slate-400'}>
                          {alert.anomalyScore}
                        </span>
                      </td>
                      <td className="p-4">
                        <span className={`px-2.5 py-1 rounded-full text-xs font-bold tracking-wide border ${
                          alert.severity === 'HIGH' 
                            ? 'bg-rose-950/60 text-rose-400 border-rose-800/60' 
                            : 'bg-emerald-950/60 text-emerald-400 border-emerald-800/60'
                        }`}>
                          {alert.severity}
                        </span>
                      </td>
                      <td className="p-4 text-slate-400 text-xs max-w-xs truncate" title={alert.rawDetail}>
                        {alert.rawDetail}
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </div>

      </main>
    </div>
  );
}