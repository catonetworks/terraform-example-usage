output "private_ip" { value = aws_instance.windows_instance.private_ip }
output "hostname" { value = aws_instance.windows_instance.private_dns }