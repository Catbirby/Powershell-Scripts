## This script attempts to fix the "No Internet" while actually having internet 
## issue on windows 10 by changing the server the computer contacts to decide 
## if it has internet or not. This script is intended to be used as a login script.

$DnsProbeValue = Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet" -Name "ActiveDnsProbeContent"

if ("8.8.4.4" -eq $DnsProbeValue.ActiveDnsProbeContent) {
    Write-Output "The DNS settings are set correctly, exiting script"
    exit
} else {
    Write-Output "Changing Values. . ."
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet" -Name "ActiveDnsProbeContent" -Value "8.8.4.4"
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet" -Name "ActiveDnsProbeContentV6" -Value "2001:4860:4860::8844"
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet" -Name "ActiveDnsProbeHost" -Value "dns.google"
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet" -Name "ActiveDnsProbeHostV6" -Value "dns.google"
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet" -Name "ActiveWebProbeContent" -Value "Microsoft Connect Test"
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet" -Name "ActiveWebProbeContentV6" -Value "Microsoft Connect Test"
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet" -Name "ActiveWebProbeHost" -Value "www.msftconnecttest.com"
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet" -Name "ActiveWebProbeHostV6" -Value "ipv6.msftconnecttest.com"
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet" -Name "EnableActiveProbing" -Value 00000001
    Write-Output "Values Changed"
    exit
}