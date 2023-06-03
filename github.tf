terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

provider "github" {
  token = "token"
}

resource "github_repository" "example" {
  name        = "terraform_repo"
  description = "repository generated by terraform"

  visibility = "private"

}