# Build the following Lab
lab = [
    {
        datacenter = "dc"
        datastore = "datastore"
        resource_pool = "pool"
        folder = "terraform"
        network = "terraform"
        network_type = "static"
        network_options = {
            ipv4_address = "192.168.10.10"
            ipv4_netmask = 24
            ipv4_gateway = "192.168.10.1"
            dns_server_list = [
                "192.168.10.2",
                "192.168.10.3"
            ]
        }
        dns_domain = "terraform.local"
        template = "centos8-template"
        vm_name = "vm1"
        num_cpus = 1
        memory = 2048
        additional_disks = []
    },
    {
        datacenter = "dc"
        datastore = "datastore"
        resource_pool = "pool"
        folder = "terraform"
        network = "terraform"
        network_type = "dhcp"
        network_options = null
        dns_domain = "terraform.local"
        template = "centos8-template"
        vm_name = "vm2"
        num_cpus = 1
        memory = 2048
        additional_disks = []
    }
]
