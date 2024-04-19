function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        #region resource generator code
        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $AddIns,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $Api,

        [Parameter()]
        [System.String]
        $AppId,

        [Parameter()]
        [System.String]
        $ApplicationTemplateId,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $AppRoles,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $Certification,

        [Parameter()]
        [System.String]
        $DefaultRedirectUri,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.String]
        $DisabledByMicrosoftStatus,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $GroupMembershipClaims,

        [Parameter()]
        [System.String[]]
        $IdentifierUris,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $Info,

        [Parameter()]
        [System.Boolean]
        $IsDeviceOnlyAuthSupported,

        [Parameter()]
        [System.Boolean]
        $IsFallbackPublicClient,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $KeyCredentials,

        [Parameter()]
        [System.Stream]
        $Logo,

        [Parameter()]
        [System.String]
        $Notes,

        [Parameter()]
        [System.Boolean]
        $Oauth2RequirePostResponse,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $OptionalClaims,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ParentalControlSettings,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $PasswordCredentials,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $PublicClient,

        [Parameter()]
        [System.String]
        $PublisherDomain,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $RequestSignatureVerification,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $RequiredResourceAccess,

        [Parameter()]
        [System.String]
        $SamlMetadataUrl,

        [Parameter()]
        [System.String]
        $ServiceManagementReference,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ServicePrincipalLockConfiguration,

        [Parameter()]
        [System.String]
        $SignInAudience,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $Spa,

        [Parameter()]
        [System.String[]]
        $Tags,

        [Parameter()]
        [System.Guid]
        $TokenEncryptionKeyId,

        [Parameter()]
        [System.String]
        $UniqueName,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $VerifiedPublisher,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $Web,

        [Parameter()]
        [System.String]
        $DeletedDateTime,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Id,

        #endregion

        [Parameter()]
        [System.String]
        [ValidateSet('Absent', 'Present')]
        $Ensure = 'Present',

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $ApplicationSecret,

        [Parameter()]
        [System.String]
        $CertificateThumbprint,

        [Parameter()]
        [Switch]
        $ManagedIdentity
    )

    try
    {
        $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftGraph' `
            -InboundParameters $PSBoundParameters

        #Ensure the proper dependencies are installed in the current environment.
        Confirm-M365DSCDependencies

        #region Telemetry
        $ResourceName = $MyInvocation.MyCommand.ModuleName.Replace('MSFT_', '')
        $CommandName = $MyInvocation.MyCommand
        $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
            -CommandName $CommandName `
            -Parameters $PSBoundParameters
        Add-M365DSCTelemetryEvent -Data $data
        #endregion

        $nullResult = $PSBoundParameters
        $nullResult.Ensure = 'Absent'

        $getValue = $null
        #region resource generator code
        $getValue = Get-MgApplication -ApplicationId $Id  -ErrorAction SilentlyContinue

        if ($null -eq $getValue)
        {
            Write-Verbose -Message "Could not find an Azure AD Application with Id {$Id}"

            if (-Not [string]::IsNullOrEmpty($DisplayName))
            {
                $getValue = Get-MgApplication `
                    -Filter "DisplayName eq '$DisplayName'" `
                    -ErrorAction SilentlyContinue | Where-Object `
                    -FilterScript { `
                        $_.AdditionalProperties.'@odata.type' -eq "#microsoft.graph.Application" `
                    }
            }
        }
        #endregion
        if ($null -eq $getValue)
        {
            Write-Verbose -Message "Could not find an Azure AD Application with DisplayName {$DisplayName}"
            return $nullResult
        }
        $Id = $getValue.Id
        Write-Verbose -Message "An Azure AD Application with Id {$Id} and DisplayName {$DisplayName} was found."

        #region resource generator code
        $complexAddIns = @()
        foreach ($currentaddIns in $getValue.AdditionalProperties.addIns)
        {
            $myaddIns = @{}
            $myaddIns.Add('Id', $currentaddIns.id)
            $complexProperties = @()
            foreach ($currentProperties in $currentaddIns.properties)
            {
                $myProperties = @{}
                $myProperties.Add('Key', $currentProperties.key)
                $myProperties.Add('Value', $currentProperties.value)
                if ($myProperties.values.Where({$null -ne $_}).count -gt 0)
                {
                    $complexProperties += $myProperties
                }
            }
            $myaddIns.Add('Properties',$complexProperties)
            $myaddIns.Add('Type', $currentaddIns.type)
            if ($myaddIns.values.Where({$null -ne $_}).count -gt 0)
            {
                $complexAddIns += $myaddIns
            }
        }

        $complexApi = @{}
        $complexApi.Add('AcceptMappedClaims', $getValue.AdditionalProperties.api.acceptMappedClaims)
        $complexApi.Add('KnownClientApplications', $getValue.AdditionalProperties.api.knownClientApplications)
        $complexOauth2PermissionScopes = @()
        foreach ($currentOauth2PermissionScopes in $getValue.AdditionalProperties.api.oauth2PermissionScopes)
        {
            $myOauth2PermissionScopes = @{}
            $myOauth2PermissionScopes.Add('AdminConsentDescription', $currentOauth2PermissionScopes.adminConsentDescription)
            $myOauth2PermissionScopes.Add('AdminConsentDisplayName', $currentOauth2PermissionScopes.adminConsentDisplayName)
            $myOauth2PermissionScopes.Add('Id', $currentOauth2PermissionScopes.id)
            $myOauth2PermissionScopes.Add('IsEnabled', $currentOauth2PermissionScopes.isEnabled)
            $myOauth2PermissionScopes.Add('Origin', $currentOauth2PermissionScopes.origin)
            $myOauth2PermissionScopes.Add('Type', $currentOauth2PermissionScopes.type)
            $myOauth2PermissionScopes.Add('UserConsentDescription', $currentOauth2PermissionScopes.userConsentDescription)
            $myOauth2PermissionScopes.Add('UserConsentDisplayName', $currentOauth2PermissionScopes.userConsentDisplayName)
            $myOauth2PermissionScopes.Add('Value', $currentOauth2PermissionScopes.value)
            if ($myOauth2PermissionScopes.values.Where({$null -ne $_}).count -gt 0)
            {
                $complexOauth2PermissionScopes += $myOauth2PermissionScopes
            }
        }
        $complexApi.Add('Oauth2PermissionScopes',$complexOauth2PermissionScopes)
        $complexPreAuthorizedApplications = @()
        foreach ($currentPreAuthorizedApplications in $getValue.AdditionalProperties.api.preAuthorizedApplications)
        {
            $myPreAuthorizedApplications = @{}
            $myPreAuthorizedApplications.Add('AppId', $currentPreAuthorizedApplications.appId)
            $myPreAuthorizedApplications.Add('DelegatedPermissionIds', $currentPreAuthorizedApplications.delegatedPermissionIds)
            if ($myPreAuthorizedApplications.values.Where({$null -ne $_}).count -gt 0)
            {
                $complexPreAuthorizedApplications += $myPreAuthorizedApplications
            }
        }
        $complexApi.Add('PreAuthorizedApplications',$complexPreAuthorizedApplications)
        $complexApi.Add('RequestedAccessTokenVersion', $getValue.AdditionalProperties.api.requestedAccessTokenVersion)
        if ($complexApi.values.Where({$null -ne $_}).count -eq 0)
        {
            $complexApi = $null
        }

        $complexAppRoles = @()
        foreach ($currentappRoles in $getValue.AdditionalProperties.appRoles)
        {
            $myappRoles = @{}
            $myappRoles.Add('AllowedMemberTypes', $currentappRoles.allowedMemberTypes)
            $myappRoles.Add('Description', $currentappRoles.description)
            $myappRoles.Add('DisplayName', $currentappRoles.displayName)
            $myappRoles.Add('Id', $currentappRoles.id)
            $myappRoles.Add('IsEnabled', $currentappRoles.isEnabled)
            $myappRoles.Add('Origin', $currentappRoles.origin)
            $myappRoles.Add('Value', $currentappRoles.value)
            if ($myappRoles.values.Where({$null -ne $_}).count -gt 0)
            {
                $complexAppRoles += $myappRoles
            }
        }

        $complexCertification = @{}
        $complexCertification.Add('CertificationDetailsUrl', $getValue.AdditionalProperties.certification.certificationDetailsUrl)
        if ($null -ne $getValue.AdditionalProperties.certification.certificationExpirationDateTime)
        {
            $complexCertification.Add('CertificationExpirationDateTime', ([DateTimeOffset]$getValue.AdditionalProperties.certification.certificationExpirationDateTime).ToString('o'))
        }
        $complexCertification.Add('IsCertifiedByMicrosoft', $getValue.AdditionalProperties.certification.isCertifiedByMicrosoft)
        $complexCertification.Add('IsPublisherAttested', $getValue.AdditionalProperties.certification.isPublisherAttested)
        if ($null -ne $getValue.AdditionalProperties.certification.lastCertificationDateTime)
        {
            $complexCertification.Add('LastCertificationDateTime', ([DateTimeOffset]$getValue.AdditionalProperties.certification.lastCertificationDateTime).ToString('o'))
        }
        if ($complexCertification.values.Where({$null -ne $_}).count -eq 0)
        {
            $complexCertification = $null
        }

        $complexInfo = @{}
        $complexInfo.Add('LogoUrl', $getValue.AdditionalProperties.info.logoUrl)
        $complexInfo.Add('MarketingUrl', $getValue.AdditionalProperties.info.marketingUrl)
        $complexInfo.Add('PrivacyStatementUrl', $getValue.AdditionalProperties.info.privacyStatementUrl)
        $complexInfo.Add('SupportUrl', $getValue.AdditionalProperties.info.supportUrl)
        $complexInfo.Add('TermsOfServiceUrl', $getValue.AdditionalProperties.info.termsOfServiceUrl)
        if ($complexInfo.values.Where({$null -ne $_}).count -eq 0)
        {
            $complexInfo = $null
        }

        $complexKeyCredentials = @()
        foreach ($currentkeyCredentials in $getValue.AdditionalProperties.keyCredentials)
        {
            $mykeyCredentials = @{}
            $mykeyCredentials.Add('CustomKeyIdentifier', $currentkeyCredentials.customKeyIdentifier)
            $mykeyCredentials.Add('DisplayName', $currentkeyCredentials.displayName)
            if ($null -ne $currentkeyCredentials.endDateTime)
            {
                $mykeyCredentials.Add('EndDateTime', ([DateTimeOffset]$currentkeyCredentials.endDateTime).ToString('o'))
            }
            $mykeyCredentials.Add('Key', $currentkeyCredentials.key)
            $mykeyCredentials.Add('KeyId', $currentkeyCredentials.keyId)
            if ($null -ne $currentkeyCredentials.startDateTime)
            {
                $mykeyCredentials.Add('StartDateTime', ([DateTimeOffset]$currentkeyCredentials.startDateTime).ToString('o'))
            }
            $mykeyCredentials.Add('Type', $currentkeyCredentials.type)
            $mykeyCredentials.Add('Usage', $currentkeyCredentials.usage)
            if ($mykeyCredentials.values.Where({$null -ne $_}).count -gt 0)
            {
                $complexKeyCredentials += $mykeyCredentials
            }
        }

        $complexOptionalClaims = @{}
        $complexAccessToken = @()
        foreach ($currentAccessToken in $getValue.AdditionalProperties.optionalClaims.accessToken)
        {
            $myAccessToken = @{}
            $myAccessToken.Add('AdditionalProperties', $currentAccessToken.additionalProperties)
            $myAccessToken.Add('Essential', $currentAccessToken.essential)
            $myAccessToken.Add('Name', $currentAccessToken.name)
            $myAccessToken.Add('Source', $currentAccessToken.source)
            if ($myAccessToken.values.Where({$null -ne $_}).count -gt 0)
            {
                $complexAccessToken += $myAccessToken
            }
        }
        $complexOptionalClaims.Add('AccessToken',$complexAccessToken)
        $complexIdToken = @()
        foreach ($currentIdToken in $getValue.AdditionalProperties.optionalClaims.idToken)
        {
            $myIdToken = @{}
            $myIdToken.Add('AdditionalProperties', $currentIdToken.additionalProperties)
            $myIdToken.Add('Essential', $currentIdToken.essential)
            $myIdToken.Add('Name', $currentIdToken.name)
            $myIdToken.Add('Source', $currentIdToken.source)
            if ($myIdToken.values.Where({$null -ne $_}).count -gt 0)
            {
                $complexIdToken += $myIdToken
            }
        }
        $complexOptionalClaims.Add('IdToken',$complexIdToken)
        $complexSaml2Token = @()
        foreach ($currentSaml2Token in $getValue.AdditionalProperties.optionalClaims.saml2Token)
        {
            $mySaml2Token = @{}
            $mySaml2Token.Add('AdditionalProperties', $currentSaml2Token.additionalProperties)
            $mySaml2Token.Add('Essential', $currentSaml2Token.essential)
            $mySaml2Token.Add('Name', $currentSaml2Token.name)
            $mySaml2Token.Add('Source', $currentSaml2Token.source)
            if ($mySaml2Token.values.Where({$null -ne $_}).count -gt 0)
            {
                $complexSaml2Token += $mySaml2Token
            }
        }
        $complexOptionalClaims.Add('Saml2Token',$complexSaml2Token)
        if ($complexOptionalClaims.values.Where({$null -ne $_}).count -eq 0)
        {
            $complexOptionalClaims = $null
        }

        $complexParentalControlSettings = @{}
        $complexParentalControlSettings.Add('CountriesBlockedForMinors', $getValue.AdditionalProperties.parentalControlSettings.countriesBlockedForMinors)
        $complexParentalControlSettings.Add('LegalAgeGroupRule', $getValue.AdditionalProperties.parentalControlSettings.legalAgeGroupRule)
        if ($complexParentalControlSettings.values.Where({$null -ne $_}).count -eq 0)
        {
            $complexParentalControlSettings = $null
        }

        $complexPasswordCredentials = @()
        foreach ($currentpasswordCredentials in $getValue.AdditionalProperties.passwordCredentials)
        {
            $mypasswordCredentials = @{}
            $mypasswordCredentials.Add('CustomKeyIdentifier', $currentpasswordCredentials.customKeyIdentifier)
            $mypasswordCredentials.Add('DisplayName', $currentpasswordCredentials.displayName)
            if ($null -ne $currentpasswordCredentials.endDateTime)
            {
                $mypasswordCredentials.Add('EndDateTime', ([DateTimeOffset]$currentpasswordCredentials.endDateTime).ToString('o'))
            }
            $mypasswordCredentials.Add('Hint', $currentpasswordCredentials.hint)
            $mypasswordCredentials.Add('KeyId', $currentpasswordCredentials.keyId)
            $mypasswordCredentials.Add('SecretText', $currentpasswordCredentials.secretText)
            if ($null -ne $currentpasswordCredentials.startDateTime)
            {
                $mypasswordCredentials.Add('StartDateTime', ([DateTimeOffset]$currentpasswordCredentials.startDateTime).ToString('o'))
            }
            if ($mypasswordCredentials.values.Where({$null -ne $_}).count -gt 0)
            {
                $complexPasswordCredentials += $mypasswordCredentials
            }
        }

        $complexPublicClient = @{}
        $complexPublicClient.Add('RedirectUris', $getValue.AdditionalProperties.publicClient.redirectUris)
        if ($complexPublicClient.values.Where({$null -ne $_}).count -eq 0)
        {
            $complexPublicClient = $null
        }

        $complexRequestSignatureVerification = @{}
        if ($null -ne $getValue.AdditionalProperties.requestSignatureVerification.allowedWeakAlgorithms)
        {
            $complexRequestSignatureVerification.Add('AllowedWeakAlgorithms', $getValue.AdditionalProperties.requestSignatureVerification.allowedWeakAlgorithms.toString())
        }
        $complexRequestSignatureVerification.Add('IsSignedRequestRequired', $getValue.AdditionalProperties.requestSignatureVerification.isSignedRequestRequired)
        if ($complexRequestSignatureVerification.values.Where({$null -ne $_}).count -eq 0)
        {
            $complexRequestSignatureVerification = $null
        }

        $complexRequiredResourceAccess = @()
        foreach ($currentrequiredResourceAccess in $getValue.AdditionalProperties.requiredResourceAccess)
        {
            $myrequiredResourceAccess = @{}
            $complexResourceAccess = @()
            foreach ($currentResourceAccess in $currentrequiredResourceAccess.resourceAccess)
            {
                $myResourceAccess = @{}
                $myResourceAccess.Add('Id', $currentResourceAccess.id)
                $myResourceAccess.Add('Type', $currentResourceAccess.type)
                if ($myResourceAccess.values.Where({$null -ne $_}).count -gt 0)
                {
                    $complexResourceAccess += $myResourceAccess
                }
            }
            $myrequiredResourceAccess.Add('ResourceAccess',$complexResourceAccess)
            $myrequiredResourceAccess.Add('ResourceAppId', $currentrequiredResourceAccess.resourceAppId)
            if ($myrequiredResourceAccess.values.Where({$null -ne $_}).count -gt 0)
            {
                $complexRequiredResourceAccess += $myrequiredResourceAccess
            }
        }

        $complexServicePrincipalLockConfiguration = @{}
        $complexServicePrincipalLockConfiguration.Add('AllProperties', $getValue.AdditionalProperties.servicePrincipalLockConfiguration.allProperties)
        $complexServicePrincipalLockConfiguration.Add('CredentialsWithUsageSign', $getValue.AdditionalProperties.servicePrincipalLockConfiguration.credentialsWithUsageSign)
        $complexServicePrincipalLockConfiguration.Add('CredentialsWithUsageVerify', $getValue.AdditionalProperties.servicePrincipalLockConfiguration.credentialsWithUsageVerify)
        $complexServicePrincipalLockConfiguration.Add('IsEnabled', $getValue.AdditionalProperties.servicePrincipalLockConfiguration.isEnabled)
        $complexServicePrincipalLockConfiguration.Add('TokenEncryptionKeyId', $getValue.AdditionalProperties.servicePrincipalLockConfiguration.tokenEncryptionKeyId)
        if ($complexServicePrincipalLockConfiguration.values.Where({$null -ne $_}).count -eq 0)
        {
            $complexServicePrincipalLockConfiguration = $null
        }

        $complexSpa = @{}
        $complexSpa.Add('RedirectUris', $getValue.AdditionalProperties.spa.redirectUris)
        if ($complexSpa.values.Where({$null -ne $_}).count -eq 0)
        {
            $complexSpa = $null
        }

        $complexVerifiedPublisher = @{}
        if ($null -ne $getValue.AdditionalProperties.verifiedPublisher.addedDateTime)
        {
            $complexVerifiedPublisher.Add('AddedDateTime', ([DateTimeOffset]$getValue.AdditionalProperties.verifiedPublisher.addedDateTime).ToString('o'))
        }
        $complexVerifiedPublisher.Add('DisplayName', $getValue.AdditionalProperties.verifiedPublisher.displayName)
        $complexVerifiedPublisher.Add('VerifiedPublisherId', $getValue.AdditionalProperties.verifiedPublisher.verifiedPublisherId)
        if ($complexVerifiedPublisher.values.Where({$null -ne $_}).count -eq 0)
        {
            $complexVerifiedPublisher = $null
        }

        $complexWeb = @{}
        $complexWeb.Add('HomePageUrl', $getValue.AdditionalProperties.web.homePageUrl)
        $complexImplicitGrantSettings = @{}
        $complexImplicitGrantSettings.Add('EnableAccessTokenIssuance', $getValue.additionalProperties.web.implicitGrantSettings.enableAccessTokenIssuance)
        $complexImplicitGrantSettings.Add('EnableIdTokenIssuance', $getValue.additionalProperties.web.implicitGrantSettings.enableIdTokenIssuance)
        if ($complexImplicitGrantSettings.values.Where({$null -ne $_}).count -eq 0)
        {
            $complexImplicitGrantSettings = $null
        }
        $complexWeb.Add('ImplicitGrantSettings',$complexImplicitGrantSettings)
        $complexWeb.Add('LogoutUrl', $getValue.AdditionalProperties.web.logoutUrl)
        $complexWeb.Add('RedirectUris', $getValue.AdditionalProperties.web.redirectUris)
        $complexRedirectUriSettings = @()
        foreach ($currentRedirectUriSettings in $getValue.AdditionalProperties.web.redirectUriSettings)
        {
            $myRedirectUriSettings = @{}
            $myRedirectUriSettings.Add('Index', $currentRedirectUriSettings.index)
            $myRedirectUriSettings.Add('Uri', $currentRedirectUriSettings.uri)
            if ($myRedirectUriSettings.values.Where({$null -ne $_}).count -gt 0)
            {
                $complexRedirectUriSettings += $myRedirectUriSettings
            }
        }
        $complexWeb.Add('RedirectUriSettings',$complexRedirectUriSettings)
        if ($complexWeb.values.Where({$null -ne $_}).count -eq 0)
        {
            $complexWeb = $null
        }
        #endregion

        #region resource generator code
        $dateDeletedDateTime = $null
        if ($null -ne $getValue.DeletedDateTime)
        {
            $dateDeletedDateTime = ([DateTimeOffset]$getValue.DeletedDateTime).ToString('o')
        }
        #endregion

        $results = @{
            #region resource generator code
            AddIns                            = $complexAddIns
            Api                               = $complexApi
            AppId                             = $getValue.AdditionalProperties.appId
            ApplicationTemplateId             = $getValue.AdditionalProperties.applicationTemplateId
            AppRoles                          = $complexAppRoles
            Certification                     = $complexCertification
            DefaultRedirectUri                = $getValue.AdditionalProperties.defaultRedirectUri
            Description                       = $getValue.AdditionalProperties.description
            DisabledByMicrosoftStatus         = $getValue.AdditionalProperties.disabledByMicrosoftStatus
            DisplayName                       = $getValue.AdditionalProperties.displayName
            GroupMembershipClaims             = $getValue.AdditionalProperties.groupMembershipClaims
            IdentifierUris                    = $getValue.AdditionalProperties.identifierUris
            Info                              = $complexInfo
            IsDeviceOnlyAuthSupported         = $getValue.AdditionalProperties.isDeviceOnlyAuthSupported
            IsFallbackPublicClient            = $getValue.AdditionalProperties.isFallbackPublicClient
            KeyCredentials                    = $complexKeyCredentials
            Logo                              = $getValue.AdditionalProperties.logo
            Notes                             = $getValue.AdditionalProperties.notes
            Oauth2RequirePostResponse         = $getValue.AdditionalProperties.oauth2RequirePostResponse
            OptionalClaims                    = $complexOptionalClaims
            ParentalControlSettings           = $complexParentalControlSettings
            PasswordCredentials               = $complexPasswordCredentials
            PublicClient                      = $complexPublicClient
            PublisherDomain                   = $getValue.AdditionalProperties.publisherDomain
            RequestSignatureVerification      = $complexRequestSignatureVerification
            RequiredResourceAccess            = $complexRequiredResourceAccess
            SamlMetadataUrl                   = $getValue.AdditionalProperties.samlMetadataUrl
            ServiceManagementReference        = $getValue.AdditionalProperties.serviceManagementReference
            ServicePrincipalLockConfiguration = $complexServicePrincipalLockConfiguration
            SignInAudience                    = $getValue.AdditionalProperties.signInAudience
            Spa                               = $complexSpa
            Tags                              = $getValue.AdditionalProperties.tags
            TokenEncryptionKeyId              = $getValue.AdditionalProperties.tokenEncryptionKeyId
            UniqueName                        = $getValue.AdditionalProperties.uniqueName
            VerifiedPublisher                 = $complexVerifiedPublisher
            Web                               = $complexWeb
            DeletedDateTime                   = $dateDeletedDateTime
            Id                                = $getValue.Id
            Ensure                            = 'Present'
            Credential                        = $Credential
            ApplicationId                     = $ApplicationId
            TenantId                          = $TenantId
            ApplicationSecret                 = $ApplicationSecret
            CertificateThumbprint             = $CertificateThumbprint
            Managedidentity                   = $ManagedIdentity.IsPresent
            #endregion
        }

        return [System.Collections.Hashtable] $results
    }
    catch
    {
        New-M365DSCLogEntry -Message 'Error retrieving data:' `
            -Exception $_ `
            -Source $($MyInvocation.MyCommand.Source) `
            -TenantId $TenantId `
            -Credential $Credential

        return $nullResult
    }
}

