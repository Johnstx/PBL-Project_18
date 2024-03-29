
# launch template for bastion

resource "aws_launch_template" "bastion-launch-template" {
 image_id               = var.ami
 instance_type          = "t2.micro"
 vpc_security_group_ids = [aws_security_group.bastion_sg.id]

 iam_instance_profile {
   name = aws_iam_instance_profile.ip.id
 }

 key_name = var.keypair

 placement {
   availability_zone = "random_shuffle.az_list.result"
 }

 lifecycle {
   create_before_destroy = true
 }

 tag_specifications {
   resource_type = "instance"

  tags = merge(
   var.tags,
   {
     Name = "bastion-launch-template"
   },
 )
 }


  # create a file called bastion.sh and copy the bastion userdata from project 15 into it
 user_data = filebase64("${path.module}/bastion.sh")
}



# launch template for nginx

resource "aws_launch_template" "nginx-launch-template" {
 image_id               = var.ami
 instance_type          = "t2.micro"
 vpc_security_group_ids = [aws_security_group.nginx-sg.id]

 iam_instance_profile {
   name = aws_iam_instance_profile.ip.id
 }

 key_name =  var.keypair

 placement {
   availability_zone = "random_shuffle.az_list.result"
 }

 lifecycle {
   create_before_destroy = true
 }

 tag_specifications {
   resource_type = "instance"

   tags = merge(
   var.tags,
   {
     Name = "nginx-launch-template"
   },
 )
 }

  # create a file called nginx.sh and copy the nginx userdata from project 15 into it
 user_data = filebase64("${path.module}/nginx.sh")
}