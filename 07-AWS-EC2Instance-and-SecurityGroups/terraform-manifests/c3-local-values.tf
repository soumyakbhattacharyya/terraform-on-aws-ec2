# local variables are used to implement complex expression, and being used in multiple location upstream
# local variables should not be used in many spaces, to avoid strong coupling
locals {
  owners = var.business_division
  environment = var.environment
  name = "${var.business_division}-${var.environment}"
  #name = "${local.owners}-${local.environment}"
  common_tags = {
    owners = local.owners
    environment = local.environment
  }
} 