output "default_instance_public_ip" {
  value = yandex_compute_instance.vm1[*].network_interface[0].nat_ip_address
}

