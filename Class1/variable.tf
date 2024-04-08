# variable "iamusers" {
#     type = list(string)
#     default = ["Jenny", "Rose", "Lisa", "Jisoo", "Jihyo", "Sana", "Momo", "Dahyun"]
# }

# variable "iamgroups" {
#     type = list(string)
#     default = ["Blackpink", "Twice"]
# }

# resource "asw_iam_user" "user" {
#     count = length(var.iamusers)
#     name = var.iamusers[count.index]
# }

# resource "aws_iam_group" "group" {
#   count = length(var.iamgroups)
#   name = var.iamgroups[count.index]
# # }
# resource "aws_iam_group_membership" "team" {
#   name = "tf-testing-group-membership"

#   users = [
#     for i in aws_iam_user.lb : i.name
#   ]

#   group = aws_iam_group.group.name
# }