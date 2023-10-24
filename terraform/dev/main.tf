resource "aws_instance" "public_instance" {
 ami           = var.ami
 instance_type = var.instance_type

 tags = {
   Name = var.name_tag,
 }

 provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y docker.io",
      "sudo docker pull ${var.docker_image}",
      "sudo docker run -d -p 80:80 --name my-container ${var.docker_image}"
    ]

    connection {
      type       = "ssh"
      user       = "ubuntu"
      private_key = file("/var/lib/jenkins/.ssh/${var.ssh_key_name}")
      host       = self.public_ip
    }

}