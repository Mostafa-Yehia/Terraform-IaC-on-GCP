resource "google_storage_bucket" "bucket" {
  count             = var.bucket_number
  
  name              = "${var.bucket_name}-${count.index + 1}"
  location          = var.bucket_location
  storage_class     = var.bucket_class
}

resource "google_storage_bucket_iam_member" "member" {
  count             = var.bucket_number

  bucket = "${var.bucket_name}-${count.index + 1}"
  role   = var.bucket_role
  member = var.bucket_member

  depends_on = [
    google_storage_bucket.bucket
  ]
}