resource "aws_subnet" "public_subnet-1" {
    vpc_id = "aws_vpc.vpc-dev.id"    
    availability_zone = "ap-southeast-2"
    cidr_block = "10.0.1.0/14"
    map_public_ip_on_launch = true
  
}
resource "aws_subent" "public_subnet-2" {
    vpc_id = "aws_vpc.vpc-dev.id"
    availabiltiy_zone = "ap-southeast-2"
    cdri_block = "10.0.2.0/24"
    map_public_ip_on_launch = true
  
}
// createing praivate subnets

resource "aws_subent" "praivate-subnet-1" {
    vpc_id = "aws_vpc.vpc-dev.id"
    availabiltiy_zone = "ap-southeast-2"
    cdri_block = "10.0.3.0/24"
    map_public_ip_on_launch = false

}   

resource "aws_subent" "praivate-subnet-2" {
    vpc_id = "aws_vpc.vpc-dev.id"
    availabiltiy_zone = "ap-southeast-2"
    cdri_block = "10.0.4.0/24"
    map_public_ip_on_launch = false

}    

// creating database subnets 
resource "aws_subent" "database-subnet-1" {
    vpc_id = "aws_vpc.vpc-dev.id"
    availabiltiy_zone = "ap-southeast-2"
    cdri_block = "10.0.5.0/24"
    map_public_ip_on_launch = false

}

resource "aws_subent" "database-subnet-2" {
    vpc_id = "aws_vpc.vpc-dev.id"
    availabiltiy_zone = "ap-southeast-2"
    cdri_block = "10.0.6.0/24"
    map_public_ip_on_launch = false

}    

