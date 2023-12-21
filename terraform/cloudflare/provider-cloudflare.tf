terraform {
  required_version = "> 0.13.0"
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.api_token
}

data "cloudflare_zone" "main" {
  name = var.domain
}

resource "cloudflare_record" "main" {
  for_each = toset(var.sub_names)

  zone_id         = data.cloudflare_zone.main.id
  name            = "${each.value}.${var.prefix}.${var.domain}"
  value           = var.ip
  type            = "A"
  ttl             = 60
  allow_overwrite = true
}