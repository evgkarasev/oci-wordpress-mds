variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}
variable "compartment_ocid" {}
variable "admin_password" {}
variable "wp_password" {}
variable "wp_site_admin_pass" {}

provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

module "oci-arch-wordpress-mds" {
  source             = "github.com/evgkarasev/oci-wordpress-mds"
  tenancy_ocid       = var.tenancy_ocid
  user_ocid          = var.user_ocid
  fingerprint        = var.fingerprint
  region             = var.region
  private_key_path   = var.private_key_path
  #use_existing_vcn   = false
  compartment_ocid   = var.compartment_ocid
  numberOfNodes      = 1
  admin_password     = var.admin_password
  wp_password        = var.wp_password
  wp_site_admin_pass = var.wp_site_admin_pass
  wp_version         = "6.7.1"
  wp_auto_update     = true
}

output "wordpress_public_ip" {
  value = module.oci-arch-wordpress-mds.wordpress_public_ip
}

output "wordpress_wp-admin_url" {
  value = module.oci-arch-wordpress-mds.wordpress_wp-admin_url
}

output "generated_ssh_private_key" {
  value     = module.oci-arch-wordpress-mds.generated_ssh_private_key
  sensitive = true
}
