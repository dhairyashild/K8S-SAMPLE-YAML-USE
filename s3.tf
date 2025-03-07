REMEMBER CODE START WITH  ====     aws_s3_
THEN REMEMBR WORD         ====            bucket              object                 bucket_versioning  


#RANDOM WORD FOR S3 NEW NAME
resource "random_id" "server" {
  byte_length = 8
}





#### CREATE BUCKET
resource "aws_s3_bucket" "example" {
  bucket = "bucket-${random_id.server.hex}"     ####WRONG CODE == ( NO HEX)            --  CORRCT CODE== { .hex }

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}



#### ADD OBJECT FROM LOCAL PC TO S3
resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.example.id
  key    = "ganja"                              #### NAME / FOLDER PATH SHOWN ON S3 LIKE /data/file.txt
  source = "C:/Users/dhair/OneDrive/Desktop/TERRAFORM/S3/backend.tf"        #### LOCAL PATH from my root so backend.tf now gt name given in key so on s3 w see ganja folder

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("path/to/file")                #### check
}




# VERSIONING
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.example.id
  versioning_configuration {
    status = "Enabled"
  }
}













