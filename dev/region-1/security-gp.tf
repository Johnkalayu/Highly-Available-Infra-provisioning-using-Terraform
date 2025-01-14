resource "aws_securirty_group" "dev-ec2-web-sg" {
    name = "dev-ec2-web-sg"
    description = " allowing HTTPS for private ec2"
    vpc_id = "aws_vpc.vpc-dve.id"


    ingress {
        cdri_ipv4 = aws_vpc.vpc-dev.id
        from_prot = 443
        to_port = 443
        protoclo = "tcp"
          
    }  
      ingress {
        cdri_ipv4 = aws_vpc.vpc-dev.id
        from_port = 80
        to_port = 80
        protoclo = "tcp"
    }
    ingress {
        cdri_ipv4 = aws_vpc.vpc-dev.id
        from_port = 22
        to_port = 22
        protoclo = "tcp"
    }
    ingress {
        cdri_ipv4 = aws_vpc.vpc-dev.id
        from_port = 8080
        to_port = 8080
        protoclo = "tcp"
    }
    ingress {
        cdri_ipv4 = aws_vpc.vpc-dev.id
        from_port = 5432
        to_port = 5432
        protoclo = "tcp"
    }
    egress {
        cdri_ipv4 = "0.0.0.0/0"
        protoclo = "-1"

    }

}

resource "aws_securirty_group" "alb-sg-region1" {
    name = "alb-sg-region1"
    description  = "allowing port 443,80,8080 for alb ec2 "
    vpc_id = aws_vpc.dev-vpc.id

    ingerss {
        cdri_ipv4 = aws_vpc.dev-vpc.id
        from_prot = 443 
        to_port = 443
        protoclo = "tcp"
    
    }
    ingerss{
        cdri_ipv4 = aws_vpc.dev-vpc.id
        from_prot = 80
        to_port = 80
        protoclo = "tcp"

    }
    ingress {
        cdri_ipv4 = aws_vpc.dev-vpc.id
        from_prot = 8080
        to_port = 8080
        protoclo = "tcp"

    }
    engress {
        cdri_ipv4 = "0.0.0.0/0"
        protoclo = "-1"
    }
  
}


resource "aws_securirty_group" "dev-vpc-endpoint-sg" {
    name = "dev-vpc-endpoint-sg"
    description  = "allowing port 443,80,8080,5432 "
    vpc_id = aws_vpc.dev-vpc.id

    ingerss {
        cdri_ipv4 = aws_vpc.dev-vpc.id
        from_prot = 443 
        to_port = 443
        protoclo = "tcp"
    
    }
    ingerss{
        cdri_ipv4 = aws_vpc.dev-vpc.id
        from_prot = 80
        to_port = 80
        protoclo = "tcp"

    }
    ingress {
        cdri_ipv4 = aws_vpc.dev-vpc.id
        from_prot = 8080
        to_port = 8080
        protoclo = "tcp"
    }
    ingress {
        cdri_ipv4 = aws_vpc.dev-vpc.id
        from_port = 5432
        to_port = 5432
        protoclo = "tcp"
    }

    engress {
        cdri_ipv4 = "0.0.0.0/0"
        protoclo = "-1"
    }
  
}
