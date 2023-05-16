# IAM Demo

## Intended Goals

1. [Deploy an AD Domain in Azure](#deploy-an-ad-domain-in-azure-1)
2. [Setup an Azure AD tenant](#setup-an-azure-ad-tenant-2)
3. [Configure a hybrid identity solution with Azure AD Connect](#configure-a-hybrid-identity-solution-with-azure-ad-connect-3)
4. [Configure Duo MFA to protect login to a computer](#configure-duo-mfa-to-protect-login-to-a-computer-4)
5. [Configure BitWarden to auto-provision/de-provision accounts](#configure-bitwarden-to-auto-provisionde-provision-accounts-5)

## Deploy an AD Domain in Azure {##1}

- Create an Azure Subscription 
- Create an Azure Resource Group
- Create PowerShell script to create VMs
- Create 3 VMs
- Install Active Directory Domain Services Role on TestVM01
- Create new AD Forest on TestVM01
- Join TestVM02 to domain
- Promote VM02 to DC
- Create OU for Users and create test accounts
- Join TestVM03 to domain
- Verify that users can login to domain joined computer (TestVM03)

## Setup an Azure AD tenant {##2}

- [Create AAD Tenant](https://learn.microsoft.com/en-us/azure/active-directory/fundamentals/active-directory-access-create-new-tenant)
    - [Register a custom domain name](https://learn.microsoft.com/en-us/azure/active-directory/fundamentals/add-custom-domain)
    - Create a Global Admin user to administer the tenant
        - Enable MFA for Global Admin user


## Configure a hybrid identity solution with Azure AD Connect  {##3}

- [Setup Azure AD Passthrough Authentication](https://learn.microsoft.com/en-us/azure/active-directory/hybrid/connect/how-to-connect-pta-quick-start)
    - Install Azure AD Connect on a machine in the local domain
    - Run through the setup wizard to configure connection to AAD
    - Run initial sync
    

## Configure Duo MFA to protect login to a computer {##4}


## Configure Bitwarden to auto-provision/de-provision accounts {##5}