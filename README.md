# Zabbix-BizTalk-HostInstanceCPUTime
This is a script and a Zabbix Template to get the CPU Time for each Host Instance on a BizTalk server.

Installation:

1. Create ```C:\ESB\Tools``` on your BizTalk server(s)

(This path can be changed, but remember to update both the script output and the ```vfs.file.contents``` items in the template)

2. Create a scheduled task that runs ```powershell.exe -ExecutionPolicy Bypass "<path>\HostInstanceCPUTime.ps1"``` at some point on the day, and repeats every 5 minutes for the duration of 1 day.

3. Import the template to your Zabbix server

4. Link the template to your BizTalk server(s)


BizTalk is a bit weird with the services, where all the Host Instances get run with the same exe-name.
Example: ```BTSNTSvc64.exe```
To work around this, the script fetches the PID of the BizTalk Host Instance service name, and then gets the CPU Time for each PID.
