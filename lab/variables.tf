
variable "lab" {
    description = "VMware Lab Configuration"
    type = list(object({
        datacenter = string
        datastore = string
        resource_pool = string
        folder = string
        network = string
        network_type = string
        network_options = object({
            ipv4_address = string
            ipv4_netmask = number
            ipv4_gateway = string
            dns_server_list = list(string)
        })
        dns_domain = string
        template = string
        vm_name = string
        num_cpus = number
        memory = number
        additional_disks = list(number)
    }))
    default = []
}
