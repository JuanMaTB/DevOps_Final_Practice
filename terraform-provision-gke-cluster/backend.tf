  terraform {
      backend "gcs"{
    bucket = "quizapp-bucket-sv"
    prefix = "terraform/quizapp-state"
  }
   
  }
