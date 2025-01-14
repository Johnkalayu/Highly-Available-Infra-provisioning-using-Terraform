data "aws_ami" "amazon-linux-2" {
    most_recent = true
    owners = ["626635400498"]


    filter {
        name = "name"
        values = ["AMI-version-2.0.20241217.0"]

    }

    filter {
        name = "image-id"
        values =  ["ami-0ca9fb66e076a6e32"]
    }

    filter {
        name = "architecture"
        values = ["x86_64"]
    }
    filter {
        name = "virtualization_type"
        values = ["hvm"]
    }

}

// crating iam roles 

resource "aws_iam_role" "dev-region1-role" {
    name = "dev-region1-role"

    assume_role_policy = jsonencode({
        version = "2012-10-17"
        Statment = [
            { 
                Action = "sts:AssumeRole"
                Effect = Allow
                sid = ""
                principal = {
                    service = ec2.amazon.com
                }  

            }
        ]

    })

}

resource "aws_iam_role_policy_attachment" "dev-ec2_full-access" {
    role = aws_iam_role.dev-region1-role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_role_policy_attachment" "dev-s3-access" {
    role = aws_iam_role.dev-region1-role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess" 
}

resource "aws_iam_instance_profile" "dev-ec2-profile" {
    name = "dev-ec2-profile"
    role = aws_iam_role.dev-region1-role.name
}







resource "aws_launch_template" "dev-template" {
    name = "dev-template"
    image_id = data.aws_iam.amazon-linux-2.id
    instance_type = "t2.medium"
    instance_profile = {
        name = aws_iam_instance_profile.dev-ec2-profile.name
    }
    user_data = base64encode(template("dev.sh", {postgres_url = aws_db_instances.aws_db_instances.endpoint}))
    vpc_security_groups_ids = [aws_securirty_group.alb-sg.id]

    lifecycle {
      create_before_destroy = true
    }

}
resource "aws_autoscaling_group" "dev_asg" {
    name = "dev-asg-template"
    desired_capacity = "1"
    max_size = "3"
    min_size = "1"
    force_delete = true
    depends_on = [ aws_lb.app-load-balancer ]
    health_check_type = "EC2"
    target_group_arns = [aws_lb_target.dev-alb-target.arn]
    vpc_zone_identifier = [aws-subnet.pravet-subnet-1.id, aws_subnet.pravet-subnet-2.id]
   
    launch_template {
        id = aws_launch_template.dev-template.id
        version = "$Latest"
   }  
   tag {
    key                = "asg_key" 
    propagat_at_launch = true  
   }
}
