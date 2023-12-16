terraform {
    required_providers {
        tencentcloud = {
            source = "tencentcloudstack/tencentcloud"
        }
    }
}

# Cretentials are stored as environment variables,
# provided by ./credentials/tencent-cloud.env
provider "tencentcloud" {
}