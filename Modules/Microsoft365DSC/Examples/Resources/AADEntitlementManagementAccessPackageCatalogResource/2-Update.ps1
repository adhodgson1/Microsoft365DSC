<#
This example is used to test new resources and showcase the usage of new resources being worked on.
It is not meant to use as a production baseline.
#>

Configuration Example
{
    param(
        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.String]
        $CertificateThumbprint
    )
    Import-DscResource -ModuleName Microsoft365DSC

    node localhost
    {
        AADGroup 'DependantGroup'
        {
            DisplayName     = "MyGroup"
            Description     = "Microsoft DSC Group"
            SecurityEnabled = $True
            MailEnabled     = $True
            GroupTypes      = @("Unified")
            MailNickname    = "MyGroup"
            Visibility      = "Private"
            Owners          = @("admin@$TenantId", "AdeleV@$TenantId")
            Ensure          = "Present"
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            CertificateThumbprint = $CertificateThumbprint
        }
        AADEntitlementManagementAccessPackageCatalogResource 'myAccessPackageCatalogResource'
        {
            ApplicationId         = $ApplicationId;
            CatalogId             = "My Catalog";
            CertificateThumbprint = $CertificateThumbprint;
            DisplayName           = "DSCGroup";
            OriginSystem          = "AADGroup";
            OriginId              = '849b3661-61a8-44a8-92e7-fcc91d296235'
            Ensure                = "Present";
            IsPendingOnboarding   = $False;
            TenantId              = $TenantId;
        }
    }
}
