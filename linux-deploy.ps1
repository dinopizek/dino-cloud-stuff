# Define a credential object for linux
$vmAdminUsername = "dino"
$securePassword = ConvertTo-SecureString 'Jakalozinka!' -AsPlainText -Force

#Define the following parameters for a new resource group.
$azureResourceGroup = "rg-gewe-dino-vm-lab-01"
$azureLocation = "Germany West Central"

#Create the resource group.
New-AzResourceGroup -Name $azureResourceGroup -Location $azureLocation

#Define the following parameters for the virtual machine.
$vmComputerName = "vm-gewe-dino-lab"

#Define the following parameters for the Azure resources.
$azureVmName = $vmComputerName
$azureVmOsDiskName = $vmComputerName + "-osdisk-01"
$azureVmSize = "Standard_D8s_v5"

#Define the networking information.
$azureNicName = $vmComputerName + "-nic-01"
$azurePublicIpName = $vmComputerName + "-pip1"

#Define the new VNet information.
$azureVnetName = "vn-dino-lab-01"
$azureVnetPrefix = "10.0.0.0/16"

#Define the new subnet information.
$azureVnetSubnetName = "sn-dino-vm-lab-01"
$azureVnetSubnetPrefix = "10.0.0.0/24"

#Create the new Vnet and subnet
$subnet = New-AzVirtualNetworkSubnetConfig -Name $azureVnetSubnetName -AddressPrefix $azureVnetSubnetPrefix
New-AzVirtualNetwork -Name $azureVnetName -ResourceGroupName $azureResourceGroup -Location $azureLocation -AddressPrefix $azureVnetPrefix -Subnet $subnet

#Define the VM marketplace image details.
$azureVmPublisherName = "canonical"
$azureVmOffer = "0001-com-ubuntu-server-focal"
$azureVmSkus = "20_04-lts-gen2"

#Get the subnet details for the specified virtual network + subnet combination.
$azureVnetSubnet = (Get-AzVirtualNetwork -Name $azureVnetName -ResourceGroupName $azureResourceGroup).Subnets | Where-Object { $_.Name -eq $azureVnetSubnetName }

#Create the public IP address.
$azurePublicIp = New-AzPublicIpAddress -Name $azurePublicIpName -ResourceGroupName $azureResourceGroup -Location $azureLocation -AllocationMethod Dynamic -Sku Basic

#Create the NIC and associate the public IpAddress.
$azureNIC = New-AzNetworkInterface -Name $azureNicName -ResourceGroupName $azureResourceGroup -Location $azureLocation -SubnetId $azureVnetSubnet.Id
$azureNIC | Set-AzNetworkInterfaceIpConfig -Name $azureNIC.IpConfigurations.Name -PublicIpAddress $azurePublicIp
$azureNIC | Set-AzNetworkInterface

#Store the credentials for the local admin account.
$vmCredential = New-Object System.Management.Automation.PSCredential ($vmAdminUsername, $securePassword)

#Accept deal with the devil
Set-AzMarketplaceTerms -Publisher $azureVmPublisherName -Product $azureVmOffer -Name $azureVmSkus -Accept

#Define the parameters for the new virtual machine.
$VirtualMachine = New-AzVMConfig -VMName $azureVmName -VMSize $azureVmSize #-AvailabilitySetId $availSet.Id
$VirtualMachine = Set-AzVMOperatingSystem -VM $VirtualMachine -Linux -ComputerName $vmComputerName -Credential $vmCredential
$VirtualMachine = Add-AzVMNetworkInterface -VM $VirtualMachine -Id $azureNIC.Id
$VirtualMachine = Set-AzVMSourceImage -VM $VirtualMachine -PublisherName $azureVmPublisherName -Offer $azureVmOffer -Skus $azureVmSkus -Version 'latest'
$VirtualMachine = Set-AzVMBootDiagnostic -VM $VirtualMachine -Enable
# Standard_LRS = HDD, StandardSSD_LRS = Standard SSD, Premium_LRS = SSD, UltraSSD_LRS = Ultra SSD
$VirtualMachine = Set-AzVMOSDisk -VM $VirtualMachine -StorageAccountType "Premium_LRS" -Caching ReadWrite -Name $azureVmOsDiskName -CreateOption FromImage -DiskSizeInGB 64

#Create the virtual machine.
New-AzVM -ResourceGroupName $azureResourceGroup -Location $azureLocation -VM $VirtualMachine -Verbose #-LicenseType "Windows_Server"

Write-Host "##### Set Static IP on NIC! #####" -BackgroundColor DarkBlue -ForegroundColor White