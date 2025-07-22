# Cato-Terraform-Example-Usage

The Cato Terraform Example Usage project provides functional examples of how to use the cato terrafrom provider resources and modules for real-world deployment use cases.  

## Contents

1. [System Requirements](#requirements)
   * [Terraform Installation](#terraform-installation)
   * [Cloud Provider Configuration](#cloud-provider-configuration)
2. [Setting up environment variables](setting-up-environment-variables)
3. [Getting started](#getting-started)
   * [Usage Instructions](#usage-instructions)
   * [Run Your Deployment](#run-your-deployment)
   * [Apply Specific Modules](#applying-specific-modules)
   * [Terminal Command Aliases](#terminal-command-aliases)

### Terraform Installation

Setup instructions for installing terraform on your host.

<details>
<summary>Install Terraform on Mac</summary>

1. Option 1: Using Homebrew (Recommended)
    ```bash
    brew tap hashicorp/tap
    brew install hashicorp/tap/terraform
    ```
1. Option 2: Manual Install
	1.	Go to the [Terraform Downloads page](https://developer.hashicorp.com/terraform/downloads).
	2.	Download the macOS (arm64 or amd64) .zip file depending on your chip (M1/M2 = arm64).
	3.	Unzip and move the binary to /usr/local/bin/:
    ```bash
    sudo mv terraform /usr/local/bin/
    chmod +x /usr/local/bin/terraform
    ```
</details>

<details>
<summary>Install Terraform on Windows</summary>

### Host setup Windows
1. Option 1: Using Chocolatey (Recommended)
    ```bash
    choco install terraform -y
    ```
1. Option 2: Manual Install
	- Go to the [Terraform Downloads page](https://developer.hashicorp.com/terraform/downloads).
	- Download the Windows (amd64) .zip file.
	- Unzip it and place the terraform.exe file somewhere in your system’s PATH (e.g., C:\terraform).
	- Open a new Command Prompt and run: `terraform -version`
</details>

### Cloud Provider Configuration

Terraform requires the respective cloud provider CLIs—AWS CLI, Azure CLI, and Google Cloud SDK (gcloud)—to be installed and properly configured on your local machine.

<details>
<summary>AWS CLI Installation Guide</summary>

### Prerequisites
- **macOS**: Python 3.8+ (check with `python3 --version`).
- **Windows**: Windows 10 or later (64-bit recommended).
- AWS account with Access Key ID and Secret Access Key (generate via AWS IAM).

### Installation

#### macOS
1. Install via Homebrew (recommended):
   ```bash
   brew install awscli
   ```
2. Alternatively, use the bundled installer:
   ```bash
   curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
   sudo installer -pkg AWSCLIV2.pkg -target /
   ```
3. Verify installation:
   ```bash
   aws --version
   ```

#### Windows
1. Download the MSI installer from [AWS CLI v2](https://awscli.amazonaws.com/AWSCLIV2.msi).
2. Run the installer:
   ```powershell
   msiexec.exe /i AWSCLIV2.msi
   ```
   - For silent installation: `msiexec.exe /i AWSCLIV2.msi /qn`
3. Verify installation:
   ```powershell
   aws --version
   ```

### Configuration
1. Run the configuration command:
   ```bash
   aws configure
   ```
2. Enter the following when prompted:
   - AWS Access Key ID
   - AWS Secret Access Key
   - Default region (e.g., `us-east-1`)
   - Output format (e.g., `json`)
3. Verify configuration:
   ```bash
   aws sts get-caller-identity
   ```

**References**: [AWS CLI Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)[](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

## Troubleshooting
- **AWS CLI**: If `aws --version` fails, check PATH or reinstall. See [AWS CLI Troubleshooting](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-troubleshooting.html).[](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

## Updating CLI
- **AWS CLI**:
  ```bash
  brew upgrade awscli  # macOS
  winget upgrade --id Amazon.AWSCLI  # Windows
  ```

</details>

<details>
<summary>Azure CLI Installation Guide</summary>
### Prerequisites
- **macOS**: Homebrew installed (`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`).
- **Windows**: PowerShell 5.1+ or Windows 10/11.
- Azure account with active subscription.

### Installation

#### macOS
1. Install via Homebrew:
   ```bash
   brew install azure-cli
   ```
2. Verify installation:
   ```bash
   az version
   ```

#### Windows
1. Install via WinGet (recommended):
   ```powershell
   winget install --exact --id Microsoft.AzureCLI
   ```
2. Alternatively, download the MSI installer from [Azure CLI Releases](https://aka.ms/installazurecliwindows).
3. Run the MSI installer and follow prompts.
4. Verify installation:
   ```powershell
   az version
   ```

### Configuration
1. Log in to Azure:
   ```bash
   az login
   ```
   - Follow the browser prompt to authenticate.
2. Verify subscription access:
   ```bash
   az account show
   ```
3. (Optional) Set default subscription:
   ```bash
   az account set --subscription <subscription-id>
   ```

**References**: [Azure CLI Installation Guide](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)[](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)

## Troubleshooting
- **Azure CLI**: Restart terminal after installation. For proxy issues, configure `HTTP_PROXY`/`HTTPS_PROXY` variables.[](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-windows?view=azure-cli-latest)

## Updating CLI
- **Azure CLI**:
  ```bash
  brew upgrade azure-cli  # macOS
  winget upgrade --id Microsoft.AzureCLI  # Windows
  ```
</details>

<details>
<summary>GCP CLI (gcloud) Installation Guide</summary>
### Prerequisites
- **macOS**: Python 3.8–3.13 (check with `python3 -V`).
- **Windows**: Windows 8.1+ with PowerShell.
- Google Cloud account with a project.

### Installation

#### macOS
1. Download the archive for your architecture (e.g., x86_64 or ARM64):
   ```bash
   curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-<version>-darwin-<arch>.tar.gz
   ```
2. Extract and install:
   ```bash
   tar -xvf google-cloud-cli-<version>-darwin-<arch>.tar.gz
   ./google-cloud-sdk/install.sh
   ```
3. Initialize the CLI:
   ```bash
   ./google-cloud-sdk/bin/gcloud init
   ```
4. Verify installation:
   ```bash
   gcloud --version
   ```

#### Windows
1. Download the installer from [Google Cloud CLI](https://dl.google.com/dl/cloudsdk/channels/rapid/GoogleCloudSDKInstaller.exe).
2. Run the installer and follow prompts.
   - Alternatively, use PowerShell:
     ```powershell
     (New-Object Net.WebClient).DownloadFile("https://dl.google.com/dl/cloudsdk/channels/rapid/GoogleCloudSDKInstaller.exe", "$env:Temp\GoogleCloudSDKInstaller.exe")
     & $env:Temp\GoogleCloudSDKInstaller.exe
     ```
3. Initialize the CLI:
   ```powershell
   gcloud init
   ```
4. Verify installation:
   ```powershell
   gcloud --version
   ```

### Configuration
1. During `gcloud init`, follow prompts to:
   - Log in via browser.
   - Select a project.
   - Set a default region/zone (optional).
2. Verify configuration:
   ```bash
   gcloud config list
   ```

**References**: [Google Cloud CLI Installation Guide](https://cloud.google.com/sdk/docs/install)[](https://cloud.google.com/sdk/docs/install)

## Troubleshooting
- **gcloud CLI**: Ensure Python is in PATH. Reboot if installation fails.[](https://cloud.google.com/sdk/docs/install)

## Updating CLI
- **gcloud CLI**:
  ```bash
  gcloud components update
  ```
</details>


## Setting up environment variables

Create system environment variables for the cato token and account id.  Using the `TF_VAR` prefix when creating environment variables tells terraform to resolve those values from the host OS as opposed to in your local variables files.  
WARNING: DO NOT add your cato token in clear text to any variable files on your local system. 


<details>
<summary>Setting environment variables in Unix</summary>
Use the following syntax in a unix command prompt to temporarily set environment variables.

```bash
set TF_VAR_account_id=xxxxx
set TF_VAR_cato_token=xxxxx
```
To make these values persistent, run either `vi ~/.bash_profile` or `vi ~/.zshrc`, and add the following lines.

```bash
set TF_VAR_account_id=xxxxx
set TF_VAR_cato_token=xxxxx
```
</details>
<details>
<summary>Setting environment variables in Windows</summary>
Use the following syntax in a windows command prompt to temporarily set environment variables.
```bash
set TF_VAR_account_id=xxxxx
set TF_VAR_cato_token=xxxxx
```
To make these values persistent, run the following windows command prompt:
```bash
setx TF_VAR_account_id=xxxxx
setx TF_VAR_cato_token=xxxxx
```
NOTE: On a local system, variables created or modified by this tool will be available in future command windows but not in the current CMD.exe command window.
</details>
<details>
<summary>Setting environment variables in Windows Powershell</summary>
Use the following syntax in a powershell command prompt to temporarily set environment variables.
```bash
$env:TF_VAR_account_id = "xxxxx" 
$env:TF_VAR_cato_token = "xxxxx"
```
To make these values persistent, run the following in a powershell terminal as Admin (UserLevel):
```bash
[System.Environment]::SetEnvironmentVariable('TF_VAR_account_id','xxxxxxx', 'User')
[System.Environment]::SetEnvironmentVariable('TF_VAR_cato_token','xxxxxxx', 'User')
```
</details>

## Getting Started

<details>
<summary>Avaialble Cato modules and default networks</summary>

Below is a list of the terraform modules included in this package, and the associated default networks for those modules to be used as an example.  Each module exposes variables to override these networks and module settings as needed on a per module basis.  

| Cato Module           | Network        | Module Deployment Time | Test Environment Deployment Time | 
|-----------------------|----------------|------------------------|----------------------------------|
| [aws-ipsec](./modules/cato/aws/ipsec/README.md) | 10.0.0.0/16 | 40 min |
| [aws-socket](./modules/cato/aws/vsocket/README.md) | 10.1.0.0/16     |  5 min |
| [aws-socket-vpc](https://registry.terraform.io/modules/catonetworks/vsocket-aws-vpc/cato/latest) | 10.2.0.0/16 | 5 min | N/A | 
| [aws-socket-ha](https://registry.terraform.io/modules/catonetworks/vsocket-aws-ha/cato/latest) | 10.3.0.0/16 | 16 min | N/A | 
| [aws-socket-ha-vpc](https://registry.terraform.io/modules/catonetworks/vsocket-aws-ha-vpc/cato/latest) | 10.4.0.0/16 | 16 min | N/A | 
| [aws-socket-tgw](https://registry.terraform.io/modules/catonetworks/vsocket-aws-tgw/cato/latest) | 10.5.0.0/16 | 5 min | 13 min |
| [aws-socket-tgw-ha](https://registry.terraform.io/modules/catonetworks/vsocket-aws-tgw-ha/cato/latest) | 10.6.0.0/16 | 16 min | 25 min |
| [aws-ipsec-tgw](https://registry.terraform.io/modules/catonetworks/ipsec-aws-tgw/cato/latest) | 10.7.0.0/16 | 10 min | 20 min
| [azure-ipsec](https://registry.terraform.io/modules/catonetworks/ipsec-azure/cato/latest) | 10.50.0.0/16 | 40 min | N/A | 
| [azure-socket](https://registry.terraform.io/modules/catonetworks/vsocket-azure/cato/latest) | 10.51.0.0/16 | 6 min | N/A | 
| [azure-socket-vnet](https://registry.terraform.io/modules/catonetworks/vsocket-azure-vnet/cato/latest) | 10.52.0.0/16 | 6 min | N/A |
| [azure-socket-ha](https://registry.terraform.io/modules/catonetworks/vsocket-azure-ha/cato/latest) | 10.53.0.0/16 | 16 min | N/A | 
| [azure-socket-ha-vnet](https://registry.terraform.io/modules/catonetworks/vsocket-azure-ha-vpc/cato/latest) | 10.54.0.0/16 | 16 min | N/A |
| [azure-vwan](https://registry.terraform.io/modules/catonetworks/vsocket-azure-vwan/cato/latest) | 10.55.0.0/16 | 120 min | N/A |
| [azure-socket-ha-vnet-2nic](https://github.com/catonetworks/terraform-cato-vsocket-azure-ha-vnet-2nic) 10.56.0.0/16 | 25 min | N/A |
| [gcp-ipsec](https://registry.terraform.io/modules/catonetworks/vsocket-gcp-ipsec/cato/latest) | 10.100.0.0/16 | n/a | N/A |
| [gcp-socket](https://registry.terraform.io/modules/catonetworks/vsocket-gcp/cato/latest) | 10.101.0.0/16 | 5 min | N/A | 
| [gcp-socket-vpc](https://registry.terraform.io/modules/catonetworks/vsocket-gcp-vpc/cato/latest) | 10.102.0.0/16 | n/a  | N/A |
| [socket](https://registry.terraform.io/modules/catonetworks/socket/cato/latest) | 10.150.0.0/16 | 1 min | N/A |
</details>

### Usage Instructions
After checking out the project, rename the following files removing `.example` from from the file names to start to use in your deployment.  Renaming these files ensures you can start to use this project, and received updaetes to the repo without future code conflicts.  There is a main file created for each cloud environment (AWS, GCP, Azure), as well as a main file for a physical socket.  Rename the main for the deployment you are looking to run.

```bash
git clone https://github.com/catonetworks/terraform-example-usage.git
cd terraform-example-usage
mv terraform.tfvars.example terraform.tfvars
mv main.azure.tf.example main.azure.tf
mv main.aws.tf.example main.aws.tf
mv main.gcp.tf.example main.gcp.tf
mv main.socket.tf.example main.socket.tf
```

Pull in future updates to this repository by using `git pull`.

### Enabling and disabling specific modules

The `terraform.tvars` file contains variable values using a set of boolean flags to selectively enable or disable the deployment of specific Terraform modules across physical socket examples as well as, AWS, Azure, and GCP. 

### Run your deployment
Run `terraform apply` to create and deploy your modules.  
**NOTE** Cato’s backend is API requires sequential execution with the use of terraform's `parallelism=1` to successfully create and update resources (like creating vsockets, firewall rules, and network ranges). 

```hcl
terraform init
terraform plan
terraform apply --auto-approve -parallelism=1
terraform destroy --auto-approve 
```

### Applying Specific Modules
```hcl
terraform init
terraform plan
terraform apply --auto-approve -parallelism=1 -target=module.ipsec-aws
terraform destroy -target=module.ipsec-aws
```

### Terminal Command Aliases
Use the following bash or zsh aliases to simplify running these commands. Run either `vi ~/.bashrc` or `vi ~/.zshrc`, and add the following lines.

```bash
alias tf='terraform'
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfap='terraform apply --auto-approve'
alias tfapp='terraform apply --auto-approve -parallelism=1'
alias tfdap='terraform destroy --auto-approve'
alias tfdapp='terraform destroy --auto-approve -parallelism=1'
alias tfclear='rm -rf .terraform* && rm terraform.tfstate*'
alias tffmt="tf fmt -recursive"
```

<details>
<summary> <strong> 📦 AWS Transit Gateway Test Environment </strong> </summary>
This repo comes with a test enviroment for testing connectivity and displaying how Cato vSockets can be deployed within a cloud provider.  By setting build_aws_vsocket_tgw_test_env = true in the terraform.tfvars file, the test environment for AWS Transit Gateway (Non-HA) will be built automatically 

### Technical Details 
This environment will build 3 VPCs, and associated subnets, route tables, routes, transit gateway, attachments, and transit gateway route tables and routes. This will also build 6 servers, which can be connected to via SSM. 

### Networking Information
| Resource | IP Address | Access Method | Egress Via | Type | 
|----------|------------|----------------|----------------|-----| 
| test-env-vpc1-server-0 | 10.5.1.6 | Connect Via SSM| Cato Socket | AL2023 Unix Server
| test-env-vpc1-server-1 | 10.5.1.134 | Connect Via SSM| Cato Socket | AL2023 Unix Server
| test-env-vpc1-wserver-0 | 10.5.1.7 | Connect Via SSM or RDP | Cato Socket | Windows 2019 Server
| test-env-vpc1-wserver-1 | 10.5.1.135 | Connect Via SSM or RDP | Cato Socket | Windows 2019 Server
| test-env-vpc2-server-0 | 10.5.2.6 | Connect Via SSM| Cato Socket | AL2023 Unix Server
| test-env-vpc2-server-1| 10.5.2.134 | Connect Via SSM| Cato Socket | AL2023 Unix Server
| test-env-vpc2-wserver-0 | 10.5.2.7 | Connect Via SSM or RDP | Cato Socket | Windows 2019 Server
| test-env-vpc2-wserver-1 | 10.5.2.135 | Connect Via SSM or RDP | Cato Socket | Windows 2019 Server
| test-env-vpc3-server-0 | 10.5.5.6 | Connect Via SSM| Public IP and Subnets | AL2023 Unix Server
| test-env-vpc3-server-1 | 10.5.5.136 | Connect Via SSM| Public IP and Subnets | AL2023 Unix Server
| test-env-vpc3-wserver-0 | 10.5.5.7 | Connect Via SSM or RDP | Public IP and Subnets | Windows 2019 Server
| test-env-vpc3-wserver-1 | 10.5.5.135 | Connect Via SSM or RDP | Public IP and Subnets | Windows 2019 Server
| AWS-Cato-vSocket-TGW-Site-vSocket-LAN  | 10.5.0.134  | Connect via CMA | Public IP and Subnets | Cato Socket 
| AWS-Cato-vSocket-TGW-Site-vSocket-WAN  | 10.5.0.70  | Connect via CMA | Public IP and Subnets | Cato Socket 
| AWS-Cato-vSocket-TGW-Site-vSocket-MGMT  | 10.5.0.6  | Connect via CMA | Public IP and Subnets | Cato Socket 

### Diagram
<img src=./images/tgw-test-env.png>
</details>
<p>
<details>
<summary> <strong> 📦 AWS Transit Gateway HA Test Environment </strong> </summary>
This repo comes with a test enviroment for testing connectivity and displaying how Cato vSockets can be deployed within a cloud provider.  By setting build_aws_vsocket_tgw_test_env = true in the terraform.tfvars file, the test environment for AWS Transit Gateway (HA) will be built automatically 

### Technical Details 
This environment will build 3 VPCs, and associated subnets, route tables, routes, transit gateway, attachments, and transit gateway route tables and routes. This will also build 6 servers, which can be connected to via SSM. 

### Networking Information
| Resource | IP Address | Access Method | Egress Via | Type | 
|----------|------------|----------------|----------------|-----| 
| test-env-vpc1-server-0 | 10.6.1.6 | Connect Via SSM| Cato Socket | AL2023 Unix Server
| test-env-vpc1-server-1 | 10.6.1.134 | Connect Via SSM| Cato Socket | AL2023 Unix Server
| test-env-vpc1-wserver-0 | 10.6.1.7 | Connect Via SSM or RDP | Cato Socket | Windows 2019 Server
| test-env-vpc1-wserver-1 | 10.6.1.135 | Connect Via SSM or RDP | Cato Socket | Windows 2019 Server
| test-env-vpc2-server-0 | 10.6.2.6 | Connect Via SSM| Cato Socket | AL2023 Unix Server
| test-env-vpc2-server-1| 10.6.2.134 | Connect Via SSM| Cato Socket | AL2023 Unix Server
| test-env-vpc2-wserver-0 | 10.6.2.7 | Connect Via SSM or RDP | Cato Socket | Windows 2019 Server
| test-env-vpc2-wserver-1 | 10.6.2.135 | Connect Via SSM or RDP | Cato Socket | Windows 2019 Server
| test-env-vpc3-server-0 | 10.6.4.6 | Connect Via SSM| Public IP and Subnets | AL2023 Unix Server
| test-env-vpc3-server-1 | 10.6.4.136 | Connect Via SSM| Public IP and Subnets | AL2023 Unix Server
| test-env-vpc1-wserver-0 | 10.6.5.7 | Connect Via SSM| Public IP and Subnets| Windows 2019 Server
| test-env-vpc1-wserver-1 | 10.6.5.135 | Connect Via SSM| Public IP and Subnets | Windows 2019 Server
| AWS-Cato-vSocket-TGW-HA-Site-LAN-INT-Primary | 10.6.0.70  | Connect via CMA | Public IP and Subnets | Cato Socket 
| AWS-Cato-vSocket-TGW-HA-Site-LAN-INT-Secondary | 10.6.0.86 | Connect via CMA | Public IP and Subnets | Cato Socket 
| AWS-Cato-vSocket-TGW-HA-Site-MGMT-INT-Primary | 10.6.0.6  | Connect via CMA | Public IP and Subnets | Cato Socket 
| AWS-Cato-vSocket-TGW-HA-Site-MGMT-INT-Secondary | 10.6.0.22  | Connect via CMA | Public IP and Subnets | Cato Socket 
| AWS-Cato-vSocket-TGW-HA-Site-WAN-INT-Primary | 10.6.0.38 | Connect via CMA | Public IP and Subnets | Cato Socket 
| AWS-Cato-vSocket-TGW-HA-Site-WAN-INT-Secondary | 10.6.0.54  | Connect via CMA | Public IP and Subnets | Cato Socket 

### Diagram
<img src=./images/tgw-ha-test-env.png>
</details>

details>
<summary> <strong> 📦 AWS Transit Gateway IPSEC Test Environment </strong> </summary>
This repo comes with a test enviroment for testing connectivity and displaying how Cato IPSEC can be deployed within a cloud provider.  By setting build_aws_ipsec_tgw_test_env = true in the terraform.tfvars file, the test environment for AWS Transit Gateway IPSEC will be built automatically 

### Technical Details 
This environment will build 3 VPCs, and associated subnets, route tables, routes, transit gateway, attachments, and transit gateway route tables and routes. This will also build 6 servers, which can be connected to via SSM. 

### Networking Information
| Resource | IP Address | Access Method | Egress Via | Type | 
|----------|------------|----------------|----------------|-----| 
| test-env-vpc1-server-0 | 10.7.1.6 | Connect Via SSM| Cato Socket | AL2023 Unix Server
| test-env-vpc1-server-1 | 10.7.1.134 | Connect Via SSM| Cato Socket | AL2023 Unix Server
| test-env-vpc1-wserver-0 | 10.7.1.7 | Connect Via SSM or RDP | Cato Socket | Windows 2019 Server
| test-env-vpc1-wserver-1 | 10.7.1.135 | Connect Via SSM or RDP | Cato Socket | Windows 2019 Server
| test-env-vpc2-server-0 | 10.7.2.6 | Connect Via SSM| Cato Socket | AL2023 Unix Server
| test-env-vpc2-server-1| 10.7.2.134 | Connect Via SSM| Cato Socket | AL2023 Unix Server
| test-env-vpc2-wserver-0 | 10.7.2.7 | Connect Via SSM or RDP | Cato Socket | Windows 2019 Server
| test-env-vpc2-wserver-1 | 10.7.2.135 | Connect Via SSM or RDP | Cato Socket | Windows 2019 Server
| test-env-vpc3-server-0 | 10.7.4.6 | Connect Via SSM| Public IP and Subnets | AL2023 Unix Server
| test-env-vpc3-server-1 | 10.7.4.136 | Connect Via SSM| Public IP and Subnets | AL2023 Unix Server
| test-env-vpc1-wserver-0 | 10.7.5.7 | Connect Via SSM| Public IP and Subnets| Windows 2019 Server
| test-env-vpc1-wserver-1 | 10.7.5.135 | Connect Via SSM| Public IP and Subnets | Windows 2019 Server


### Diagram
#### Diagram Pending
</details>
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.98.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.1.0 |
| <a name="requirement_cato"></a> [cato](#requirement\_cato) | >= 0.0.30 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 4.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_build_aws_ipsec_tgw_module"></a> [build\_aws\_ipsec\_tgw\_module](#module\_build\_aws\_ipsec\_tgw\_module) | ./modules/cato/aws/ipsec-tgw | n/a |
| <a name="module_build_aws_vsocket_tgw_ha_module"></a> [build\_aws\_vsocket\_tgw\_ha\_module](#module\_build\_aws\_vsocket\_tgw\_ha\_module) | ./modules/cato/aws/vsocket-tgw-ha | n/a |
| <a name="module_ipsec-aws"></a> [ipsec-aws](#module\_ipsec-aws) | ./modules/cato/aws/ipsec | n/a |
| <a name="module_vsocket-aws"></a> [vsocket-aws](#module\_vsocket-aws) | ./modules/cato/aws/vsocket | n/a |
| <a name="module_vsocket-aws-ha"></a> [vsocket-aws-ha](#module\_vsocket-aws-ha) | ./modules/cato/aws/vsocket-ha | n/a |
| <a name="module_vsocket-aws-ha-vpc"></a> [vsocket-aws-ha-vpc](#module\_vsocket-aws-ha-vpc) | ./modules/cato/aws/vsocket-ha-vpc | n/a |
| <a name="module_vsocket-aws-tgw"></a> [vsocket-aws-tgw](#module\_vsocket-aws-tgw) | ./modules/cato/aws/vsocket-tgw | n/a |
| <a name="module_vsocket-aws-vpc"></a> [vsocket-aws-vpc](#module\_vsocket-aws-vpc) | ./modules/cato/aws/vsocket-vpc | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | Cato Networks Account ID | `string` | n/a | yes |
| <a name="input_aws_default_keypair"></a> [aws\_default\_keypair](#input\_aws\_default\_keypair) | AWS Key Pair | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_azure_subscription_id"></a> [azure\_subscription\_id](#input\_azure\_subscription\_id) | Azure Subscription ID | `string` | n/a | yes |
| <a name="input_baseurl"></a> [baseurl](#input\_baseurl) | Cato Networks API URL | `string` | `"https://api.catonetworks.com/api/v1/graphql2"` | no |
| <a name="input_build_aws_ipsec_module"></a> [build\_aws\_ipsec\_module](#input\_build\_aws\_ipsec\_module) | Build AWS IPsec site module | `bool` | `false` | no |
| <a name="input_build_aws_ipsec_tgw_module"></a> [build\_aws\_ipsec\_tgw\_module](#input\_build\_aws\_ipsec\_tgw\_module) | Build AWS IPsec tgw site module | `bool` | `false` | no |
| <a name="input_build_aws_ipsec_tgw_test_env"></a> [build\_aws\_ipsec\_tgw\_test\_env](#input\_build\_aws\_ipsec\_tgw\_test\_env) | Build AWS IPsec tgw test env module | `bool` | `false` | no |
| <a name="input_build_aws_vsocket_ha_module"></a> [build\_aws\_vsocket\_ha\_module](#input\_build\_aws\_vsocket\_ha\_module) | Build AWS vSocket VPC site module | `bool` | `false` | no |
| <a name="input_build_aws_vsocket_ha_vpc_module"></a> [build\_aws\_vsocket\_ha\_vpc\_module](#input\_build\_aws\_vsocket\_ha\_vpc\_module) | Build AWS vSocket VPC site module | `bool` | `false` | no |
| <a name="input_build_aws_vsocket_module"></a> [build\_aws\_vsocket\_module](#input\_build\_aws\_vsocket\_module) | Build AWS vSocket site module | `bool` | `false` | no |
| <a name="input_build_aws_vsocket_tgw_ha_module"></a> [build\_aws\_vsocket\_tgw\_ha\_module](#input\_build\_aws\_vsocket\_tgw\_ha\_module) | Build AWS vSocket tgw ha site module | `bool` | `false` | no |
| <a name="input_build_aws_vsocket_tgw_ha_test_env"></a> [build\_aws\_vsocket\_tgw\_ha\_test\_env](#input\_build\_aws\_vsocket\_tgw\_ha\_test\_env) | Build AWS vSocket tgw ha test env module | `bool` | `false` | no |
| <a name="input_build_aws_vsocket_tgw_module"></a> [build\_aws\_vsocket\_tgw\_module](#input\_build\_aws\_vsocket\_tgw\_module) | Build AWS vSocket tgw site module | `bool` | `false` | no |
| <a name="input_build_aws_vsocket_tgw_test_env"></a> [build\_aws\_vsocket\_tgw\_test\_env](#input\_build\_aws\_vsocket\_tgw\_test\_env) | Build AWS vSocket tgw test env module | `bool` | `false` | no |
| <a name="input_build_aws_vsocket_vpc_module"></a> [build\_aws\_vsocket\_vpc\_module](#input\_build\_aws\_vsocket\_vpc\_module) | Build AWS vSocket VPC site module | `bool` | `false` | no |
| <a name="input_build_azure_ipsec_module"></a> [build\_azure\_ipsec\_module](#input\_build\_azure\_ipsec\_module) | Build Azure IPsec site module | `bool` | `false` | no |
| <a name="input_build_azure_vsocket_ha_module"></a> [build\_azure\_vsocket\_ha\_module](#input\_build\_azure\_vsocket\_ha\_module) | Build Azure vSocket VPC site module | `bool` | `false` | no |
| <a name="input_build_azure_vsocket_ha_vnet_module"></a> [build\_azure\_vsocket\_ha\_vnet\_module](#input\_build\_azure\_vsocket\_ha\_vnet\_module) | Build Azure vSocket VNET site module | `bool` | `false` | no |
| <a name="input_build_azure_vsocket_module"></a> [build\_azure\_vsocket\_module](#input\_build\_azure\_vsocket\_module) | Build Azure vSocket site module | `bool` | `false` | no |
| <a name="input_build_azure_vsocket_vnet_module"></a> [build\_azure\_vsocket\_vnet\_module](#input\_build\_azure\_vsocket\_vnet\_module) | Build Azure vSocket VNET site module | `bool` | `false` | no |
| <a name="input_build_bulk_socket_csv_module"></a> [build\_bulk\_socket\_csv\_module](#input\_build\_bulk\_socket\_csv\_module) | Build Bulk Socket site from csv module | `bool` | `false` | no |
| <a name="input_build_gcp_ipsec_module"></a> [build\_gcp\_ipsec\_module](#input\_build\_gcp\_ipsec\_module) | Build GCP IPsec site module | `bool` | `false` | no |
| <a name="input_build_gcp_vsocket_module"></a> [build\_gcp\_vsocket\_module](#input\_build\_gcp\_vsocket\_module) | Build GCP vSocket site module | `bool` | `false` | no |
| <a name="input_build_gcp_vsocket_vpc_module"></a> [build\_gcp\_vsocket\_vpc\_module](#input\_build\_gcp\_vsocket\_vpc\_module) | Build GCP vSocket VPC site module | `bool` | `false` | no |
| <a name="input_build_socket_csv_module"></a> [build\_socket\_csv\_module](#input\_build\_socket\_csv\_module) | Build Socket site from csv module | `bool` | `false` | no |
| <a name="input_cato_token"></a> [cato\_token](#input\_cato\_token) | Cato Networks API Token | `string` | n/a | yes |
| <a name="input_gcp_region"></a> [gcp\_region](#input\_gcp\_region) | GCP Region for the deployment | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | GCP Project ID for the deployment | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | GCP Zone for the deployment | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpc3_public_ips_from_ipsec_tgw_test_env"></a> [vpc3\_public\_ips\_from\_ipsec\_tgw\_test\_env](#output\_vpc3\_public\_ips\_from\_ipsec\_tgw\_test\_env) | Public IPs of Public VPC servers in the test environment |
| <a name="output_vpc3_public_ips_from_tgw_ha_test_env"></a> [vpc3\_public\_ips\_from\_tgw\_ha\_test\_env](#output\_vpc3\_public\_ips\_from\_tgw\_ha\_test\_env) | Public IPs of Public VPC servers in the test environment |
| <a name="output_vpc3_public_ips_from_tgw_test_env"></a> [vpc3\_public\_ips\_from\_tgw\_test\_env](#output\_vpc3\_public\_ips\_from\_tgw\_test\_env) | Public IPs of Public VPC servers in the test environment |
<!-- END_TF_DOCS -->