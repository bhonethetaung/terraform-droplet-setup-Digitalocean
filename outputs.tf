# output "server_info" {
#   description = "List of servers with public IP and root password"
#   value = [
#     for i in range(var.server_count) : {
#       name      = digitalocean_droplet.servers[i].name
#       public_ip = digitalocean_droplet.servers[i].ipv4_address
#       password  = random_password.root_pass[i].result
#     }
#   ]
#   sensitive = true
# }

output "server_info" {
  description = "List of servers with public IP and root password"
  value       = local.server_list
  sensitive   = true
}