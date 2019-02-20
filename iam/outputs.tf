output "user_arn" {
  value = "${aws_iam_user.ml-users.*.arn}"
}

output "passwords" {
  value = "${aws_iam_user_login_profile.login_profiles.*.encrypted_password}"
}
