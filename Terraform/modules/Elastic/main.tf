
resource "null_resource" "Elastic" {
  provisioner "local-exec" {
    command = "sleep 50  && PWD='../' ANSIBLE_ROLES_PATH='../Ansible/roles/' ansible-playbook -i ../Ansible/inventory ../Ansible/playbooks/Deploy.yaml --private-key sshkey/private_key.pem"
  }
}

