### Individual budget ###
# Objective:
#    create 1 budget for a specific account
#    create 3 notifications: 50%, 80%, 100%
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/budgets_budget
# /!\ Getting account owner email has NOT been possible, hence the test@example.com value /!\
# -> couldn't get info from Organization (no read on accounts)

# AWS organization infos
data "aws_organizations_organization" "org" {}

resource "aws_budgets_budget" "individual_budget" {
  account_id        = data.aws_caller_identity.current.account_id
  name              = "individual-budget"
  budget_type       = "COST"
  limit_amount      = "10"
  limit_unit        = "USD"
  time_period_end   = "2087-06-15_00:00"
  time_period_start = formatdate("YYYY-MM-DD_hh:mm", "2018-01-02T23:12:01-08:00")
  time_unit         = "MONTHLY"

  notification { # 50% consumption notification
    comparison_operator        = "GREATER_THAN"
    threshold                  = 50
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = ["test@example.com"]
  }

  notification { # 80% consumption notification
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = ["test@example.com"]
  }

  notification { # 100% consumption notification
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = [data.aws_organizations_organization.org.master_account_email, "test@example.com"]
  }
}