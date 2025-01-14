resource "aws_vpc" "vpc-dev" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true

          
}

resource "aws_internet_gateway" "inter_gateway" {
    vpc_id = aws_vpc.vpc-dev.id
}

#resource "aws_internet_gateway_attachment" "inter-gateway-attachment" {
   # internet_gateway_id = aws_internet_gateway.inter_gateway.id
   # vpc_id = aws_vpc.vpc-dev.id
#}

resource "aws_eip" "nat-eip-az1" {
    domain = "vpc"
}
resource "aws_eip" "nat-eip-az2" {
    domain = "vpc"
}
resource "aws_nat_gateway" "ng-az-1" {
    allocation_id = aws_eip.nat-eip-az1.id
    subnet_id = aws_subnet.public_subnet-1.id 
    depends_on = [aws_eip.nat-eip-az1]
}
resource "aws_nat_gateway" "ng-az-2" {
    allocation_id = aws_eip.nat-eip-az2.id
    subnet_id =  aws_subnet.public_subnet-2.id
    depends_on = [ aws_eip.nat-eip-az2 ]
}
resource "aws_route_table" "public-rt-1" {
    vpc_id = aws_vpc.vpc-dev.id

    route = {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.inter_gateway.id
    }
  
}

resource "aws_route_table_association" "public-rt-1-association" {
    subnet_id = aws_subnet.public_subnet-1.id
    route_table_id = aws_route_table.public-rt-1.id
  
}

resource "aws_route_table_association" "public-rt-2-association" {
    subnet_id = aws_subnet.public_subnet-2.id
    route_table_id = aws_route_table.public-rt-1.id

}

// creating pravet route table for app subnet 

resource "aws_route_table" "private-rt-1" {
    vpc_id = aws_vpc.vpc-dev.id

    route = {
        cdri_block = "0.0.0.0/0"
       nat_gateway_id = aws_nat_gateway.ng-az-1.id
    }  
}
resource "aws_route_table_association" "private-rt-1-association" {
    subnet_id = aws_subnet.private-subnet-1.id
    route_table_id = aws_route_table.private-rt-1.id
}

resource "aws_route_table" "private-rt-2" {
    vpc_id = aws_vpc.vpc-dev.id

    route = {
        cdri_block = "0.0.0.0/0"
       nat_gateway_id = aws_nat_gateway.ng-az-2.id
    }  
}
resource "aws_route_table_association" "private-rt-2-association" {
    subnet_id = aws_subnet.private-subnet-2.id
    route_table_id = aws_route_table.private-rt-1.id

}
            