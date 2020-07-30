/*

resource "aws_globalaccelerator_accelerator" "cjitsiYse_global_accelerator" {
  name            = var.global_accelerator_name
  ip_address_type = "IPV4"
  enabled         = true
}



resource "aws_globalaccelerator_listener" "cjitsiYse_GA_listener" {
  accelerator_arn = aws_globalaccelerator_accelerator.cjitsiYse_global_accelerator.id
  client_affinity = "SOURCE_IP"
  protocol        = "TCP"

  port_range {
    from_port = 80
    to_port   = 5000
  }
}

resource "aws_globalaccelerator_endpoint_group" "cjitsiYse_GA_endpoint_group" {
  listener_arn = aws_globalaccelerator_listener.cjitsiYse_GA_listener.id
  endpoint_group_region = var.region

  endpoint_configuration {
    endpoint_id = aws_eip_association.cjitsiYse_eip.allocation_id
    weight      = 100
  }
}

output "global_accelerator_ip" {
  value = aws_globalaccelerator_accelerator.cjitsiYse_global_accelerator.ip_sets
}

*/