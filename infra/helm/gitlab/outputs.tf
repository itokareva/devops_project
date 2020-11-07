output "name" {
  description = "The name of the cluster master. This output is used for interpolation with node pools, other modules."

  value = helm_release.gitlab.metadata
}
