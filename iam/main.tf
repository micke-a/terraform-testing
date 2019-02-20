provider "aws" {
  region     = "eu-west-1"
}

resource "aws_iam_group" "ml-group" {
  name = "ml-group"
}

data "aws_iam_policy" "AmazonSageMakerFullAccess" {
  arn = "arn:aws:iam::aws:policy/AmazonSageMakerFullAccess"
}

data "aws_iam_policy" "AmazonAthenaFullAccess" {
  arn = "arn:aws:iam::aws:policy/AmazonAthenaFullAccess"
}

data "aws_iam_policy" "IAMUserChangePassword" {
  arn = "arn:aws:iam::aws:policy/IAMUserChangePassword"
}

resource "aws_iam_group_policy_attachment" "ml-group-policy-athena" {
  group      = "${aws_iam_group.ml-group.name}"
  policy_arn = "${data.aws_iam_policy.AmazonAthenaFullAccess.arn}"
}

resource "aws_iam_group_policy_attachment" "ml-group-policy-sagemaker" {
  group      = "${aws_iam_group.ml-group.name}"
  policy_arn = "${data.aws_iam_policy.AmazonSageMakerFullAccess.arn}"
}

resource "aws_iam_group_policy_attachment" "ml-iam-user-change-password" {
  group      = "${aws_iam_group.ml-group.name}"
  policy_arn = "${data.aws_iam_policy.IAMUserChangePassword.arn}"
}

resource "aws_iam_user_login_profile" "login_profiles" {
  count           = "${length(var.usernames)}"
  user            = "${element(var.usernames, count.index)}"
  password_length = 10
  pgp_key         = "keybase:micke_a"
}

resource "aws_iam_user" "ml-users" {
  count = "${length(var.usernames)}"
  name  = "${element(var.usernames, count.index)}"

  force_destroy = true
}

resource "aws_iam_user_group_membership" "ml-user-groups" {
  count  = "${length(var.usernames)}"
  user   = "${element(var.usernames, count.index)}"
  groups = ["${aws_iam_group.ml-group.name}"]
}
