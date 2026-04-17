# Define a credential object for linux
$vmAdminUsername = "dino"
$securePassword = ConvertTo-SecureString 'Jakalozinka!' -AsPlainText -Force

#Define the following parameters for a new resource group.
$ResourceGroup = "rg-gewe-dino-lab-01"
$Location = "Germany West Central"

#Define the following parameters for the virtual machine.
$vmComputerName = "vm-gewe-dino-lab"

#Define the following parameters for the Azure resources.
$VmName = $vmComputerName
$VmOsDiskName = $vmComputerName + "-osdisk-01"
$VmSize = "Standard_D8s_v5"

#Define the networking information.
$NicName = $vmComputerName + "-nic-01"
$PublicIpName = $vmComputerName + "-pip1"

#Define the new VNet information.
$VnetName = "vn-dino-lab-01"
$VnetPrefix = "10.0.0.0/16"

#Define the new subnet information.
$VnetSubnetName = "sn-dino-vm-lab-01"
$VnetSubnetPrefix = "10.0.0.0/24"

#Create the new Vnet and subnet
$subnet = New-AzVirtualNetworkSubnetConfig -Name $VnetSubnetName -AddressPrefix $VnetSubnetPrefix
New-AzVirtualNetwork -Name $VnetName -ResourceGroupName $ResourceGroup -Location $Location -AddressPrefix $VnetPrefix -Subnet $subnet

#Define the VM marketplace image details.
$VmPublisherName = "canonical"
$VmOffer = "0001-com-ubuntu-server-focal"
$VmSkus = "20_04-lts-gen2"

#Get the subnet details for the specified virtual network + subnet combination.
$VnetSubnet = (Get-AzVirtualNetwork -Name $VnetName -ResourceGroupName $ResourceGroup).Subnets | Where-Object { $_.Name -eq $VnetSubnetName }

#Create the public IP address.
$PublicIp = New-AzPublicIpAddress -Name $PublicIpName -ResourceGroupName $ResourceGroup -Location $Location -AllocationMethod Dynamic -Sku Basic

#Create the NIC and associate the public IpAddress.
$NIC = New-AzNetworkInterface -Name $NicName -ResourceGroupName $ResourceGroup -Location $Location -SubnetId $VnetSubnet.Id
$NIC | Set-AzNetworkInterfaceIpConfig -Name $NIC.IpConfigurations.Name -PublicIpAddress $PublicIp
$NIC | Set-AzNetworkInterface

#Store the credentials for the local admin account.
$vmCredential = New-Object System.Management.Automation.PSCredential ($vmAdminUsername, $securePassword)

#Accept deal with the devil
Set-AzMarketplaceTerms -Publisher $VmPublisherName -Product $VmOffer -Name $VmSkus -Accept

#Define the parameters for the new virtual machine.
$VirtualMachine = New-AzVMConfig -VMName $VmName -VMSize $VmSize #-AvailabilitySetId $availSet.Id
$VirtualMachine = Set-AzVMOperatingSystem -VM $VirtualMachine -Linux -ComputerName $vmComputerName -Credential $vmCredential
$VirtualMachine = Add-AzVMNetworkInterface -VM $VirtualMachine -Id $NIC.Id
$VirtualMachine = Set-AzVMSourceImage -VM $VirtualMachine -PublisherName $VmPublisherName -Offer $VmOffer -Skus $VmSkus -Version 'latest'
$VirtualMachine = Set-AzVMBootDiagnostic -VM $VirtualMachine -Enable
# Standard_LRS = HDD, StandardSSD_LRS = Standard SSD, Premium_LRS = SSD, UltraSSD_LRS = Ultra SSD
$VirtualMachine = Set-AzVMOSDisk -VM $VirtualMachine -StorageAccountType "Premium_LRS" -Caching ReadWrite -Name $VmOsDiskName -CreateOption FromImage -DiskSizeInGB 64

#Create the virtual machine.
New-AzVM -ResourceGroupName $ResourceGroup -Location $Location -VM $VirtualMachine -Verbose #-LicenseType "Windows_Server"

Write-Host "##### Set Static IP on NIC! #####" -BackgroundColor DarkBlue -ForegroundColor White