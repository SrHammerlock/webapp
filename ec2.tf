resource "aws_instance" "ofekec2" {
    ami = "ami-0d593311db5abb72b"
    instance_type = "t2.micro"
    key_name = aws_key_pair.infr_exr_key.key_name
    vpc_security_group_ids = ["${aws_security_group.ofeksg.id}"]
    subnet_id = "${aws_subnet.ofeksub1.id}"
    tags = {
        Name = "Ofek-Terra"
    }
}
//Creating private key
resource "tls_private_key" "tlskey" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "infr_exr_key" {
  
  key_name = "mykey"
  public_key = tls_private_key.tlskey.public_key_openssh
  
  provisioner "local-exec" {
    command = "echo '${tls_private_key.tlskey.private_key_pem}' > ~/.ssh/${aws_key_pair.infr_exr_key.key_name}.pem"
  }
}




/*
resource "null_resource" "connect" {
  provisioner "remote-exec" {
    connection {
      host = aws_instance.ofekec2.public_ip
      user = "ec2-user"
      private_key = file(pathexpand("~/.ssh/${aws_key_pair.kp.key_name}.pem"))
    }

    inline = ["echo 'connected!'"]
}
}

*/