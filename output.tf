resource "local_file" "Linux_Ansible_Inventory" {
    content =  templatefile("./templates/inventory-linux.tftpl",
        {
            LinuxMachineIP = "${join("\n", azurerm_public_ip.linux_vm.*.fqdn)}"
            login = "${var.lin_usrname}"
            password = "${random_password.password.result}"
        }
    )
    filename = "./inventory-linux"
    depends_on = [
        azurerm_linux_virtual_machine.linux_vm
    ]
}