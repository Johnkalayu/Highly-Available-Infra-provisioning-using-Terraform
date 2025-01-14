locals {
  endpoint = {
    "endpoint-ssm" = {
        name = "ssm"
    },
    "endpoint-ssmmessags" = {
        name = "ssmmessages"
    },
    "endpoint-ec2messages" = {
        name = "ec2messages"
    }
  }
}



resource "aws_vpc_endpoint" "dev-vpc-endpoint" {
    for_each =  local.endpoint
    vpc_id = aws_vpc.dev-vpc.vpc.id
    vpc_endpoint_type ="Interface"
    service_name = "come.amazoneaws.ap-souther-1.$(each.value.name)"

    security_group_id = [
      aws_security_group.dev-vpc-endpoint-sg.id
    ]
    
}

resource "aws_iam_role" "ec2-endpoint-role" {
    name = "ec2-endpoint-role"

    assume_role_policy = jsonecode ({
        version = "2012-10-17"
        Statment = [
            {
                Action = "sts:AssumeRole"
                Effect = Allow
                sid = ""
                Principal = {
                    Service = "ec2.amazonaws.com"
                }
            }
        ]
    })
 
}

resource "aws_iam_role_policy_attachment" "ec2-endpoint-role-attachment" {
    role = aws_iam_role.ec2-endpoint-role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ec2-SSM-profile" {
    name = "ec2-SSM-profile"
    role = aws_iam_role.ec2-endpoint-role.name
  
}