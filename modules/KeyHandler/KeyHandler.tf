resource "local_file" "key" {
  count                = length(var.service_account_private_keys)

  filename             = "credentials/${var.service_account_names[count.index]}-key.json"
  content              = "${base64decode(values(var.service_account_private_keys)[count.index])}"

}

resource "google_storage_bucket" "bucket" {
  name              = var.init_bucket_name
  location          = var.bucket_location
  storage_class     = var.bucket_class
}

resource "google_storage_bucket_iam_member" "member" {
  bucket = var.init_bucket_name
  role   = var.bucket_role
  member = var.bucket_member

  depends_on = [
    google_storage_bucket.bucket
  ]
}

resource "google_storage_bucket_object" "json_key_uploader" {
  count                = length(var.service_account_private_keys)
  name                 = "${var.service_account_names[count.index]}-key.json"
  source               = "credentials/${var.service_account_names[count.index]}-key.json"
  bucket               = var.init_bucket_name

  depends_on = [
    local_file.key,
    google_storage_bucket_iam_member.member
  ]
}