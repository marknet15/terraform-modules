terraform {
  required_providers {
    pihole = {
      source = "ryanwholey/pihole"
    }
  }
}

resource "pihole_dns_record" "record" {
  for_each = var.nodes
  domain   = "${each.key}.${var.domain}"
  ip       = each.value
}

resource "null_resource" "raspberry_pi_public_key" {
  for_each = var.nodes

  connection {
    type     = "ssh"
    user     = var.username
    password = var.password
    host     = each.value
  }

  provisioner "file" {
    source      = var.public_key_path
    destination = "/tmp/id_rsa.pub"
  }
}

resource "null_resource" "raspberry_pi_setup" {
  for_each = var.nodes

  connection {
    type     = "ssh"
    user     = var.username
    password = var.password
    host     = each.value
  }

  provisioner "remote-exec" {
    inline = [
      # Configure timezone and NTP
      "sudo timedatectl set-timezone ${var.timezone}",
      "sudo timedatectl set-ntp true",

      # Configure new hostname
      "sudo hostnamectl set-hostname ${each.key}.${var.domain}",
      "echo '127.0.0.1 ${each.key}.${var.domain}' | sudo tee -a /etc/hosts",

      # Update password
      "echo 'pi:${var.new_password}' | sudo chpasswd",

      # Trust added ssh key
      "mkdir -p ~/.ssh",
      "cat /tmp/id_rsa.pub >> ~/.ssh/authorized_keys",

      # Update all system packages
      "sudo apt-get update -y",
      "sudo apt-get upgrade -y",
      "sudo apt-get dist-upgrade -y",
      "sudo apt-get --fix-broken install -y",
      "sudo apt-get install dnsutils git vim htop ncdu build-essential libssl-dev libffi-dev -y",

      # Install Python
      "sudo apt-get purge python-minimal -y",
      "sudo apt-get install python3 python3-pip python3-venv python3-dev -y",
      "sudo apt-get autoremove -y",
      "sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1",
      "sudo update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1",
      "sudo pip install pip --upgrade",
      "sudo pip install urllib3 requests poetry --upgrade",

      # Configure networking interface
      "echo 'interface eth0\nstatic ip_address=${each.value}${var.subnet_mask}\nstatic routers=${var.gateway}\nstatic domain_name_servers=${var.nameserver}' | cat >> /etc/dhcpcd.conf",

      # Configure GPU memory
      "echo 'gpu_mem=8' | sudo tee -a /boot/config.txt",

      # Needed for k3s to start up on rpi4 x64
      "sudo sed 's/$/ cgroup_enable=cpuset cgroup_enable=memory cgroup_memory=1/' /boot/cmdline.txt > cmdline-new.txt",
      "sudo mv cmdline-new.txt /boot/cmdline.txt",

      # Reboot pi
      "sudo shutdown -r +0"
    ]
  }
}
