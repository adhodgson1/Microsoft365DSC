[CmdletBinding()]
param(
)
$M365DSCTestFolder = Join-Path -Path $PSScriptRoot `
                        -ChildPath '..\..\Unit' `
                        -Resolve
$CmdletModule = (Join-Path -Path $M365DSCTestFolder `
            -ChildPath '\Stubs\Microsoft365.psm1' `
            -Resolve)
$GenericStubPath = (Join-Path -Path $M365DSCTestFolder `
    -ChildPath '\Stubs\Generic.psm1' `
    -Resolve)
Import-Module -Name (Join-Path -Path $M365DSCTestFolder `
        -ChildPath '\UnitTestHelper.psm1' `
        -Resolve)

$Global:DscHelper = New-M365DscUnitTestHelper -StubModule $CmdletModule `
    -DscResource "AADApplication" -GenericStubModule $GenericStubPath
Describe -Name $Global:DscHelper.DescribeHeader -Fixture {
    InModuleScope -ModuleName $Global:DscHelper.ModuleName -ScriptBlock {
        Invoke-Command -ScriptBlock $Global:DscHelper.InitializeScript -NoNewScope
        BeforeAll {

            $secpasswd = ConvertTo-SecureString "f@kepassword1" -AsPlainText -Force
            $Credential = New-Object System.Management.Automation.PSCredential ('tenantadmin@mydomain.com', $secpasswd)

            Mock -CommandName Confirm-M365DSCDependencies -MockWith {
            }

            Mock -CommandName Get-PSSession -MockWith {
            }

            Mock -CommandName Remove-PSSession -MockWith {
            }

            Mock -CommandName Update-MgApplication -MockWith {
            }

            Mock -CommandName New-MgApplication -MockWith {
            }

            Mock -CommandName Remove-MgApplication -MockWith {
            }

            Mock -CommandName New-M365DSCConnection -MockWith {
                return "Credentials"
            }

            # Mock Write-Host to hide output during the tests
            Mock -CommandName Write-Host -MockWith {
            }
            $Script:exportedInstances =$null
            $Script:ExportMode = $false
        }
        # Test contexts
        Context -Name "The AADApplication should exist but it DOES NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    addIns = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_MicrosoftGraphaddIn -Property @{
                            type = "FakeStringValue"
                            properties = [CimInstance[]]@(
                                (New-CimInstance -ClassName MSFT_MicrosoftGraphkeyValue -Property @{
                                    value = "FakeStringValue"
                                    key = "FakeStringValue"
                                } -ClientOnly)
                            )
                        } -ClientOnly)
                    )
                    api = (New-CimInstance -ClassName MSFT_MicrosoftGraphapiApplication -Property @{
                        requestedAccessTokenVersion = 25
                        acceptMappedClaims = $True
                        oauth2PermissionScopes = [CimInstance[]]@(
                            (New-CimInstance -ClassName MSFT_MicrosoftGraphpermissionScope -Property @{
                                userConsentDescription = "FakeStringValue"
                                value = "FakeStringValue"
                                isEnabled = $True
                                adminConsentDescription = "FakeStringValue"
                                adminConsentDisplayName = "FakeStringValue"
                                origin = "FakeStringValue"
                                userConsentDisplayName = "FakeStringValue"
                                type = "FakeStringValue"
                            } -ClientOnly)
                        )
                        preAuthorizedApplications = [CimInstance[]]@(
                            (New-CimInstance -ClassName MSFT_MicrosoftGraphpreAuthorizedApplication -Property @{
                                delegatedPermissionIds = @("FakeStringValue")
                                appId = "FakeStringValue"
                            } -ClientOnly)
                        )
                        knownClientApplications = $True
                    } -ClientOnly)
                    appId = "FakeStringValue"
                    applicationTemplateId = "FakeStringValue"
                    appRoles = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_MicrosoftGraphappRole -Property @{
                            description = "FakeStringValue"
                            value = "FakeStringValue"
                            displayName = "FakeStringValue"
                            allowedMemberTypes = @("FakeStringValue")
                            origin = "FakeStringValue"
                            isEnabled = $True
                        } -ClientOnly)
                    )
                    certification = (New-CimInstance -ClassName MSFT_MicrosoftGraphcertification -Property @{
                        certificationDetailsUrl = "FakeStringValue"
                        certificationExpirationDateTime = "2023-01-01T00:00:00.0000000+00:00"
                        isPublisherAttested = $True
                        lastCertificationDateTime = "2023-01-01T00:00:00.0000000+00:00"
                        isCertifiedByMicrosoft = $True
                    } -ClientOnly)
                    createdDateTime = "2023-01-01T00:00:00.0000000+00:00"
                    defaultRedirectUri = "FakeStringValue"
                    deletedDateTime = "2023-01-01T00:00:00.0000000+00:00"
                    description = "FakeStringValue"
                    disabledByMicrosoftStatus = "FakeStringValue"
                    displayName = "FakeStringValue"
                    groupMembershipClaims = "FakeStringValue"
                    id = "FakeStringValue"
                    identifierUris = @("FakeStringValue")
                    info = (New-CimInstance -ClassName MSFT_MicrosoftGraphinformationalUrl -Property @{
                        privacyStatementUrl = "FakeStringValue"
                        termsOfServiceUrl = "FakeStringValue"
                        logoUrl = "FakeStringValue"
                        supportUrl = "FakeStringValue"
                        marketingUrl = "FakeStringValue"
                    } -ClientOnly)
                    isDeviceOnlyAuthSupported = $True
                    isFallbackPublicClient = $True
                    keyCredentials = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_MicrosoftGraphkeyCredential -Property @{
                            startDateTime = "2023-01-01T00:00:00.0000000+00:00"
                            displayName = "FakeStringValue"
                            endDateTime = "2023-01-01T00:00:00.0000000+00:00"
                            type = "FakeStringValue"
                            usage = "FakeStringValue"
                        } -ClientOnly)
                    )
                    notes = "FakeStringValue"
                    oauth2RequirePostResponse = $True
                    optionalClaims = (New-CimInstance -ClassName MSFT_MicrosoftGraphoptionalClaims -Property @{
                        idToken = [CimInstance[]]@(
                            (New-CimInstance -ClassName MSFT_MicrosoftGraphoptionalClaim -Property @{
                                source = "FakeStringValue"
                                essential = $True
                                additionalProperties = @("FakeStringValue")
                                name = "FakeStringValue"
                            } -ClientOnly)
                        )
                        accessToken = [CimInstance[]]@(
                            (New-CimInstance -ClassName MSFT_MicrosoftGraphoptionalClaim -Property @{
                                source = "FakeStringValue"
                                essential = $True
                                additionalProperties = @("FakeStringValue")
                                name = "FakeStringValue"
                            } -ClientOnly)
                        )
                        saml2Token = [CimInstance[]]@(
                            (New-CimInstance -ClassName MSFT_MicrosoftGraphoptionalClaim -Property @{
                                source = "FakeStringValue"
                                essential = $True
                                additionalProperties = @("FakeStringValue")
                                name = "FakeStringValue"
                            } -ClientOnly)
                        )
                    } -ClientOnly)
                    parentalControlSettings = (New-CimInstance -ClassName MSFT_MicrosoftGraphparentalControlSettings -Property @{
                        countriesBlockedForMinors = @("FakeStringValue")
                        legalAgeGroupRule = "FakeStringValue"
                    } -ClientOnly)
                    passwordCredentials = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_MicrosoftGraphpasswordCredential -Property @{
                            displayName = "FakeStringValue"
                            startDateTime = "2023-01-01T00:00:00.0000000+00:00"
                            hint = "FakeStringValue"
                            secretText = "FakeStringValue"
                            endDateTime = "2023-01-01T00:00:00.0000000+00:00"
                        } -ClientOnly)
                    )
                    publicClient = (New-CimInstance -ClassName MSFT_MicrosoftGraphpublicClientApplication -Property @{
                        redirectUris = @("FakeStringValue")
                    } -ClientOnly)
                    publisherDomain = "FakeStringValue"
                    requestSignatureVerification = (New-CimInstance -ClassName MSFT_MicrosoftGraphrequestSignatureVerification -Property @{
                        isSignedRequestRequired = $True
                        allowedWeakAlgorithms = "rsaSha1"
                    } -ClientOnly)
                    requiredResourceAccess = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_MicrosoftGraphrequiredResourceAccess -Property @{
                            resourceAccess = [CimInstance[]]@(
                                (New-CimInstance -ClassName MSFT_MicrosoftGraphresourceAccess -Property @{
                                    type = "FakeStringValue"
                                } -ClientOnly)
                            )
                            resourceAppId = "FakeStringValue"
                        } -ClientOnly)
                    )
                    samlMetadataUrl = "FakeStringValue"
                    serviceManagementReference = "FakeStringValue"
                    servicePrincipalLockConfiguration = (New-CimInstance -ClassName MSFT_MicrosoftGraphservicePrincipalLockConfiguration -Property @{
                        tokenEncryptionKeyId = $True
                        credentialsWithUsageVerify = $True
                        allProperties = $True
                        isEnabled = $True
                        credentialsWithUsageSign = $True
                    } -ClientOnly)
                    signInAudience = "FakeStringValue"
                    spa = (New-CimInstance -ClassName MSFT_MicrosoftGraphspaApplication -Property @{
                        redirectUris = @("FakeStringValue")
                    } -ClientOnly)
                    tags = @("FakeStringValue")
                    uniqueName = "FakeStringValue"
                    verifiedPublisher = (New-CimInstance -ClassName MSFT_MicrosoftGraphverifiedPublisher -Property @{
                        verifiedPublisherId = "FakeStringValue"
                        addedDateTime = "2023-01-01T00:00:00.0000000+00:00"
                        displayName = "FakeStringValue"
                    } -ClientOnly)
                    web = (New-CimInstance -ClassName MSFT_MicrosoftGraphwebApplication -Property @{
                        redirectUriSettings = [CimInstance[]]@(
                            (New-CimInstance -ClassName MSFT_MicrosoftGraphredirectUriSettings -Property @{
                                index = 25
                                uri = "FakeStringValue"
                            } -ClientOnly)
                        )
                        homePageUrl = "FakeStringValue"
                        logoutUrl = "FakeStringValue"
                        implicitGrantSettings = (New-CimInstance -ClassName MSFT_MicrosoftGraphimplicitGrantSettings -Property @{
                            enableAccessTokenIssuance = $True
                            enableIdTokenIssuance = $True
                        } -ClientOnly)
                        redirectUris = @("FakeStringValue")
                    } -ClientOnly)
                    Ensure = "Present"
                    Credential = $Credential;
                }

                Mock -CommandName Get-MgApplication -MockWith {
                    return $null
                }
            }
            It 'Should return Values from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Absent'
            }
            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }
            It 'Should Create the group from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName New-MgApplication -Exactly 1
            }
        }

        Context -Name "The AADApplication exists but it SHOULD NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    addIns = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_MicrosoftGraphaddIn -Property @{
                            type = "FakeStringValue"
                            properties = [CimInstance[]]@(
                                (New-CimInstance -ClassName MSFT_MicrosoftGraphkeyValue -Property @{
                                    value = "FakeStringValue"
                                    key = "FakeStringValue"
                                } -ClientOnly)
                            )
                        } -ClientOnly)
                    )
                    api = (New-CimInstance -ClassName MSFT_MicrosoftGraphapiApplication -Property @{
                        requestedAccessTokenVersion = 25
                        acceptMappedClaims = $True
                        oauth2PermissionScopes = [CimInstance[]]@(
                            (New-CimInstance -ClassName MSFT_MicrosoftGraphpermissionScope -Property @{
                                userConsentDescription = "FakeStringValue"
                                value = "FakeStringValue"
                                isEnabled = $True
                                adminConsentDescription = "FakeStringValue"
                                adminConsentDisplayName = "FakeStringValue"
                                origin = "FakeStringValue"
                                userConsentDisplayName = "FakeStringValue"
                                type = "FakeStringValue"
                            } -ClientOnly)
                        )
                        preAuthorizedApplications = [CimInstance[]]@(
                            (New-CimInstance -ClassName MSFT_MicrosoftGraphpreAuthorizedApplication -Property @{
                                delegatedPermissionIds = @("FakeStringValue")
                                appId = "FakeStringValue"
                            } -ClientOnly)
                        )
                        knownClientApplications = $True
                    } -ClientOnly)
                    appId = "FakeStringValue"
                    applicationTemplateId = "FakeStringValue"
                    appRoles = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_MicrosoftGraphappRole -Property @{
                            description = "FakeStringValue"
                            value = "FakeStringValue"
                            displayName = "FakeStringValue"
                            allowedMemberTypes = @("FakeStringValue")
                            origin = "FakeStringValue"
                            isEnabled = $True
                        } -ClientOnly)
                    )
                    certification = (New-CimInstance -ClassName MSFT_MicrosoftGraphcertification -Property @{
                        certificationDetailsUrl = "FakeStringValue"
                        certificationExpirationDateTime = "2023-01-01T00:00:00.0000000+00:00"
                        isPublisherAttested = $True
                        lastCertificationDateTime = "2023-01-01T00:00:00.0000000+00:00"
                        isCertifiedByMicrosoft = $True
                    } -ClientOnly)
                    createdDateTime = "2023-01-01T00:00:00.0000000+00:00"
                    defaultRedirectUri = "FakeStringValue"
                    deletedDateTime = "2023-01-01T00:00:00.0000000+00:00"
                    description = "FakeStringValue"
                    disabledByMicrosoftStatus = "FakeStringValue"
                    displayName = "FakeStringValue"
                    groupMembershipClaims = "FakeStringValue"
                    id = "FakeStringValue"
                    identifierUris = @("FakeStringValue")
                    info = (New-CimInstance -ClassName MSFT_MicrosoftGraphinformationalUrl -Property @{
                        privacyStatementUrl = "FakeStringValue"
                        termsOfServiceUrl = "FakeStringValue"
                        logoUrl = "FakeStringValue"
                        supportUrl = "FakeStringValue"
                        marketingUrl = "FakeStringValue"
                    } -ClientOnly)
                    isDeviceOnlyAuthSupported = $True
                    isFallbackPublicClient = $True
                    keyCredentials = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_MicrosoftGraphkeyCredential -Property @{
                            startDateTime = "2023-01-01T00:00:00.0000000+00:00"
                            displayName = "FakeStringValue"
                            endDateTime = "2023-01-01T00:00:00.0000000+00:00"
                            type = "FakeStringValue"
                            usage = "FakeStringValue"
                        } -ClientOnly)
                    )
                    notes = "FakeStringValue"
                    oauth2RequirePostResponse = $True
                    optionalClaims = (New-CimInstance -ClassName MSFT_MicrosoftGraphoptionalClaims -Property @{
                        idToken = [CimInstance[]]@(
                            (New-CimInstance -ClassName MSFT_MicrosoftGraphoptionalClaim -Property @{
                                source = "FakeStringValue"
                                essential = $True
                                additionalProperties = @("FakeStringValue")
                                name = "FakeStringValue"
                            } -ClientOnly)
                        )
                        accessToken = [CimInstance[]]@(
                            (New-CimInstance -ClassName MSFT_MicrosoftGraphoptionalClaim -Property @{
                                source = "FakeStringValue"
                                essential = $True
                                additionalProperties = @("FakeStringValue")
                                name = "FakeStringValue"
                            } -ClientOnly)
                        )
                        saml2Token = [CimInstance[]]@(
                            (New-CimInstance -ClassName MSFT_MicrosoftGraphoptionalClaim -Property @{
                                source = "FakeStringValue"
                                essential = $True
                                additionalProperties = @("FakeStringValue")
                                name = "FakeStringValue"
                            } -ClientOnly)
                        )
                    } -ClientOnly)
                    parentalControlSettings = (New-CimInstance -ClassName MSFT_MicrosoftGraphparentalControlSettings -Property @{
                        countriesBlockedForMinors = @("FakeStringValue")
                        legalAgeGroupRule = "FakeStringValue"
                    } -ClientOnly)
                    passwordCredentials = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_MicrosoftGraphpasswordCredential -Property @{
                            displayName = "FakeStringValue"
                            startDateTime = "2023-01-01T00:00:00.0000000+00:00"
                            hint = "FakeStringValue"
                            secretText = "FakeStringValue"
                            endDateTime = "2023-01-01T00:00:00.0000000+00:00"
                        } -ClientOnly)
                    )
                    publicClient = (New-CimInstance -ClassName MSFT_MicrosoftGraphpublicClientApplication -Property @{
                        redirectUris = @("FakeStringValue")
                    } -ClientOnly)
                    publisherDomain = "FakeStringValue"
                    requestSignatureVerification = (New-CimInstance -ClassName MSFT_MicrosoftGraphrequestSignatureVerification -Property @{
                        isSignedRequestRequired = $True
                        allowedWeakAlgorithms = "rsaSha1"
                    } -ClientOnly)
                    requiredResourceAccess = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_MicrosoftGraphrequiredResourceAccess -Property @{
                            resourceAccess = [CimInstance[]]@(
                                (New-CimInstance -ClassName MSFT_MicrosoftGraphresourceAccess -Property @{
                                    type = "FakeStringValue"
                                } -ClientOnly)
                            )
                            resourceAppId = "FakeStringValue"
                        } -ClientOnly)
                    )
                    samlMetadataUrl = "FakeStringValue"
                    serviceManagementReference = "FakeStringValue"
                    servicePrincipalLockConfiguration = (New-CimInstance -ClassName MSFT_MicrosoftGraphservicePrincipalLockConfiguration -Property @{
                        tokenEncryptionKeyId = $True
                        credentialsWithUsageVerify = $True
                        allProperties = $True
                        isEnabled = $True
                        credentialsWithUsageSign = $True
                    } -ClientOnly)
                    signInAudience = "FakeStringValue"
                    spa = (New-CimInstance -ClassName MSFT_MicrosoftGraphspaApplication -Property @{
                        redirectUris = @("FakeStringValue")
                    } -ClientOnly)
                    tags = @("FakeStringValue")
                    uniqueName = "FakeStringValue"
                    verifiedPublisher = (New-CimInstance -ClassName MSFT_MicrosoftGraphverifiedPublisher -Property @{
                        verifiedPublisherId = "FakeStringValue"
                        addedDateTime = "2023-01-01T00:00:00.0000000+00:00"
                        displayName = "FakeStringValue"
                    } -ClientOnly)
                    web = (New-CimInstance -ClassName MSFT_MicrosoftGraphwebApplication -Property @{
                        redirectUriSettings = [CimInstance[]]@(
                            (New-CimInstance -ClassName MSFT_MicrosoftGraphredirectUriSettings -Property @{
                                index = 25
                                uri = "FakeStringValue"
                            } -ClientOnly)
                        )
                        homePageUrl = "FakeStringValue"
                        logoutUrl = "FakeStringValue"
                        implicitGrantSettings = (New-CimInstance -ClassName MSFT_MicrosoftGraphimplicitGrantSettings -Property @{
                            enableAccessTokenIssuance = $True
                            enableIdTokenIssuance = $True
                        } -ClientOnly)
                        redirectUris = @("FakeStringValue")
                    } -ClientOnly)
                    Ensure = 'Absent'
                    Credential = $Credential;
                }

                Mock -CommandName Get-MgApplication -MockWith {
                    return @{
                        AdditionalProperties = @{
                            oauth2RequirePostResponse = $True
                            isDeviceOnlyAuthSupported = $True
                            certification = @{
                                certificationDetailsUrl = "FakeStringValue"
                                certificationExpirationDateTime = "2023-01-01T00:00:00.0000000+00:00"
                                isPublisherAttested = $True
                                lastCertificationDateTime = "2023-01-01T00:00:00.0000000+00:00"
                                isCertifiedByMicrosoft = $True
                            }
                            defaultRedirectUri = "FakeStringValue"
                            serviceManagementReference = "FakeStringValue"
                            web = @{
                                redirectUriSettings = @(
                                    @{
                                        index = 25
                                        uri = "FakeStringValue"
                                    }
                                )
                                homePageUrl = "FakeStringValue"
                                logoutUrl = "FakeStringValue"
                                implicitGrantSettings = @{
                                    enableAccessTokenIssuance = $True
                                    enableIdTokenIssuance = $True
                                }
                                redirectUris = @("FakeStringValue")
                            }
                            groupMembershipClaims = "FakeStringValue"
                            samlMetadataUrl = "FakeStringValue"
                            info = @{
                                privacyStatementUrl = "FakeStringValue"
                                termsOfServiceUrl = "FakeStringValue"
                                logoUrl = "FakeStringValue"
                                supportUrl = "FakeStringValue"
                                marketingUrl = "FakeStringValue"
                            }
                            uniqueName = "FakeStringValue"
                            passwordCredentials = @(
                                @{
                                    displayName = "FakeStringValue"
                                    startDateTime = "2023-01-01T00:00:00.0000000+00:00"
                                    hint = "FakeStringValue"
                                    secretText = "FakeStringValue"
                                    endDateTime = "2023-01-01T00:00:00.0000000+00:00"
                                }
                            )
                            appId = "FakeStringValue"
                            appRoles = @(
                                @{
                                    description = "FakeStringValue"
                                    value = "FakeStringValue"
                                    displayName = "FakeStringValue"
                                    allowedMemberTypes = @("FakeStringValue")
                                    origin = "FakeStringValue"
                                    isEnabled = $True
                                }
                            )
                            notes = "FakeStringValue"
                            publicClient = @{
                                redirectUris = @("FakeStringValue")
                            }
                            isFallbackPublicClient = $True
                            requestSignatureVerification = @{
                                isSignedRequestRequired = $True
                                allowedWeakAlgorithms = "rsaSha1"
                            }
                            tags = @("FakeStringValue")
                            createdDateTime = "2023-01-01T00:00:00.0000000+00:00"
                            spa = @{
                                redirectUris = @("FakeStringValue")
                            }
                            displayName = "FakeStringValue"
                            verifiedPublisher = @{
                                verifiedPublisherId = "FakeStringValue"
                                addedDateTime = "2023-01-01T00:00:00.0000000+00:00"
                                displayName = "FakeStringValue"
                            }
                            applicationTemplateId = "FakeStringValue"
                            addIns = @(
                                @{
                                    type = "FakeStringValue"
                                    properties = @(
                                        @{
                                            value = "FakeStringValue"
                                            key = "FakeStringValue"
                                        }
                                    )
                                }
                            )
                            servicePrincipalLockConfiguration = @{
                                tokenEncryptionKeyId = $True
                                credentialsWithUsageVerify = $True
                                allProperties = $True
                                isEnabled = $True
                                credentialsWithUsageSign = $True
                            }
                            description = "FakeStringValue"
                            signInAudience = "FakeStringValue"
                            '@odata.type' = "#microsoft.graph.Application"
                            optionalClaims = @{
                                idToken = @(
                                    @{
                                        source = "FakeStringValue"
                                        essential = $True
                                        additionalProperties = @("FakeStringValue")
                                        name = "FakeStringValue"
                                    }
                                )
                                accessToken = @(
                                    @{
                                        source = "FakeStringValue"
                                        essential = $True
                                        additionalProperties = @("FakeStringValue")
                                        name = "FakeStringValue"
                                    }
                                )
                                saml2Token = @(
                                    @{
                                        source = "FakeStringValue"
                                        essential = $True
                                        additionalProperties = @("FakeStringValue")
                                        name = "FakeStringValue"
                                    }
                                )
                            }
                            identifierUris = @("FakeStringValue")
                            keyCredentials = @(
                                @{
                                    startDateTime = "2023-01-01T00:00:00.0000000+00:00"
                                    displayName = "FakeStringValue"
                                    endDateTime = "2023-01-01T00:00:00.0000000+00:00"
                                    type = "FakeStringValue"
                                    usage = "FakeStringValue"
                                }
                            )
                            parentalControlSettings = @{
                                countriesBlockedForMinors = @("FakeStringValue")
                                legalAgeGroupRule = "FakeStringValue"
                            }
                            publisherDomain = "FakeStringValue"
                            requiredResourceAccess = @(
                                @{
                                    resourceAccess = @(
                                        @{
                                            type = "FakeStringValue"
                                        }
                                    )
                                    resourceAppId = "FakeStringValue"
                                }
                            )
                            api = @{
                                requestedAccessTokenVersion = 25
                                acceptMappedClaims = $True
                                oauth2PermissionScopes = @(
                                    @{
                                        userConsentDescription = "FakeStringValue"
                                        value = "FakeStringValue"
                                        isEnabled = $True
                                        adminConsentDescription = "FakeStringValue"
                                        adminConsentDisplayName = "FakeStringValue"
                                        origin = "FakeStringValue"
                                        userConsentDisplayName = "FakeStringValue"
                                        type = "FakeStringValue"
                                    }
                                )
                                preAuthorizedApplications = @(
                                    @{
                                        delegatedPermissionIds = @("FakeStringValue")
                                        appId = "FakeStringValue"
                                    }
                                )
                                knownClientApplications = $True
                            }
                            disabledByMicrosoftStatus = "FakeStringValue"
                        }
                        deletedDateTime = "2023-01-01T00:00:00.0000000+00:00"
                        id = "FakeStringValue"

                    }
                }
            }

            It 'Should return Values from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should Remove the group from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName Remove-MgApplication -Exactly 1
            }
        }
        Context -Name "The AADApplication Exists and Values are already in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    addIns = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_MicrosoftGraphaddIn -Property @{
                            type = "FakeStringValue"
                            properties = [CimInstance[]]@(
                                (New-CimInstance -ClassName MSFT_MicrosoftGraphkeyValue -Property @{
                                    value = "FakeStringValue"
                                    key = "FakeStringValue"
                                } -ClientOnly)
                            )
                        } -ClientOnly)
                    )
                    api = (New-CimInstance -ClassName MSFT_MicrosoftGraphapiApplication -Property @{
                        requestedAccessTokenVersion = 25
                        acceptMappedClaims = $True
                        oauth2PermissionScopes = [CimInstance[]]@(
                            (New-CimInstance -ClassName MSFT_MicrosoftGraphpermissionScope -Property @{
                                userConsentDescription = "FakeStringValue"
                                value = "FakeStringValue"
                                isEnabled = $True
                                adminConsentDescription = "FakeStringValue"
                                adminConsentDisplayName = "FakeStringValue"
                                origin = "FakeStringValue"
                                userConsentDisplayName = "FakeStringValue"
                                type = "FakeStringValue"
                            } -ClientOnly)
                        )
                        preAuthorizedApplications = [CimInstance[]]@(
                            (New-CimInstance -ClassName MSFT_MicrosoftGraphpreAuthorizedApplication -Property @{
                                delegatedPermissionIds = @("FakeStringValue")
                                appId = "FakeStringValue"
                            } -ClientOnly)
                        )
                        knownClientApplications = $True
                    } -ClientOnly)
                    appId = "FakeStringValue"
                    applicationTemplateId = "FakeStringValue"
                    appRoles = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_MicrosoftGraphappRole -Property @{
                            description = "FakeStringValue"
                            value = "FakeStringValue"
                            displayName = "FakeStringValue"
                            allowedMemberTypes = @("FakeStringValue")
                            origin = "FakeStringValue"
                            isEnabled = $True
                        } -ClientOnly)
                    )
                    certification = (New-CimInstance -ClassName MSFT_MicrosoftGraphcertification -Property @{
                        certificationDetailsUrl = "FakeStringValue"
                        certificationExpirationDateTime = "2023-01-01T00:00:00.0000000+00:00"
                        isPublisherAttested = $True
                        lastCertificationDateTime = "2023-01-01T00:00:00.0000000+00:00"
                        isCertifiedByMicrosoft = $True
                    } -ClientOnly)
                    createdDateTime = "2023-01-01T00:00:00.0000000+00:00"
                    defaultRedirectUri = "FakeStringValue"
                    deletedDateTime = "2023-01-01T00:00:00.0000000+00:00"
                    description = "FakeStringValue"
                    disabledByMicrosoftStatus = "FakeStringValue"
                    displayName = "FakeStringValue"
                    groupMembershipClaims = "FakeStringValue"
                    id = "FakeStringValue"
                    identifierUris = @("FakeStringValue")
                    info = (New-CimInstance -ClassName MSFT_MicrosoftGraphinformationalUrl -Property @{
                        privacyStatementUrl = "FakeStringValue"
                        termsOfServiceUrl = "FakeStringValue"
                        logoUrl = "FakeStringValue"
                        supportUrl = "FakeStringValue"
                        marketingUrl = "FakeStringValue"
                    } -ClientOnly)
                    isDeviceOnlyAuthSupported = $True
                    isFallbackPublicClient = $True
                    keyCredentials = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_MicrosoftGraphkeyCredential -Property @{
                            startDateTime = "2023-01-01T00:00:00.0000000+00:00"
                            displayName = "FakeStringValue"
                            endDateTime = "2023-01-01T00:00:00.0000000+00:00"
                            type = "FakeStringValue"
                            usage = "FakeStringValue"
                        } -ClientOnly)
                    )
                    notes = "FakeStringValue"
                    oauth2RequirePostResponse = $True
                    optionalClaims = (New-CimInstance -ClassName MSFT_MicrosoftGraphoptionalClaims -Property @{
                        idToken = [CimInstance[]]@(
                            (New-CimInstance -ClassName MSFT_MicrosoftGraphoptionalClaim -Property @{
                                source = "FakeStringValue"
                                essential = $True
                                additionalProperties = @("FakeStringValue")
                                name = "FakeStringValue"
                            } -ClientOnly)
                        )
                        accessToken = [CimInstance[]]@(
                            (New-CimInstance -ClassName MSFT_MicrosoftGraphoptionalClaim -Property @{
                                source = "FakeStringValue"
                                essential = $True
                                additionalProperties = @("FakeStringValue")
                                name = "FakeStringValue"
                            } -ClientOnly)
                        )
                        saml2Token = [CimInstance[]]@(
                            (New-CimInstance -ClassName MSFT_MicrosoftGraphoptionalClaim -Property @{
                                source = "FakeStringValue"
                                essential = $True
                                additionalProperties = @("FakeStringValue")
                                name = "FakeStringValue"
                            } -ClientOnly)
                        )
                    } -ClientOnly)
                    parentalControlSettings = (New-CimInstance -ClassName MSFT_MicrosoftGraphparentalControlSettings -Property @{
                        countriesBlockedForMinors = @("FakeStringValue")
                        legalAgeGroupRule = "FakeStringValue"
                    } -ClientOnly)
                    passwordCredentials = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_MicrosoftGraphpasswordCredential -Property @{
                            displayName = "FakeStringValue"
                            startDateTime = "2023-01-01T00:00:00.0000000+00:00"
                            hint = "FakeStringValue"
                            secretText = "FakeStringValue"
                            endDateTime = "2023-01-01T00:00:00.0000000+00:00"
                        } -ClientOnly)
                    )
                    publicClient = (New-CimInstance -ClassName MSFT_MicrosoftGraphpublicClientApplication -Property @{
                        redirectUris = @("FakeStringValue")
                    } -ClientOnly)
                    publisherDomain = "FakeStringValue"
                    requestSignatureVerification = (New-CimInstance -ClassName MSFT_MicrosoftGraphrequestSignatureVerification -Property @{
                        isSignedRequestRequired = $True
                        allowedWeakAlgorithms = "rsaSha1"
                    } -ClientOnly)
                    requiredResourceAccess = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_MicrosoftGraphrequiredResourceAccess -Property @{
                            resourceAccess = [CimInstance[]]@(
                                (New-CimInstance -ClassName MSFT_MicrosoftGraphresourceAccess -Property @{
                                    type = "FakeStringValue"
                                } -ClientOnly)
                            )
                            resourceAppId = "FakeStringValue"
                        } -ClientOnly)
                    )
                    samlMetadataUrl = "FakeStringValue"
                    serviceManagementReference = "FakeStringValue"
                    servicePrincipalLockConfiguration = (New-CimInstance -ClassName MSFT_MicrosoftGraphservicePrincipalLockConfiguration -Property @{
                        tokenEncryptionKeyId = $True
                        credentialsWithUsageVerify = $True
                        allProperties = $True
                        isEnabled = $True
                        credentialsWithUsageSign = $True
                    } -ClientOnly)
                    signInAudience = "FakeStringValue"
                    spa = (New-CimInstance -ClassName MSFT_MicrosoftGraphspaApplication -Property @{
                        redirectUris = @("FakeStringValue")
                    } -ClientOnly)
                    tags = @("FakeStringValue")
                    uniqueName = "FakeStringValue"
                    verifiedPublisher = (New-CimInstance -ClassName MSFT_MicrosoftGraphverifiedPublisher -Property @{
                        verifiedPublisherId = "FakeStringValue"
                        addedDateTime = "2023-01-01T00:00:00.0000000+00:00"
                        displayName = "FakeStringValue"
                    } -ClientOnly)
                    web = (New-CimInstance -ClassName MSFT_MicrosoftGraphwebApplication -Property @{
                        redirectUriSettings = [CimInstance[]]@(
                            (New-CimInstance -ClassName MSFT_MicrosoftGraphredirectUriSettings -Property @{
                                index = 25
                                uri = "FakeStringValue"
                            } -ClientOnly)
                        )
                        homePageUrl = "FakeStringValue"
                        logoutUrl = "FakeStringValue"
                        implicitGrantSettings = (New-CimInstance -ClassName MSFT_MicrosoftGraphimplicitGrantSettings -Property @{
                            enableAccessTokenIssuance = $True
                            enableIdTokenIssuance = $True
                        } -ClientOnly)
                        redirectUris = @("FakeStringValue")
                    } -ClientOnly)
                    Ensure = 'Present'
                    Credential = $Credential;
                }

                Mock -CommandName Get-MgApplication -MockWith {
                    return @{
                        AdditionalProperties = @{
                            oauth2RequirePostResponse = $True
                            isDeviceOnlyAuthSupported = $True
                            certification = @{
                                certificationDetailsUrl = "FakeStringValue"
                                certificationExpirationDateTime = "2023-01-01T00:00:00.0000000+00:00"
                                isPublisherAttested = $True
                                lastCertificationDateTime = "2023-01-01T00:00:00.0000000+00:00"
                                isCertifiedByMicrosoft = $True
                            }
                            defaultRedirectUri = "FakeStringValue"
                            serviceManagementReference = "FakeStringValue"
                            web = @{
                                redirectUriSettings = @(
                                    @{
                                        index = 25
                                        uri = "FakeStringValue"
                                    }
                                )
                                homePageUrl = "FakeStringValue"
                                logoutUrl = "FakeStringValue"
                                implicitGrantSettings = @{
                                    enableAccessTokenIssuance = $True
                                    enableIdTokenIssuance = $True
                                }
                                redirectUris = @("FakeStringValue")
                            }
                            groupMembershipClaims = "FakeStringValue"
                            samlMetadataUrl = "FakeStringValue"
                            info = @{
                                privacyStatementUrl = "FakeStringValue"
                                termsOfServiceUrl = "FakeStringValue"
                                logoUrl = "FakeStringValue"
                                supportUrl = "FakeStringValue"
                                marketingUrl = "FakeStringValue"
                            }
                            uniqueName = "FakeStringValue"
                            passwordCredentials = @(
                                @{
                                    displayName = "FakeStringValue"
                                    startDateTime = "2023-01-01T00:00:00.0000000+00:00"
                                    hint = "FakeStringValue"
                                    secretText = "FakeStringValue"
                                    endDateTime = "2023-01-01T00:00:00.0000000+00:00"
                                }
                            )
                            appId = "FakeStringValue"
                            appRoles = @(
                                @{
                                    description = "FakeStringValue"
                                    value = "FakeStringValue"
                                    displayName = "FakeStringValue"
                                    allowedMemberTypes = @("FakeStringValue")
                                    origin = "FakeStringValue"
                                    isEnabled = $True
                                }
                            )
                            notes = "FakeStringValue"
                            publicClient = @{
                                redirectUris = @("FakeStringValue")
                            }
                            isFallbackPublicClient = $True
                            requestSignatureVerification = @{
                                isSignedRequestRequired = $True
                                allowedWeakAlgorithms = "rsaSha1"
                            }
                            tags = @("FakeStringValue")
                            createdDateTime = "2023-01-01T00:00:00.0000000+00:00"
                            spa = @{
                                redirectUris = @("FakeStringValue")
                            }
                            displayName = "FakeStringValue"
                            verifiedPublisher = @{
                                verifiedPublisherId = "FakeStringValue"
                                addedDateTime = "2023-01-01T00:00:00.0000000+00:00"
                                displayName = "FakeStringValue"
                            }
                            applicationTemplateId = "FakeStringValue"
                            addIns = @(
                                @{
                                    type = "FakeStringValue"
                                    properties = @(
                                        @{
                                            value = "FakeStringValue"
                                            key = "FakeStringValue"
                                        }
                                    )
                                }
                            )
                            servicePrincipalLockConfiguration = @{
                                tokenEncryptionKeyId = $True
                                credentialsWithUsageVerify = $True
                                allProperties = $True
                                isEnabled = $True
                                credentialsWithUsageSign = $True
                            }
                            description = "FakeStringValue"
                            signInAudience = "FakeStringValue"
                            '@odata.type' = "#microsoft.graph.Application"
                            optionalClaims = @{
                                idToken = @(
                                    @{
                                        source = "FakeStringValue"
                                        essential = $True
                                        additionalProperties = @("FakeStringValue")
                                        name = "FakeStringValue"
                                    }
                                )
                                accessToken = @(
                                    @{
                                        source = "FakeStringValue"
                                        essential = $True
                                        additionalProperties = @("FakeStringValue")
                                        name = "FakeStringValue"
                                    }
                                )
                                saml2Token = @(
                                    @{
                                        source = "FakeStringValue"
                                        essential = $True
                                        additionalProperties = @("FakeStringValue")
                                        name = "FakeStringValue"
                                    }
                                )
                            }
                            identifierUris = @("FakeStringValue")
                            keyCredentials = @(
                                @{
                                    startDateTime = "2023-01-01T00:00:00.0000000+00:00"
                                    displayName = "FakeStringValue"
                                    endDateTime = "2023-01-01T00:00:00.0000000+00:00"
                                    type = "FakeStringValue"
                                    usage = "FakeStringValue"
                                }
                            )
                            parentalControlSettings = @{
                                countriesBlockedForMinors = @("FakeStringValue")
                                legalAgeGroupRule = "FakeStringValue"
                            }
                            publisherDomain = "FakeStringValue"
                            requiredResourceAccess = @(
                                @{
                                    resourceAccess = @(
                                        @{
                                            type = "FakeStringValue"
                                        }
                                    )
                                    resourceAppId = "FakeStringValue"
                                }
                            )
                            api = @{
                                requestedAccessTokenVersion = 25
                                acceptMappedClaims = $True
                                oauth2PermissionScopes = @(
                                    @{
                                        userConsentDescription = "FakeStringValue"
                                        value = "FakeStringValue"
                                        isEnabled = $True
                                        adminConsentDescription = "FakeStringValue"
                                        adminConsentDisplayName = "FakeStringValue"
                                        origin = "FakeStringValue"
                                        userConsentDisplayName = "FakeStringValue"
                                        type = "FakeStringValue"
                                    }
                                )
                                preAuthorizedApplications = @(
                                    @{
                                        delegatedPermissionIds = @("FakeStringValue")
                                        appId = "FakeStringValue"
                                    }
                                )
                                knownClientApplications = $True
                            }
                            disabledByMicrosoftStatus = "FakeStringValue"
                        }
                        deletedDateTime = "2023-01-01T00:00:00.0000000+00:00"
                        id = "FakeStringValue"

                    }
                }
            }


            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name "The AADApplication exists and values are NOT in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    addIns = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_MicrosoftGraphaddIn -Property @{
                            type = "FakeStringValue"
                            properties = [CimInstance[]]@(
                                (New-CimInstance -ClassName MSFT_MicrosoftGraphkeyValue -Property @{
                                    value = "FakeStringValue"
                                    key = "FakeStringValue"
                                } -ClientOnly)
                            )
                        } -ClientOnly)
                    )
                    api = (New-CimInstance -ClassName MSFT_MicrosoftGraphapiApplication -Property @{
                        requestedAccessTokenVersion = 25
                        acceptMappedClaims = $True
                        oauth2PermissionScopes = [CimInstance[]]@(
                            (New-CimInstance -ClassName MSFT_MicrosoftGraphpermissionScope -Property @{
                                userConsentDescription = "FakeStringValue"
                                value = "FakeStringValue"
                                isEnabled = $True
                                adminConsentDescription = "FakeStringValue"
                                adminConsentDisplayName = "FakeStringValue"
                                origin = "FakeStringValue"
                                userConsentDisplayName = "FakeStringValue"
                                type = "FakeStringValue"
                            } -ClientOnly)
                        )
                        preAuthorizedApplications = [CimInstance[]]@(
                            (New-CimInstance -ClassName MSFT_MicrosoftGraphpreAuthorizedApplication -Property @{
                                delegatedPermissionIds = @("FakeStringValue")
                                appId = "FakeStringValue"
                            } -ClientOnly)
                        )
                        knownClientApplications = $True
                    } -ClientOnly)
                    appId = "FakeStringValue"
                    applicationTemplateId = "FakeStringValue"
                    appRoles = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_MicrosoftGraphappRole -Property @{
                            description = "FakeStringValue"
                            value = "FakeStringValue"
                            displayName = "FakeStringValue"
                            allowedMemberTypes = @("FakeStringValue")
                            origin = "FakeStringValue"
                            isEnabled = $True
                        } -ClientOnly)
                    )
                    certification = (New-CimInstance -ClassName MSFT_MicrosoftGraphcertification -Property @{
                        certificationDetailsUrl = "FakeStringValue"
                        certificationExpirationDateTime = "2023-01-01T00:00:00.0000000+00:00"
                        isPublisherAttested = $True
                        lastCertificationDateTime = "2023-01-01T00:00:00.0000000+00:00"
                        isCertifiedByMicrosoft = $True
                    } -ClientOnly)
                    createdDateTime = "2023-01-01T00:00:00.0000000+00:00"
                    defaultRedirectUri = "FakeStringValue"
                    deletedDateTime = "2023-01-01T00:00:00.0000000+00:00"
                    description = "FakeStringValue"
                    disabledByMicrosoftStatus = "FakeStringValue"
                    displayName = "FakeStringValue"
                    groupMembershipClaims = "FakeStringValue"
                    id = "FakeStringValue"
                    identifierUris = @("FakeStringValue")
                    info = (New-CimInstance -ClassName MSFT_MicrosoftGraphinformationalUrl -Property @{
                        privacyStatementUrl = "FakeStringValue"
                        termsOfServiceUrl = "FakeStringValue"
                        logoUrl = "FakeStringValue"
                        supportUrl = "FakeStringValue"
                        marketingUrl = "FakeStringValue"
                    } -ClientOnly)
                    isDeviceOnlyAuthSupported = $True
                    isFallbackPublicClient = $True
                    keyCredentials = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_MicrosoftGraphkeyCredential -Property @{
                            startDateTime = "2023-01-01T00:00:00.0000000+00:00"
                            displayName = "FakeStringValue"
                            endDateTime = "2023-01-01T00:00:00.0000000+00:00"
                            type = "FakeStringValue"
                            usage = "FakeStringValue"
                        } -ClientOnly)
                    )
                    notes = "FakeStringValue"
                    oauth2RequirePostResponse = $True
                    optionalClaims = (New-CimInstance -ClassName MSFT_MicrosoftGraphoptionalClaims -Property @{
                        idToken = [CimInstance[]]@(
                            (New-CimInstance -ClassName MSFT_MicrosoftGraphoptionalClaim -Property @{
                                source = "FakeStringValue"
                                essential = $True
                                additionalProperties = @("FakeStringValue")
                                name = "FakeStringValue"
                            } -ClientOnly)
                        )
                        accessToken = [CimInstance[]]@(
                            (New-CimInstance -ClassName MSFT_MicrosoftGraphoptionalClaim -Property @{
                                source = "FakeStringValue"
                                essential = $True
                                additionalProperties = @("FakeStringValue")
                                name = "FakeStringValue"
                            } -ClientOnly)
                        )
                        saml2Token = [CimInstance[]]@(
                            (New-CimInstance -ClassName MSFT_MicrosoftGraphoptionalClaim -Property @{
                                source = "FakeStringValue"
                                essential = $True
                                additionalProperties = @("FakeStringValue")
                                name = "FakeStringValue"
                            } -ClientOnly)
                        )
                    } -ClientOnly)
                    parentalControlSettings = (New-CimInstance -ClassName MSFT_MicrosoftGraphparentalControlSettings -Property @{
                        countriesBlockedForMinors = @("FakeStringValue")
                        legalAgeGroupRule = "FakeStringValue"
                    } -ClientOnly)
                    passwordCredentials = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_MicrosoftGraphpasswordCredential -Property @{
                            displayName = "FakeStringValue"
                            startDateTime = "2023-01-01T00:00:00.0000000+00:00"
                            hint = "FakeStringValue"
                            secretText = "FakeStringValue"
                            endDateTime = "2023-01-01T00:00:00.0000000+00:00"
                        } -ClientOnly)
                    )
                    publicClient = (New-CimInstance -ClassName MSFT_MicrosoftGraphpublicClientApplication -Property @{
                        redirectUris = @("FakeStringValue")
                    } -ClientOnly)
                    publisherDomain = "FakeStringValue"
                    requestSignatureVerification = (New-CimInstance -ClassName MSFT_MicrosoftGraphrequestSignatureVerification -Property @{
                        isSignedRequestRequired = $True
                        allowedWeakAlgorithms = "rsaSha1"
                    } -ClientOnly)
                    requiredResourceAccess = [CimInstance[]]@(
                        (New-CimInstance -ClassName MSFT_MicrosoftGraphrequiredResourceAccess -Property @{
                            resourceAccess = [CimInstance[]]@(
                                (New-CimInstance -ClassName MSFT_MicrosoftGraphresourceAccess -Property @{
                                    type = "FakeStringValue"
                                } -ClientOnly)
                            )
                            resourceAppId = "FakeStringValue"
                        } -ClientOnly)
                    )
                    samlMetadataUrl = "FakeStringValue"
                    serviceManagementReference = "FakeStringValue"
                    servicePrincipalLockConfiguration = (New-CimInstance -ClassName MSFT_MicrosoftGraphservicePrincipalLockConfiguration -Property @{
                        tokenEncryptionKeyId = $True
                        credentialsWithUsageVerify = $True
                        allProperties = $True
                        isEnabled = $True
                        credentialsWithUsageSign = $True
                    } -ClientOnly)
                    signInAudience = "FakeStringValue"
                    spa = (New-CimInstance -ClassName MSFT_MicrosoftGraphspaApplication -Property @{
                        redirectUris = @("FakeStringValue")
                    } -ClientOnly)
                    tags = @("FakeStringValue")
                    uniqueName = "FakeStringValue"
                    verifiedPublisher = (New-CimInstance -ClassName MSFT_MicrosoftGraphverifiedPublisher -Property @{
                        verifiedPublisherId = "FakeStringValue"
                        addedDateTime = "2023-01-01T00:00:00.0000000+00:00"
                        displayName = "FakeStringValue"
                    } -ClientOnly)
                    web = (New-CimInstance -ClassName MSFT_MicrosoftGraphwebApplication -Property @{
                        redirectUriSettings = [CimInstance[]]@(
                            (New-CimInstance -ClassName MSFT_MicrosoftGraphredirectUriSettings -Property @{
                                index = 25
                                uri = "FakeStringValue"
                            } -ClientOnly)
                        )
                        homePageUrl = "FakeStringValue"
                        logoutUrl = "FakeStringValue"
                        implicitGrantSettings = (New-CimInstance -ClassName MSFT_MicrosoftGraphimplicitGrantSettings -Property @{
                            enableAccessTokenIssuance = $True
                            enableIdTokenIssuance = $True
                        } -ClientOnly)
                        redirectUris = @("FakeStringValue")
                    } -ClientOnly)
                    Ensure = 'Present'
                    Credential = $Credential;
                }

                Mock -CommandName Get-MgApplication -MockWith {
                    return @{
                        AdditionalProperties = @{
                            spa = @{
                                redirectUris = @("FakeStringValue")
                            }
                            serviceManagementReference = "FakeStringValue"
                            certification = @{
                                certificationExpirationDateTime = "2023-01-01T00:00:00.0000000+00:00"
                                certificationDetailsUrl = "FakeStringValue"
                                lastCertificationDateTime = "2023-01-01T00:00:00.0000000+00:00"
                            }
                            defaultRedirectUri = "FakeStringValue"
                            web = @{
                                redirectUriSettings = @(
                                    @{
                                        index = 7
                                        uri = "FakeStringValue"
                                    }
                                )
                                homePageUrl = "FakeStringValue"
                                logoutUrl = "FakeStringValue"
                                implicitGrantSettings = @{
                                }
                                redirectUris = @("FakeStringValue")
                            }
                            groupMembershipClaims = "FakeStringValue"
                            samlMetadataUrl = "FakeStringValue"
                            info = @{
                                privacyStatementUrl = "FakeStringValue"
                                termsOfServiceUrl = "FakeStringValue"
                                logoUrl = "FakeStringValue"
                                supportUrl = "FakeStringValue"
                                marketingUrl = "FakeStringValue"
                            }
                            uniqueName = "FakeStringValue"
                            passwordCredentials = @(
                                @{
                                    displayName = "FakeStringValue"
                                    startDateTime = "2023-01-01T00:00:00.0000000+00:00"
                                    hint = "FakeStringValue"
                                    secretText = "FakeStringValue"
                                    endDateTime = "2023-01-01T00:00:00.0000000+00:00"
                                }
                            )
                            appId = "FakeStringValue"
                            appRoles = @(
                                @{
                                    origin = "FakeStringValue"
                                    allowedMemberTypes = @("FakeStringValue")
                                    value = "FakeStringValue"
                                    description = "FakeStringValue"
                                    displayName = "FakeStringValue"
                                }
                            )
                            tags = @("FakeStringValue")
                            publicClient = @{
                                redirectUris = @("FakeStringValue")
                            }
                            notes = "FakeStringValue"
                            requestSignatureVerification = @{
                                allowedWeakAlgorithms = "rsaSha1"
                            }
                            createdDateTime = "2023-01-01T00:00:00.0000000+00:00"
                            applicationTemplateId = "FakeStringValue"
                            displayName = "FakeStringValue"
                            verifiedPublisher = @{
                                verifiedPublisherId = "FakeStringValue"
                                addedDateTime = "2023-01-01T00:00:00.0000000+00:00"
                                displayName = "FakeStringValue"
                            }
                            addIns = @(
                                @{
                                    type = "FakeStringValue"
                                    properties = @(
                                        @{
                                            value = "FakeStringValue"
                                            key = "FakeStringValue"
                                        }
                                    )
                                }
                            )
                            servicePrincipalLockConfiguration = @{
                            }
                            description = "FakeStringValue"
                            signInAudience = "FakeStringValue"
                            optionalClaims = @{
                                idToken = @(
                                    @{
                                        source = "FakeStringValue"
                                        name = "FakeStringValue"
                                        additionalProperties = @("FakeStringValue")
                                    }
                                )
                                accessToken = @(
                                    @{
                                        source = "FakeStringValue"
                                        name = "FakeStringValue"
                                        additionalProperties = @("FakeStringValue")
                                    }
                                )
                                saml2Token = @(
                                    @{
                                        source = "FakeStringValue"
                                        name = "FakeStringValue"
                                        additionalProperties = @("FakeStringValue")
                                    }
                                )
                            }
                            parentalControlSettings = @{
                                countriesBlockedForMinors = @("FakeStringValue")
                                legalAgeGroupRule = "FakeStringValue"
                            }
                            identifierUris = @("FakeStringValue")
                            keyCredentials = @(
                                @{
                                    startDateTime = "2023-01-01T00:00:00.0000000+00:00"
                                    displayName = "FakeStringValue"
                                    endDateTime = "2023-01-01T00:00:00.0000000+00:00"
                                    type = "FakeStringValue"
                                    usage = "FakeStringValue"
                                }
                            )
                            publisherDomain = "FakeStringValue"
                            requiredResourceAccess = @(
                                @{
                                    resourceAccess = @(
                                        @{
                                            type = "FakeStringValue"
                                        }
                                    )
                                    resourceAppId = "FakeStringValue"
                                }
                            )
                            api = @{
                                requestedAccessTokenVersion = 7
                                oauth2PermissionScopes = @(
                                    @{
                                        value = "FakeStringValue"
                                        userConsentDescription = "FakeStringValue"
                                        adminConsentDescription = "FakeStringValue"
                                        userConsentDisplayName = "FakeStringValue"
                                        origin = "FakeStringValue"
                                        adminConsentDisplayName = "FakeStringValue"
                                        type = "FakeStringValue"
                                    }
                                )
                                preAuthorizedApplications = @(
                                    @{
                                        delegatedPermissionIds = @("FakeStringValue")
                                        appId = "FakeStringValue"
                                    }
                                )
                            }
                            disabledByMicrosoftStatus = "FakeStringValue"
                        }
                        deletedDateTime = "2023-01-01T00:00:00.0000000+00:00"
                        id = "FakeStringValue"
                    }
                }
            }

            It 'Should return Values from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should call the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName Update-MgApplication -Exactly 1
            }
        }

        Context -Name 'ReverseDSC Tests' -Fixture {
            BeforeAll {
                $Global:CurrentModeIsExport = $true
                $Global:PartialExportFileName = "$(New-Guid).partial.ps1"
                $testParams = @{
                    Credential = $Credential
                }

                Mock -CommandName Get-MgApplication -MockWith {
                    return @{
                        AdditionalProperties = @{
                            oauth2RequirePostResponse = $True
                            isDeviceOnlyAuthSupported = $True
                            certification = @{
                                certificationDetailsUrl = "FakeStringValue"
                                certificationExpirationDateTime = "2023-01-01T00:00:00.0000000+00:00"
                                isPublisherAttested = $True
                                lastCertificationDateTime = "2023-01-01T00:00:00.0000000+00:00"
                                isCertifiedByMicrosoft = $True
                            }
                            defaultRedirectUri = "FakeStringValue"
                            serviceManagementReference = "FakeStringValue"
                            web = @{
                                redirectUriSettings = @(
                                    @{
                                        index = 25
                                        uri = "FakeStringValue"
                                    }
                                )
                                homePageUrl = "FakeStringValue"
                                logoutUrl = "FakeStringValue"
                                implicitGrantSettings = @{
                                    enableAccessTokenIssuance = $True
                                    enableIdTokenIssuance = $True
                                }
                                redirectUris = @("FakeStringValue")
                            }
                            groupMembershipClaims = "FakeStringValue"
                            samlMetadataUrl = "FakeStringValue"
                            info = @{
                                privacyStatementUrl = "FakeStringValue"
                                termsOfServiceUrl = "FakeStringValue"
                                logoUrl = "FakeStringValue"
                                supportUrl = "FakeStringValue"
                                marketingUrl = "FakeStringValue"
                            }
                            uniqueName = "FakeStringValue"
                            passwordCredentials = @(
                                @{
                                    displayName = "FakeStringValue"
                                    startDateTime = "2023-01-01T00:00:00.0000000+00:00"
                                    hint = "FakeStringValue"
                                    secretText = "FakeStringValue"
                                    endDateTime = "2023-01-01T00:00:00.0000000+00:00"
                                }
                            )
                            appId = "FakeStringValue"
                            appRoles = @(
                                @{
                                    description = "FakeStringValue"
                                    value = "FakeStringValue"
                                    displayName = "FakeStringValue"
                                    allowedMemberTypes = @("FakeStringValue")
                                    origin = "FakeStringValue"
                                    isEnabled = $True
                                }
                            )
                            notes = "FakeStringValue"
                            publicClient = @{
                                redirectUris = @("FakeStringValue")
                            }
                            isFallbackPublicClient = $True
                            requestSignatureVerification = @{
                                isSignedRequestRequired = $True
                                allowedWeakAlgorithms = "rsaSha1"
                            }
                            tags = @("FakeStringValue")
                            createdDateTime = "2023-01-01T00:00:00.0000000+00:00"
                            spa = @{
                                redirectUris = @("FakeStringValue")
                            }
                            displayName = "FakeStringValue"
                            verifiedPublisher = @{
                                verifiedPublisherId = "FakeStringValue"
                                addedDateTime = "2023-01-01T00:00:00.0000000+00:00"
                                displayName = "FakeStringValue"
                            }
                            applicationTemplateId = "FakeStringValue"
                            addIns = @(
                                @{
                                    type = "FakeStringValue"
                                    properties = @(
                                        @{
                                            value = "FakeStringValue"
                                            key = "FakeStringValue"
                                        }
                                    )
                                }
                            )
                            servicePrincipalLockConfiguration = @{
                                tokenEncryptionKeyId = $True
                                credentialsWithUsageVerify = $True
                                allProperties = $True
                                isEnabled = $True
                                credentialsWithUsageSign = $True
                            }
                            description = "FakeStringValue"
                            signInAudience = "FakeStringValue"
                            '@odata.type' = "#microsoft.graph.Application"
                            optionalClaims = @{
                                idToken = @(
                                    @{
                                        source = "FakeStringValue"
                                        essential = $True
                                        additionalProperties = @("FakeStringValue")
                                        name = "FakeStringValue"
                                    }
                                )
                                accessToken = @(
                                    @{
                                        source = "FakeStringValue"
                                        essential = $True
                                        additionalProperties = @("FakeStringValue")
                                        name = "FakeStringValue"
                                    }
                                )
                                saml2Token = @(
                                    @{
                                        source = "FakeStringValue"
                                        essential = $True
                                        additionalProperties = @("FakeStringValue")
                                        name = "FakeStringValue"
                                    }
                                )
                            }
                            identifierUris = @("FakeStringValue")
                            keyCredentials = @(
                                @{
                                    startDateTime = "2023-01-01T00:00:00.0000000+00:00"
                                    displayName = "FakeStringValue"
                                    endDateTime = "2023-01-01T00:00:00.0000000+00:00"
                                    type = "FakeStringValue"
                                    usage = "FakeStringValue"
                                }
                            )
                            parentalControlSettings = @{
                                countriesBlockedForMinors = @("FakeStringValue")
                                legalAgeGroupRule = "FakeStringValue"
                            }
                            publisherDomain = "FakeStringValue"
                            requiredResourceAccess = @(
                                @{
                                    resourceAccess = @(
                                        @{
                                            type = "FakeStringValue"
                                        }
                                    )
                                    resourceAppId = "FakeStringValue"
                                }
                            )
                            api = @{
                                requestedAccessTokenVersion = 25
                                acceptMappedClaims = $True
                                oauth2PermissionScopes = @(
                                    @{
                                        userConsentDescription = "FakeStringValue"
                                        value = "FakeStringValue"
                                        isEnabled = $True
                                        adminConsentDescription = "FakeStringValue"
                                        adminConsentDisplayName = "FakeStringValue"
                                        origin = "FakeStringValue"
                                        userConsentDisplayName = "FakeStringValue"
                                        type = "FakeStringValue"
                                    }
                                )
                                preAuthorizedApplications = @(
                                    @{
                                        delegatedPermissionIds = @("FakeStringValue")
                                        appId = "FakeStringValue"
                                    }
                                )
                                knownClientApplications = $True
                            }
                            disabledByMicrosoftStatus = "FakeStringValue"
                        }
                        deletedDateTime = "2023-01-01T00:00:00.0000000+00:00"
                        id = "FakeStringValue"

                    }
                }
            }
            It 'Should Reverse Engineer resource from the Export method' {
                $result = Export-TargetResource @testParams
                $result | Should -Not -BeNullOrEmpty
            }
        }
    }
}

Invoke-Command -ScriptBlock $Global:DscHelper.CleanupScript -NoNewScope
