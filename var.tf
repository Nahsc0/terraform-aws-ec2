variable "server_port" {
description = "This server as the port number of the HTTP" 
type = number

}
output "public_ip" {
    value = aws_instance.example.public_ip
    description = "The public IP address of the web server"
}
