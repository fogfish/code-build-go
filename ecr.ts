import * as cdk from '@aws-cdk/core'
import * as ecr from '@aws-cdk/aws-ecr'
import * as iam from '@aws-cdk/aws-iam'

const app = new cdk.App()
const stack = new cdk.Stack(app, 'code-build-go', {})

const repo = new ecr.Repository(stack, 'Repo', {
  repositoryName: app.node.tryGetContext('repo')
})

const policy = new iam.PolicyStatement()
policy.addPrincipals(new iam.ServicePrincipal('codebuild.amazonaws.com'))
policy.addActions(
  "ecr:GetDownloadUrlForLayer",
  "ecr:BatchGetImage",
  "ecr:BatchCheckLayerAvailability"
)

repo.addToResourcePolicy(policy)

app.synth()