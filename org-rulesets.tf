data "github_repository" "required_workflows" {
  full_name  = "${var.github_organization}/required-workflows"
  depends_on = [github_repository.required_workflows]
}

# Check dependencies every time a dev wants to merge his/her changes
resource "github_organization_ruleset" "dependecy_check_in_every_pr" {
  name        = "Dependency review in every PR"
  target      = "branch"
  enforcement = "active"

  conditions {

    repository_name {
      include = ["~ALL"]
      exclude = []
    }

    ref_name {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
  }

  bypass_actors {
    actor_id    = var.github_app_id
    actor_type  = "Integration"
    bypass_mode = "always"
  }

  rules {
    deletion                = true
    required_linear_history = true

    required_workflows {

      required_workflow {

        repository_id = github_repository.required_workflows.repo_id

        path = ".github/workflows/dependency_review.yml"

        ref = "refs/heads/main"

      }
    }
  }
}


# Every time you have a dotnet repo and a PR is created please execute this CI workflow
resource "github_organization_ruleset" "dotnet_ci_workflow" {
  name        = "Execute CI workflow for .NET projects"
  target      = "branch"
  enforcement = "active"

  conditions {

    repository_name {
      exclude = []
      include = [
        jsonencode(
          {
            name = "language"
            property_values = [
              "C#",
            ]
            source = "system"
          }
        ),
      ]
    }

    ref_name {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
  }

  bypass_actors {
    actor_id    = var.github_app_id
    actor_type  = "Integration"
    bypass_mode = "always"
  }

  rules {
    deletion                = true
    required_linear_history = true

    required_workflows {

      required_workflow {

        repository_id = github_repository.required_workflows.repo_id

        path = ".github/workflows/ci_dotnet.yml"

        ref = "refs/heads/main"

      }
    }
  }
}
