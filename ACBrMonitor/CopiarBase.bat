echo OFF
robocopy c:\acbrmonitor\base c:\acbrmonitor\%1 /e
REN c:\acbrmonitor\%1\ACBrMonitor.exe ACBrMonitor_%1.exe