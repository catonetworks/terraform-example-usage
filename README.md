# Cato-Terraform-Example-Usage

The Cato Terraform Example Usage project provides functional examples of how to use the cato terrafrom provider resources and modules for real-world deployment use cases.  

## Contents

1. [System Requirements](#requirements)
   * [Terraform Installation](#terraform-installation)
   * [Cloud Provider Configuration](#cloud-provider-configuration)
2. [Getting started](#getting-started)
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
<summary>Install Terraform on Mac</summary>

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


## Getting Started

<details>
<summary>Avaialble Cato modules and default networks</summary>

Below is a list of the terraform modules included in this package, and the associated default networks for those modules to be used as an example.  Each module exposes variables to override these networks and module settings as needed on a per module basis.  

| Cato Module           | Network        | Module Deployment Time
|-----------------------|----------------|------------------------|
| [aws-ipsec](./modules/cato/aws/ipsec/README.md) | 10.0.0.0/16 | 40 min
| [aws-socket](./modules/cato/aws/vsocket/README.md) | 10.1.0.0/16     |  5 min |
| [aws-socket-vpc](https://registry.terraform.io/modules/catonetworks/vsocket-aws-vpc/cato/latest) | 10.2.0.0/16     | 5 min |
| [aws-socket-ha](https://registry.terraform.io/modules/catonetworks/vsocket-aws-ha/cato/latest) | 10.3.0.0/16     | 16 min |
| [aws-socket-ha-vpc](https://registry.terraform.io/modules/catonetworks/vsocket-aws-ha-vpc/cato/latest) | 10.4.0.0/16     | 16 min |
| [aws-socket-tgw](https://registry.terraform.io/modules/catonetworks/vsocket-aws-tgw/cato/latest) | 10.5.0.0/16     | n/a |
| [aws-socket-tgw-ha](https://registry.terraform.io/modules/catonetworks/vsocket-aws-tgw-ha/cato/latest) | 10.6.0.0/16     | n/a  |
| [azure-ipsec](https://registry.terraform.io/modules/catonetworks/ipsec-azure/cato/latest) | 10.50.0.0/16    | 40 min   |
| [azure-socket](https://registry.terraform.io/modules/catonetworks/vsocket-azure/cato/latest) | 10.51.0.0/16    | 6 min  |
| [azure-socket-vnet](https://registry.terraform.io/modules/catonetworks/vsocket-azure-vnet/cato/latest) | 10.52.0.0/16    | 6 min  |
| [azure-socket-ha](https://registry.terraform.io/modules/catonetworks/vsocket-azure-ha/cato/latest) | 10.53.0.0/16    | 16 min  |
| [azure-socket-ha-vnet](https://registry.terraform.io/modules/catonetworks/vsocket-azure-ha-vpc/cato/latest) | 10.54.0.0/16    | 16 min  |
| [azure-vwan](https://registry.terraform.io/modules/catonetworks/vsocket-azure-vwan/cato/latest) | 10.55.0.0/16    | 40 min  |
| [gcp-ipsec](https://registry.terraform.io/modules/catonetworks/vsocket-gcp-ipsec/cato/latest) | 10.100.0.0/16   | n/a  |
| [gcp-socket](https://registry.terraform.io/modules/catonetworks/vsocket-gcp/cato/latest) | 10.101.0.0/16   | 5 min  |
| [gcp-socket-vpc](https://registry.terraform.io/modules/catonetworks/vsocket-gcp-vpc/cato/latest) | 10.102.0.0/16   | n/a  |
</details>

### Usage Instructions
After checking out the project, rename the following files removing `.example` from from the file names to start to use in your deployment.  Renaming these files ensures you can start to use this project, and received updaetes to the repo without future code conflicts.  The following 2 files are the only files you will need to modify. 

```bash
git checkout git@github.com:catonetworks/terraform-example-usage.git
cd terraform-example-usage
mv main.tf.example main.tf
mv terraform.tfvars.example terraform.tfvars
```

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

