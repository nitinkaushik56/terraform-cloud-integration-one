locals {

  name_prefix = "${var.project_name}-${var.environment}"
  #if i call name-prefix it will give me sap-dev
  project_tags = { #project tag is the name

        project     = var.project_name #sap

        environment = var.environment #dev

        Owner       = "kyn"

    }
}