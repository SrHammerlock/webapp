resource "aws_instance" "ofekec2" {
    ami = "ami-0d593311db5abb72b"
    instance_type = "t2.micro"
    key_name = "vockey"
    vpc_security_group_ids = ["${aws_security_group.ofeksg.id}"]
    subnet_id = "${aws_subnet.ofeksub1.id}"
    tags = {
        Name = "Ofek-Terra"
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