workflow "New workflow" {
  on = "push"
  resolves = [
    "GitHub Action for Docker",
    "Docker Tag",
  ]
}

action "GitHub Action for Docker" {
  uses = "actions/docker/cli@aea64bb1b97c42fa69b90523667fef56b90d7cff"
  args = ["build", "-t" , "githubactions", "."]
}

action "Get Auth for Google Cloud" {
  uses = "actions/gcloud/auth@df59b3263b6597df4053a74e4e4376c045d9087e"
  secrets = ["GCLOUD_AUTH"]
}

action "Docker Tag" {
  uses = "actions/docker/tag@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  needs = ["Get Auth for Google Cloud", "GitHub Action for Docker"]
  env = {
    PROJECT = "nirajfonseka-prod"
    APP = "githubactions"
  }
  args = ["githubactions", "gcr.io/$PROJECT_ID/$APPLICATION_NAME"]
}
