workflow "New workflow" {
  on = "push"
  resolves = [
    "GitHub Action for Docker",
    "Get Auth for Google Cloud",
  ]
}

action "GitHub Action for Docker" {
  uses = "actions/docker/cli@aea64bb1b97c42fa69b90523667fef56b90d7cff"
  runs = "docker"
  args = "build ."
}

action "Get Auth for Google Cloud" {
  uses = "actions/gcloud/auth@df59b3263b6597df4053a74e4e4376c045d9087e"
  secrets = ["GCLOUD_AUTH"]
}
