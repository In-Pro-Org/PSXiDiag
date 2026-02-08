@{
    Server = @{
        AutoImport = @{
            Modules = @{
                Enable     = $true
                ExportOnly = $true
            }
            Snapins = @{
                Enable = $false
            }
            # Functions = @{
            #     Enable = $true
            # }
        }
    }
    Web = @{
        Static = @{
            Cache = @{
                Enable = $true
            }
        }
    }
    DebugLevel  = 'Info'
    PSModules   = 'PSHTML', 'mySQLite', 'Pode', 'Pode.Web'
    Modules = @(
        @{ ModuleName = 'Pode'; RequiredVersion = '2.12.1' }
        @{ ModuleName = 'Pode.Web'; RequiredVersion = '0.8.3' }
        @{ ModuleName = 'PSHTML'; RequiredVersion = '0.8.2' }
        @{ ModuleName = 'mySQLite'; RequiredVersion = '1.0.0' }
    )
    PSXi = @{
        AppName = 'PSXi App'
        Version = '1.1.6'
        Group1  = 'Classic'
        Group2  = 'Cloud'
        Group3  = 'Hyper-V'
        Tables  = @(
            'classic_summary'
            'cloud_summary'
            'classic_ESXiHosts'
            'cloud_ESXiHosts'
            'classic_ESXiHostsNotes'
            'cloud_ESXiHostsNotes'
            'classic_Datastores'
            'cloud_Datastores'
            'hyperv_SCVMHosts'
        )
        Views = @(
            'view_classic_ESXiHosts'
            'view_cloud_ESXiHosts'
            'view_hyperv_SCVMHosts'
        )
        # VMware
        vmwESXiHeader = @(
            'HostName'
            'Manufacturer'
            'Model'
            'Version'
            # 'Cluster'
            'PhysicalLocation'
            'ConnectionState'
            'Notes'
        )
        # VMware
        vmwDatastoreHeader = @(
            # 'vCenterServer'
            # 'DatastoreCluster'
            'DatastoreName'
            'DatastoreFolder'
            'ClusterStatus'
            # 'Type'
            'CapacityGB'
            'FreeSpaceGB'
            'Free'
        )
        # VMware
        vmwNetworkHeader = @(
            'vCenterServer'
            'NetworkName'
            'NetworkType'
            'NetworkFolder'
            'VDSwitch'
            'NetworkStatus'
        )
        # Hyper-V
        hvHostHeader = @(
            'HostName'
            'Manufacturer'
            'Model'
            'Version'
            # 'VMMServer'
            # 'Cluster'
            'PhysicalLocation'
            'HyperVState'
            'Notes'
        )
    }
    PodeCfg    = @{
        HttpPort       = 5989
        HttpUrl        = 'localhost'
        CertThumbprint = ''
        HttpsEnabled   = $false
    }
    Cache      = @{
        Name               = 'PXFileCache'
        FilePath           = './px-cache.json'
        SQL                = 'PXSQLCache'
        ModulesTTLSeconds  = 30
        CommandsTTLSeconds = 300
        HelpTTLSeconds     = 86400
    }
    Podex      = @{
        Debug        = $true
        DatabaseType = 'SQLite'
        DBFile       = './podex.db'
    }
    Logging    = @{
        Path = ".logs"
    }
}
