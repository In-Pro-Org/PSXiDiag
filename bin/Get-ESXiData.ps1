
Import-Module VMware.VimAutomation.Core -MinimumVersion 13.4

#region Connect to vCenter Server
$VIServer = 'at-kl-vcenter.kostweingroup.intern'
#$VICredential = Get-Credential
Connect-VIServer $VIServer #-Credential $VICredential
#endregion

#region Get ESXiHosts
$DataCenter = 'Kostwein'
$vmHosts = Get-VMHost -Location $DataCenter | Sort-Object -Property Name

$Locations = @{
    'AT-KL' = 'Klagenfurt'
    'AT-VK' = 'Völkermarkt'
    'HR-TR' = 'Trnovec'
    'HR-VA' = 'Varazdin'
    'IN-AB' = 'Ahmedabad'
    'IT-UD' = 'Udine'
    'US-GR' = 'Greenville'
}

$ESXiServer = foreach ($node in $vmHosts) {

    $LocationKey = $Locations.Keys | Where-Object { $vmHosts[0].Name -imatch "^$_" }
    $Location = $Locations.$LocationKey

    [PSCustomObject]@{
        Id               = $node.Id
        HostName         = $node.Name
        Version          = $node.Version
        Manufacturer     = $node.Manufacturer
        Model            = $node.Model
        vCenterServer    = $VIServer
        Cluster          = $Parent
        PhysicalLocation = $Location
        ConnectionState  = $node.ConnectionState
        Notes            = ''
    }

    $VMs = foreach ($VM in $node.ExtensionData.Vm) {
        [PSCustomObject]@{
            Id       = $VM.Value
            HostName = ''
        }
    }

    $DataStores = foreach ($Store in $node.ExtensionData.Datastore) {
        [PSCustomObject]@{
            Id   = $Store.Value
            Name = ''
        }
    }

    $NetworkInfo = [PSCustomObject]@{
        Id       = $node.NetworkInfo.Id
        Name     = $node.NetworkInfo.Name
        HostName = $node.NetworkInfo.HostName
        VMHostId = $node.NetworkInfo.VMHostId
    }

    $StorageInfo = [PSCustomObject]@{
        Id       = $node.StorageInfo.Id
        Name     = $node.StorageInfo.Name
        VMHostId = $node.StorageInfo.VMHostId
    }
    
}

$ESXiServer | ConvertTo-Csv -Delimiter ';' | Out-File ".\..\data\KOW_ESXiHosts.csv" -Encoding UTF8 -Force



##########################################################################################


foreach ($node in $vmHosts) {
    [PSCustomObject]@{
        HostName         = $node.Name
        Version          = $node.Version
        Manufacturer     = ''
        Model            = ''
        vCenterServer    = ''
        Cluster          = ''
        PhysicalLocation = ''
        ConnectionState  = ''
        Notes            = ''
    }
}

[PSCustomObject]@{
    Name          = $_.Name
    VMName        = $IXVMProperties.VMName
    Version       = $_.Version
    Build         = $_.Build
    BootTime      = $IXVMProperties.BootTime
    IsConnected   = $_.IsConnected
    PowerState    = $IXVMProperties.PowerState
    OverallStatus = $IXVMProperties.OverallStatus
    IPv4Addresses = $IXVMProperties.'IP Addresses'
    CPUs          = $IXVMProperties.CPUs
    Memory        = $IXVMProperties.Memory
    ESXiHost      = $IXVMProperties.Host
    Cluster       = $IXVMProperties.ClusterName
    Datastore     = $IXVMProperties.DatastoreName
    Notes         = $IXVMProperties.Notes
}
#endregion
