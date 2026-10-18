resource "aws_iam_user" "sally" {
  name = "sally"
  path = "/"
}

resource "aws_iam_user_login_profile" "sally" {
  user                    = aws_iam_user.sally.name
  password_reset_required = true
  password                = var.sally_password
}

resource "aws_iam_user_policy_attachment" "sally_change_password" {
  user       = aws_iam_user.sally.name
  policy_arn = "arn:aws:iam::aws:policy/IAMUserChangePassword"
}

# generate JSON policy via HCL
data "aws_iam_policy_document" "sally_s3" {
  statement {
    effect    = "Allow"
    actions   = ["s3:*"]
    resources = ["*"]
  }

  statement {
    effect  = "Deny"
    actions = ["s3:*"]
    resources = [
      aws_s3_bucket.catpics.arn,
      "${aws_s3_bucket.catpics.arn}/*"
    ]
  }
}

resource "aws_iam_policy" "policy" {
  name        = "AllowAllS3ExceptCats"
  description = "Allow access to all S3 buckets, except catpics"
  policy      = data.aws_iam_policy_document.sally_s3.json
}

# attaching the custom policy to user
resource "aws_iam_user_policy_attachment" "sally_custom_policy" {
  user       = aws_iam_user.sally.name
  policy_arn = aws_iam_policy.policy.arn
}

data "aws_iam_policy_document" "sally_lambda_inline" {
  statement {
    effect    = "Allow"
    actions   = ["lambda:InvokeFunction"]
    resources = ["arn:aws:lambda:us-east-1:123456789012:function:test-lambda"]
  }
}

resource "aws_iam_user_policy" "sally_inline" {
  name   = "InvokeTestLambdaInline"
  user   = aws_iam_user.sally.name
  policy = data.aws_iam_policy_document.sally_lambda_inline.json
}