#This script gets the CPUTime for each BizTalk service and exports it to C:\ESB\Tools\HostInstancesCPUTime.json
$i = 0
DO {
$i++
$servicepid = Get-CimInstance -ClassName win32_service | Where-Object "State" -like 'Running' | Where-Object "Name" -like 'BTS*'| Select ProcessId, Name
$process = gwmi Win32_PerfFormattedData_PerfProc_Process

[System.Collections.ArrayList]$ArrayWithHeader = @()


ForEach ($spid in $servicepid.processid) {
$servicepid | Where-Object "ProcessId" -like $spid | Select ProcessId, Name | Out-Null
$pprocess = $process | Where-Object -Property "IdProcess" -Like $spid | Select PercentProcessorTime
$pname = $servicepid | Where-Object "ProcessId" -like $spid | Select Name
$ppid = $servicepid | Where-Object "ProcessId" -like $spid | Select ProcessId

$values = [pscustomobject] @{
   'Name' = $pname.Name; 'ProcessId' = $ppid.ProcessId; 'CPUTime' = $pprocess.PercentProcessorTime
}
$ArrayWithHeader.Add($values) | Out-Null
}
$ArrayWithHeader | ConvertTo-Json  | Out-File "C:\ESB\Tools\HostInstancesCPUTime.json" -Encoding ascii -Force

Start-Sleep -Seconds 25
} While ($i -le 8)