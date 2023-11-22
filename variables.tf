# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "sg_name" {
  type        = string
  description = "sucurity group"

  default     = "allowports"
}

variable "ttl" {
  type        = string
  description = "Value for TTL tag."

  default     = "1"
}

variable "ports" {
 description = "A list of 5 tcp ports allow"
 type       = list(number)
 default    = [22, 8083, 443, 8080, 8081]
}
