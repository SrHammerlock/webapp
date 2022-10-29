variable "key_name" {
  default = "labsuser.pem"
}

resource "aws_ebs_volume" "ofekebs" {
  availability_zone = "${aws_subnet.ofeksub1.availability_zone}"
  size              = 1

  tags = {
    Name = "ofekebs"
  }
}

// Attaching above volume to the EC2 instance
resource "aws_volume_attachment" "ebsattach" {
  device_name = "/dev/xvdc"
  volume_id = "${aws_ebs_volume.ofekebs.id}"
  instance_id = "${aws_instance.ofekec2.id}"
  skip_destroy = true
}


resource "null_resource" "setupVol" {
depends_on = [
aws_volume_attachment.ebsattach,
]


//

provisioner "local-exec" {
command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ec2-user --private-key ~/Desktop/labsuser.pem -i '${aws_instance.ofekec2.public_ip},' master.yml"
}
}
