variable "ami_id" {}

variable "instance_count" {}

variable "key_name_global" {}

variable "instance_type_mgp" {}

variable "subnet_id_mgp" {}

variable "security_groups" {
    type = set(string)
}

variable "project" {}

variable "Environment" {} 

# variable "security_groups_ids" {}