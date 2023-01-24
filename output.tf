output "vm1_instance_public_ip" {
  value = yandex_compute_instance.vm1[*].network_interface[0].nat_ip_address
}

output "vm2_instance_public_ip" {
  value = toset([
    for instance in  yandex_compute_instance.vm2: instance.network_interface[0].nat_ip_address
  ])
}
