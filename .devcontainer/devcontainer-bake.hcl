variable "DEVCONTAINER_OUTPUTS" {
  default = ""
}

group "default" {
  targets = [
    "pre-commit",
    "useradd"
  ]
}

target "pre-commit" {
  contexts = {
    base_context = "python:3.12.4"
  }
}

target "useradd" {
  contexts = {
    base_context = "target:pre-commit"
  }
  output = split(" ", trimspace("${DEVCONTAINER_OUTPUTS}"))
}
