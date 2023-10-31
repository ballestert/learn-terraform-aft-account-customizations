resource "aws_ssm_parameter" "foo" {
    name  = "foo"
    type  = "String"
    value = "bar"
}

resource "aws_ssm_parameter" "acc_id" {
    name  = "/accID"
    type  = "String"
    value = "${data.aws_caller_identity.current.account_id}"
}

resource "aws_ssm_parameter" "caller_user" {
    name  = "/usrID"
    type  = "String"
    value = "${data.aws_caller_identity.current.user_id}"
}

resource "aws_ssm_parameter" "caller_arn" {
    name  = "/arn"
    type  = "String"
    value = "${data.aws_caller_identity.current.arn}"
}