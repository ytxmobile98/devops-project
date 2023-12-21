output "k3s" {
  value = {
    server_names = [
      # must start with "k3s-"
      "k3s-hongkong-1",
    ]
  }
}