# resource "aws_s3_bucket" "navadeep" {
#   bucket = "my-tf-test-bucket"

#   tags = {
#     Name        = "My bucket"
#     Environment = "Dev"
#   }
# }

# resource "aws_s3_bucket_acl" "pavan" {
#   bucket = aws_s3_bucket.navadeep.id
#   acl    = "private"
# }

# terraform{
#     backend "s3"{
#         bucket ="manchinti123"
#         key = "myapp/dev/terraform.tfstate"
#         region ="eu-west-3"

#     }
# }