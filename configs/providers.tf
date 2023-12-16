terraform {
    required_providers {
        tencentcloud = {
            source = "tencentcloudstack/tencentcloud"
            version = "1.81.59"
        }
    }
}

# Cretentials are stored as environment variables,
# provided by ./credentials/tencent-cloud.env
provider "tencentcloud" {
    region = var.region
}