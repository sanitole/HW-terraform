resource "aws_iam_user" "lb" {
  for_each = toset([
    "jenny",
    "rose",
    "lisa",
    "jisoo"
    ])
  name = each.key
}

resource "aws_iam_group" "group" {
  name = "blackpink"
}

resource "aws_iam_group_membership" "team" {
  name = "tf-testing-group-membership"

  users = [
    for i in aws_iam_user.lb : i.name
  ]

  group = aws_iam_group.group.name
}