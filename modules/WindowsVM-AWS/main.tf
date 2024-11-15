provider "aws" {
  region = var.region
}

data "aws_ami" "windows" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "windows_instance" {
  ami                         = data.aws_ami.windows.id
  instance_type               = "t3.micro"
  subnet_id                   = var.lan_subnet_id
  key_name                    = var.key_pair
  vpc_security_group_ids      = [aws_security_group.windows_sg.id]
  associate_public_ip_address = false
  user_data = <<-EOF
<powershell>
# Download the Cato certificate
$certUrl = "https://myvpn.catonetworks.com/public/certificates/CatoNetworksTrustedRootCA.cer"
$certPath = "$env:TEMP\CatoNetworksTrustedRootCA.cer"
Invoke-WebRequest -Uri $certUrl -OutFile $certPath
Import-Certificate -FilePath $certPath -CertStoreLocation Cert:\LocalMachine\Root
Remove-Item $certPath

# Install Google Chrome
$installerUrl = "https://dl.google.com/chrome/install/latest/chrome_installer.exe"
$installerPath = "C:\chrome_installer.exe"
Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath
Start-Process -FilePath $installerPath -ArgumentList "/silent /install" -Wait
Remove-Item -Path $installerPath -Force
Write-Output "Google Chrome has been installed successfully."
</powershell>
EOF
  tags = {
    Name = "windows-vm-instance"
  }
}

# # Install Firefox
# $InstallerPath = "C:\\firefox_installer.exe"
# Invoke-WebRequest -Uri "https://download.mozilla.org/?product=firefox-latest&os=win&lang=en-US" -OutFile $InstallerPath
# Start-Process -FilePath $InstallerPath -ArgumentList "/S" -Wait
# Remove-Item -Path $InstallerPath

# # Install Microsoft Edge
# $installerUrl = "https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/37d103e5-6861-4a2b-8605-d24e8c07cba4/MicrosoftEdgeEnterpriseX64.msi"
# $installerPath = "C:\MicrosoftEdgeInstaller.msi"
# Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath
# Start-Process -FilePath "msiexec.exe" -ArgumentList "/i $installerPath /quiet /norestart" -Wait
# Remove-Item -Path $installerPath -Force
# Write-Output "Microsoft Edge has been installed successfully."

resource "aws_security_group" "windows_sg" {
  name        = "windows-vm-sg"
  description = "Allow RDP access"
  vpc_id      = var.vpc_id

  ingress {
    description = "RDP from VPC"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "windows-vm-security-group"
  }
}
