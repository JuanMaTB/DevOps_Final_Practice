resource "google_storage_bucket" "default" {
  name          = "quizapp-bucket-sv"
  location      = "US"
  storage_class = "STANDARD"

}