variable "DEVCONTAINER_OUTPUTS" {
  default = ""
}
variable "DEVCONTAINER_CACHE_FROMS" {
  default = ""
}
variable "DEVCONTAINER_CACHE_TOS" {
  default = ""
}

target "default" {
  dockerfile = ".devcontainer/Dockerfile"
  output = split(" ", "${DEVCONTAINER_OUTPUTS}")
  cache-from = split(" ", "${DEVCONTAINER_CACHE_FROMS}")
  cache-to = split(" ", "${DEVCONTAINER_CACHE_TOS}")
}
