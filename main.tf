locals {
  instance_count = {
    stage = 1
    prod  = 2
  }
  instance_cores = {
    stage = 2
    prod  = 4
  }
  instance_mem = {
    stage = 2
    prod  = 4
  }
  instance_core_frac = {
    stage = 5
    prod  = 20
  }

}
data "yandex_compute_image" "ubuntu_2204" {
  family = "ubuntu-2204-lts" # ОС (Ubuntu, 22.04 LTS)
}
data "yandex_vpc_subnet" "default_b" {
  name = "subnet"
}
resource "yandex_compute_instance" "vm1" {
  #  name = "vm-ubuntu-${terraform.workspace}-${count.index}"
  count = local.instance_count[terraform.workspace]
  resources {
    core_fraction = local.instance_core_frac[terraform.workspace] # Гарантированная доля vCPU
    cores         = local.instance_cores[terraform.workspace]     # vCPU
    memory        = local.instance_mem[terraform.workspace]       # RAM
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_2204.id
    }
  }
  network_interface {
    subnet_id = data.yandex_vpc_subnet.default_b.subnet_id
    nat       = true # автоматически установить динамический ip
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/ubuntu.pub")}"
  }
}

