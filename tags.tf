resource "random_id" "tag" {
  byte_length = 2
}

resource "oci_identity_tag_namespace" "ArchitectureCenterTagNamespace" {
  provider       = oci.homeregion
  compartment_id = var.compartment_ocid
  description    = "ArchitectureCenterTagNamespace"
  name           = "ArchitectureCenter\\deploy-wordpress-cms-with-mysql-dbs-${random_id.tag.hex}"

  provisioner "local-exec" {
    command = "sleep 10"
  }
}

resource "oci_identity_tag" "ArchitectureCenterTag" {
  provider         = oci.homeregion
  description      = "ArchitectureCenterTag"
  name             = "release"
  tag_namespace_id = oci_identity_tag_namespace.ArchitectureCenterTagNamespace.id

  validator {
    validator_type = "ENUM"
    values         = ["release", "1.5"]
  }

  provisioner "local-exec" {
    command = "sleep 120"
  }

}
