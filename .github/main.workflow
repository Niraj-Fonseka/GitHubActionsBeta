workflow "New workflow" {
  on = "push"
  resolves = [
    "GitHub Action for Docker",
    "Set the new image in GKE",
  ]
}

action "GitHub Action for Docker" {
  uses = "actions/docker/cli@aea64bb1b97c42fa69b90523667fef56b90d7cff"
  args = ["build", "-t", "githubactions", "."]
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
  args = ["githubactions", "gcr.io/$PROJECT/$APP"]
}



action "Setup Google Cloud" {
  uses = "actions/gcloud/auth@master"
  needs = ["Docker Tag", "Get Auth for Google Cloud"]
  secrets = ["GCLOUD_AUTH"]
}

action "Get Gcloud Auth" {
  uses = "actions/gcloud/cli@df59b3263b6597df4053a74e4e4376c045d9087e"
  needs = ["Docker Tag"]
  secrets = ["GCLOUD_AUTH"]
  args = ["auth", "configure-docker", "--quiet"]
}

action "Push Image to Registery" {
  uses = "actions/gcloud/cli@df59b3263b6597df4053a74e4e4376c045d9087e"
  args = ["docker", "-- push", "gcr.io/$PROJECT/$APP:latest"]
  env = {
    PROJECT = "nirajfonseka-prod"
    APP = "githubactions"
  }
  needs = ["Get Gcloud Auth"]
}

action "Get Kubernates Auth" {
  uses = "actions/gcloud/cli@df59b3263b6597df4053a74e4e4376c045d9087e"
  needs = ["Push Image to Registery"]
  secrets = ["GCLOUD_AUTH"]
  env = {
    PROJECT = "nirajfonseka-prod"
    CLUSTER_NAME = "gke-test-cluster"
  }
  args = "container clusters get-credentials $CLUSTER_NAME --zone us-central1-a --project $PROJECT"
}

action "Set the new image in GKE" {
  uses = "docker://gcr.io/cloud-builders/kubectl"
  needs = ["Get Kubernates Auth"]
  env = {
    PROJECT_ID = "nirajfonseka-prod"
    APPLICATION_NAME = "githubactions"
    NAMESPACE= "deployment"
  }
  runs = "sh -l -c"
  args = ["SHORT_REF=$(echo ${GITHUB_SHA} | head -c7) && cat $GITHUB_WORKSPACE/deploy.yml | sed 's/PROJECT_ID/'\"$PROJECT_ID\"'/' | sed 's/APPLICATION_NAME/'\"$APPLICATION_NAME\"'/' | sed 's/TAG/'\"$SHORT_REF\"'/' | kubectl apply -n $NAMESPACE -f -"]
}
  
