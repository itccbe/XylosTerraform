config {
  format     = "compact"
  plugin_dir = "~/.tflint.d/plugins"

  module              = true
  force               = false
  disabled_by_default = false
}

plugin "terraform" {
  enabled = true
  preset  = "recommended"
}

plugin "azurerm" {
  enabled = true
  version = "0.18.0"
  source  = "github.com/terraform-linters/tflint-ruleset-azurerm"
}
