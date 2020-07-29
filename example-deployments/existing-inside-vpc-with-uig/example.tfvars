pan_authcode    = "123456"
vm_auth_key     = "1234567890"
panorama1_ip    = "192.168.100.2"
bootstrap_phash = "$1$swuuvbfr$TeXPJ5vj8FQP5E9NiByN40"

fw_ssh_key = "ssh-rsa AAAA...."


bootstrap_environments = {
  my-deployment-egress-us-west3 = { pan_template_name = "test-egress-west3-stk", pan_device_group_name = "test-egress-dg" },
}