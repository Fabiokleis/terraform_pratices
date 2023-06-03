# Example of slat expression
provider "aws" {
    region = "sa-east-1"
}

resource "aws_iam_user" "lb" {
  name = "iamuser.${count.index}"
  count = 3
  path = "/system/"
}

# example of expand expression to list index
# so we can iterate over all items in single output block
output "arns" {
  value = aws_iam_user.lb[*].arn
}

output "name" {
  value = aws_iam_user.lb[*].name
}

# zipmap example
# we can combine two lists
output "combined" {
  value = zipmap(aws_iam_user.lb[*].name, aws_iam_user.lb[*].arn)
}