function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        #region resource generator code
        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $AddIns,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $Api,

        [Parameter()]
        [System.String]
        $AppId,

        [Parameter()]
        [System.String]
        $ApplicationTemplateId,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $AppRoles,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $Certification,

        [Parameter()]
        [System.String]
        $DefaultRedirectUri,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.String]
        $DisabledByMicrosoftStatus,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $GroupMembershipClaims,

        [Parameter()]
        [System.String[]]
        $IdentifierUris,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $Info,

        [Parameter()]
        [System.Boolean]
        $IsDeviceOnlyAuthSupported,

        [Parameter()]
        [System.Boolean]
        $IsFallbackPublicClient,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $KeyCredentials,

        [Parameter()]
        [System.Stream]
        $Logo,

        [Parameter()]
        [System.String]
        $Notes,

        [Parameter()]
        [System.Boolean]
        $Oauth2RequirePostResponse,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $OptionalClaims,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ParentalControlSettings,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $PasswordCredentials,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $PublicClient,

        [Parameter()]
        [System.String]
        $PublisherDomain,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $RequestSignatureVerification,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $RequiredResourceAccess,

        [Parameter()]
        [System.String]
        $SamlMetadataUrl,

        [Parameter()]
        [System.String]
        $ServiceManagementReference,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ServicePrincipalLockConfiguration,

        [Parameter()]
        [System.String]
        $SignInAudience,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $Spa,

        [Parameter()]
        [System.String[]]
        $Tags,

        [Parameter()]
        [System.Guid]
        $TokenEncryptionKeyId,

        [Parameter()]
        [System.String]
        $UniqueName,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $VerifiedPublisher,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $Web,

        [Parameter()]
        [System.String]
        $DeletedDateTime,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Id,

        #endregion
        [Parameter()]
        [System.String]
        [ValidateSet('Absent', 'Present')]
        $Ensure = 'Present',

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $ApplicationSecret,

        [Parameter()]
        [System.String]
        $CertificateThumbprint,

        [Parameter()]
        [Switch]
        $ManagedIdentity
    )

    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName.Replace('MSFT_', '')
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    $currentInstance = Get-TargetResource @PSBoundParameters

    $BoundParameters = Remove-M365DSCAuthenticationParameter -BoundParameters $PSBoundParameters

    if ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Absent')
    {
        Write-Verbose -Message "Creating an Azure AD Application with DisplayName {$DisplayName}"

        $CreateParameters = ([Hashtable]$BoundParameters).clone()
        $CreateParameters = Rename-M365DSCCimInstanceParameter -Properties $CreateParameters
        $CreateParameters.Remove('Id') | Out-Null

        $keys = (([Hashtable]$CreateParameters).clone()).Keys
        foreach ($key in $keys)
        {
            if ($null -ne $CreateParameters.$key -and $CreateParameters.$key.getType().Name -like '*cimInstance*')
            {
                $CreateParameters.$key = Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $CreateParameters.$key
            }
        }
        #region resource generator code
        $CreateParameters.Add("@odata.type", "#microsoft.graph.Application")
        $policy = New-MgApplication -BodyParameter $CreateParameters
        #endregion
    }
    elseif ($Ensure -eq 'Present' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Updating the Azure AD Application with Id {$($currentInstance.Id)}"

        $UpdateParameters = ([Hashtable]$BoundParameters).clone()
        $UpdateParameters = Rename-M365DSCCimInstanceParameter -Properties $UpdateParameters

        $UpdateParameters.Remove('Id') | Out-Null

        $keys = (([Hashtable]$UpdateParameters).clone()).Keys
        foreach ($key in $keys)
        {
            if ($null -ne $UpdateParameters.$key -and $UpdateParameters.$key.getType().Name -like '*cimInstance*')
            {
                $UpdateParameters.$key = Convert-M365DSCDRGComplexTypeToHashtable -ComplexObject $UpdateParameters.$key
            }
        }
        #region resource generator code
        $UpdateParameters.Add("@odata.type", "#microsoft.graph.Application")
        Update-MgApplication  `
            -ApplicationId $currentInstance.Id `
            -BodyParameter $UpdateParameters
        #endregion
    }
    elseif ($Ensure -eq 'Absent' -and $currentInstance.Ensure -eq 'Present')
    {
        Write-Verbose -Message "Removing the Azure AD Application with Id {$($currentInstance.Id)}" 
        #region resource generator code
Remove-MgApplication -ApplicationId $currentInstance.Id
        #endregion
    }
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        #region resource generator code
        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $AddIns,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $Api,

        [Parameter()]
        [System.String]
        $AppId,

        [Parameter()]
        [System.String]
        $ApplicationTemplateId,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $AppRoles,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $Certification,

        [Parameter()]
        [System.String]
        $DefaultRedirectUri,

        [Parameter()]
        [System.String]
        $Description,

        [Parameter()]
        [System.String]
        $DisabledByMicrosoftStatus,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DisplayName,

        [Parameter()]
        [System.String]
        $GroupMembershipClaims,

        [Parameter()]
        [System.String[]]
        $IdentifierUris,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $Info,

        [Parameter()]
        [System.Boolean]
        $IsDeviceOnlyAuthSupported,

        [Parameter()]
        [System.Boolean]
        $IsFallbackPublicClient,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $KeyCredentials,

        [Parameter()]
        [System.Stream]
        $Logo,

        [Parameter()]
        [System.String]
        $Notes,

        [Parameter()]
        [System.Boolean]
        $Oauth2RequirePostResponse,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $OptionalClaims,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ParentalControlSettings,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $PasswordCredentials,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $PublicClient,

        [Parameter()]
        [System.String]
        $PublisherDomain,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $RequestSignatureVerification,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance[]]
        $RequiredResourceAccess,

        [Parameter()]
        [System.String]
        $SamlMetadataUrl,

        [Parameter()]
        [System.String]
        $ServiceManagementReference,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $ServicePrincipalLockConfiguration,

        [Parameter()]
        [System.String]
        $SignInAudience,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $Spa,

        [Parameter()]
        [System.String[]]
        $Tags,

        [Parameter()]
        [System.Guid]
        $TokenEncryptionKeyId,

        [Parameter()]
        [System.String]
        $UniqueName,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $VerifiedPublisher,

        [Parameter()]
        [Microsoft.Management.Infrastructure.CimInstance]
        $Web,

        [Parameter()]
        [System.String]
        $DeletedDateTime,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Id,

        #endregion

        [Parameter()]
        [System.String]
        [ValidateSet('Absent', 'Present')]
        $Ensure = 'Present',

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $ApplicationSecret,

        [Parameter()]
        [System.String]
        $CertificateThumbprint,

        [Parameter()]
        [Switch]
        $ManagedIdentity
    )

    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName.Replace('MSFT_', '')
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    Write-Verbose -Message "Testing configuration of the Azure AD Application with Id {$Id} and DisplayName {$DisplayName}"

    $CurrentValues = Get-TargetResource @PSBoundParameters
    $ValuesToCheck = ([Hashtable]$PSBoundParameters).clone()

    if ($CurrentValues.Ensure -ne $Ensure)
    {
        Write-Verbose -Message "Test-TargetResource returned $false"
        return $false
    }
    $testResult = $true

    #Compare Cim instances
    foreach ($key in $PSBoundParameters.Keys)
    {
        $source = $PSBoundParameters.$key
        $target = $CurrentValues.$key
        if ($source.getType().Name -like '*CimInstance*')
        {
            $source = Get-M365DSCDRGComplexTypeToHashtable -ComplexObject $source

            $testResult = Compare-M365DSCComplexObject `
                -Source ($source) `
                -Target ($target)

            if (-Not $testResult)
            {
                $testResult = $false
                break
            }

            $ValuesToCheck.Remove($key) | Out-Null
        }
    }

    $ValuesToCheck.remove('Id') | Out-Null
    $ValuesToCheck.Remove('Credential') | Out-Null
    $ValuesToCheck.Remove('ApplicationId') | Out-Null
    $ValuesToCheck.Remove('TenantId') | Out-Null
    $ValuesToCheck.Remove('ApplicationSecret') | Out-Null

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $ValuesToCheck)"

    if ($testResult)
    {
        $testResult = Test-M365DSCParameterState -CurrentValues $CurrentValues `
            -Source $($MyInvocation.MyCommand.Source) `
            -DesiredValues $PSBoundParameters `
            -ValuesToCheck $ValuesToCheck.Keys
    }

    Write-Verbose -Message "Test-TargetResource returned $testResult"

    return $testResult
}

function Export-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param
    (
        [Parameter()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $ApplicationSecret,

        [Parameter()]
        [System.String]
        $CertificateThumbprint,

        [Parameter()]
        [Switch]
        $ManagedIdentity
    )

    $ConnectionMode = New-M365DSCConnection -Workload 'MicrosoftGraph' `
        -InboundParameters $PSBoundParameters

    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName.Replace('MSFT_', '')
    $CommandName = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    try
    {
        #region resource generator code
        [array]$getValue = Get-MgApplication `
            -All `
            -ErrorAction Stop
        #endregion

        $i = 1
        $dscContent = ''
        if ($getValue.Length -eq 0)
        {
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }
        else
        {
            Write-Host "`r`n" -NoNewline
        }
        foreach ($config in $getValue)
        {
            $displayedKey = $config.Id
            if (-not [String]::IsNullOrEmpty($config.displayName))
            {
                $displayedKey = $config.displayName
            }
            Write-Host "    |---[$i/$($getValue.Count)] $displayedKey" -NoNewline
            $params = @{
                Id = $config.Id
                DisplayName           =  $config.DisplayName
                Ensure = 'Present'
                Credential = $Credential
                ApplicationId = $ApplicationId
                TenantId = $TenantId
                ApplicationSecret = $ApplicationSecret
                CertificateThumbprint = $CertificateThumbprint
                Managedidentity = $ManagedIdentity.IsPresent
            }

            $Results = Get-TargetResource @Params
            $Results = Update-M365DSCExportAuthenticationResults -ConnectionMode $ConnectionMode `
                -Results $Results
            if ($null -ne $Results.AddIns)
            {
                $complexMapping = @(
                    @{
                        Name = 'AddIns'
                        CimInstanceName = 'MicrosoftGraphAddIn'
                        IsRequired = $False
                    }
                    @{
                        Name = 'Properties'
                        CimInstanceName = 'MicrosoftGraphKeyValue'
                        IsRequired = $False
                    }
                )
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.AddIns `
                    -CIMInstanceName 'MicrosoftGraphaddIn' `
                    -ComplexTypeMapping $complexMapping

                if (-Not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.AddIns = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('AddIns') | Out-Null
                }
            }
            if ($null -ne $Results.Api)
            {
                $complexMapping = @(
                    @{
                        Name = 'Api'
                        CimInstanceName = 'MicrosoftGraphApiApplication'
                        IsRequired = $False
                    }
                    @{
                        Name = 'Oauth2PermissionScopes'
                        CimInstanceName = 'MicrosoftGraphPermissionScope'
                        IsRequired = $False
                    }
                    @{
                        Name = 'PreAuthorizedApplications'
                        CimInstanceName = 'MicrosoftGraphPreAuthorizedApplication'
                        IsRequired = $False
                    }
                )
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.Api `
                    -CIMInstanceName 'MicrosoftGraphapiApplication' `
                    -ComplexTypeMapping $complexMapping

                if (-Not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.Api = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('Api') | Out-Null
                }
            }
            if ($null -ne $Results.AppRoles)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.AppRoles `
                    -CIMInstanceName 'MicrosoftGraphappRole'
                if (-Not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.AppRoles = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('AppRoles') | Out-Null
                }
            }
            if ($null -ne $Results.Certification)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.Certification `
                    -CIMInstanceName 'MicrosoftGraphcertification'
                if (-Not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.Certification = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('Certification') | Out-Null
                }
            }
            if ($null -ne $Results.Info)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.Info `
                    -CIMInstanceName 'MicrosoftGraphinformationalUrl'
                if (-Not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.Info = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('Info') | Out-Null
                }
            }
            if ($null -ne $Results.KeyCredentials)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.KeyCredentials `
                    -CIMInstanceName 'MicrosoftGraphkeyCredential'
                if (-Not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.KeyCredentials = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('KeyCredentials') | Out-Null
                }
            }
            if ($null -ne $Results.OptionalClaims)
            {
                $complexMapping = @(
                    @{
                        Name = 'OptionalClaims'
                        CimInstanceName = 'MicrosoftGraphOptionalClaims'
                        IsRequired = $False
                    }
                    @{
                        Name = 'AccessToken'
                        CimInstanceName = 'MicrosoftGraphOptionalClaim'
                        IsRequired = $False
                    }
                    @{
                        Name = 'IdToken'
                        CimInstanceName = 'MicrosoftGraphOptionalClaim'
                        IsRequired = $False
                    }
                    @{
                        Name = 'Saml2Token'
                        CimInstanceName = 'MicrosoftGraphOptionalClaim'
                        IsRequired = $False
                    }
                )
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.OptionalClaims `
                    -CIMInstanceName 'MicrosoftGraphoptionalClaims' `
                    -ComplexTypeMapping $complexMapping

                if (-Not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.OptionalClaims = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('OptionalClaims') | Out-Null
                }
            }
            if ($null -ne $Results.ParentalControlSettings)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.ParentalControlSettings `
                    -CIMInstanceName 'MicrosoftGraphparentalControlSettings'
                if (-Not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.ParentalControlSettings = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('ParentalControlSettings') | Out-Null
                }
            }
            if ($null -ne $Results.PasswordCredentials)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.PasswordCredentials `
                    -CIMInstanceName 'MicrosoftGraphpasswordCredential'
                if (-Not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.PasswordCredentials = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('PasswordCredentials') | Out-Null
                }
            }
            if ($null -ne $Results.PublicClient)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.PublicClient `
                    -CIMInstanceName 'MicrosoftGraphpublicClientApplication'
                if (-Not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.PublicClient = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('PublicClient') | Out-Null
                }
            }
            if ($null -ne $Results.RequestSignatureVerification)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.RequestSignatureVerification `
                    -CIMInstanceName 'MicrosoftGraphrequestSignatureVerification'
                if (-Not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.RequestSignatureVerification = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('RequestSignatureVerification') | Out-Null
                }
            }
            if ($null -ne $Results.RequiredResourceAccess)
            {
                $complexMapping = @(
                    @{
                        Name = 'RequiredResourceAccess'
                        CimInstanceName = 'MicrosoftGraphRequiredResourceAccess'
                        IsRequired = $False
                    }
                    @{
                        Name = 'ResourceAccess'
                        CimInstanceName = 'MicrosoftGraphResourceAccess'
                        IsRequired = $False
                    }
                )
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.RequiredResourceAccess `
                    -CIMInstanceName 'MicrosoftGraphrequiredResourceAccess' `
                    -ComplexTypeMapping $complexMapping

                if (-Not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.RequiredResourceAccess = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('RequiredResourceAccess') | Out-Null
                }
            }
            if ($null -ne $Results.ServicePrincipalLockConfiguration)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.ServicePrincipalLockConfiguration `
                    -CIMInstanceName 'MicrosoftGraphservicePrincipalLockConfiguration'
                if (-Not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.ServicePrincipalLockConfiguration = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('ServicePrincipalLockConfiguration') | Out-Null
                }
            }
            if ($null -ne $Results.Spa)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.Spa `
                    -CIMInstanceName 'MicrosoftGraphspaApplication'
                if (-Not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.Spa = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('Spa') | Out-Null
                }
            }
            if ($null -ne $Results.VerifiedPublisher)
            {
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.VerifiedPublisher `
                    -CIMInstanceName 'MicrosoftGraphverifiedPublisher'
                if (-Not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.VerifiedPublisher = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('VerifiedPublisher') | Out-Null
                }
            }
            if ($null -ne $Results.Web)
            {
                $complexMapping = @(
                    @{
                        Name = 'Web'
                        CimInstanceName = 'MicrosoftGraphWebApplication'
                        IsRequired = $False
                    }
                    @{
                        Name = 'ImplicitGrantSettings'
                        CimInstanceName = 'MicrosoftGraphImplicitGrantSettings'
                        IsRequired = $False
                    }
                    @{
                        Name = 'RedirectUriSettings'
                        CimInstanceName = 'MicrosoftGraphRedirectUriSettings'
                        IsRequired = $False
                    }
                )
                $complexTypeStringResult = Get-M365DSCDRGComplexTypeToString `
                    -ComplexObject $Results.Web `
                    -CIMInstanceName 'MicrosoftGraphwebApplication' `
                    -ComplexTypeMapping $complexMapping

                if (-Not [String]::IsNullOrWhiteSpace($complexTypeStringResult))
                {
                    $Results.Web = $complexTypeStringResult
                }
                else
                {
                    $Results.Remove('Web') | Out-Null
                }
            }

            $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
                -ConnectionMode $ConnectionMode `
                -ModulePath $PSScriptRoot `
                -Results $Results `
                -Credential $Credential
            if ($Results.AddIns)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "AddIns" -isCIMArray:$True
            }
            if ($Results.Api)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "Api" -isCIMArray:$False
            }
            if ($Results.AppRoles)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "AppRoles" -isCIMArray:$True
            }
            if ($Results.Certification)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "Certification" -isCIMArray:$False
            }
            if ($Results.Info)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "Info" -isCIMArray:$False
            }
            if ($Results.KeyCredentials)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "KeyCredentials" -isCIMArray:$True
            }
            if ($Results.OptionalClaims)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "OptionalClaims" -isCIMArray:$False
            }
            if ($Results.ParentalControlSettings)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "ParentalControlSettings" -isCIMArray:$False
            }
            if ($Results.PasswordCredentials)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "PasswordCredentials" -isCIMArray:$True
            }
            if ($Results.PublicClient)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "PublicClient" -isCIMArray:$False
            }
            if ($Results.RequestSignatureVerification)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "RequestSignatureVerification" -isCIMArray:$False
            }
            if ($Results.RequiredResourceAccess)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "RequiredResourceAccess" -isCIMArray:$True
            }
            if ($Results.ServicePrincipalLockConfiguration)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "ServicePrincipalLockConfiguration" -isCIMArray:$False
            }
            if ($Results.Spa)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "Spa" -isCIMArray:$False
            }
            if ($Results.VerifiedPublisher)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "VerifiedPublisher" -isCIMArray:$False
            }
            if ($Results.Web)
            {
                $currentDSCBlock = Convert-DSCStringParamToVariable -DSCBlock $currentDSCBlock -ParameterName "Web" -isCIMArray:$False
            }

            $dscContent += $currentDSCBlock
            Save-M365DSCPartialExport -Content $currentDSCBlock `
                -FileName $Global:PartialExportFileName
            $i++
            Write-Host $Global:M365DSCEmojiGreenCheckMark
        }
        return $dscContent
    }
    catch
    {
        Write-Host $Global:M365DSCEmojiRedX

        New-M365DSCLogEntry -Message 'Error during Export:' `
            -Exception $_ `
            -Source $($MyInvocation.MyCommand.Source) `
            -TenantId $TenantId `
            -Credential $Credential

        return ''
    }
}

Export-ModuleMember -Function *-TargetResource
