variable "users" {
  type = map(object(
    {
      dept     = string
      is_admin = bool
    }
  ))
  default = {
    rafa = {
      dept        = "IT"
      is_admin    = true
      employee_id = "22222"
    },
    paco = {
      dept     = "Planning"
      is_admin = false
    },
    "jose andres" = {
      dept     = "Accounting"
      is_admin = false
    }
  }
}

variable "more_users" {
  # Note no type
  default = {
    luise = {
      dept         = "IT"
      is_admin     = true
      favorite_pet = "Max"
      employee_id  = "22222"
    },
    martin = {
      "favorite food" = "salmorejo cordobés"
      age = 33
    }
  }
}


locals {
  admin_users = {
    for name, user in var.users : name => user
    if user.is_admin
  }
  regular_users = {
    for name, user in var.users : name => user
    if !user.is_admin
  }
}

/*

$ terraform console
> local.admin_users
{
  "rafa" = {
    "dept" = "IT"
    "is_admin" = true
  }
}
> local.regular_users
{
  "jose andres" = {
    "dept" = "Accounting"
    "is_admin" = false
  }
  "paco" = {
    "dept" = "Planning"
    "is_admin" = false
  }
}
*/