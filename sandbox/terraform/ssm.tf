resource "aws_ssm_parameter" "foo" {
    name  = "foo"
    type  = "String"
    value = "bar"
}

resource "aws_ssm_parameter" "acc_custom" {
    name  = "/accID"
    type  = "String"
    value = "${data.aws_caller_identity.current.account_id}"
}