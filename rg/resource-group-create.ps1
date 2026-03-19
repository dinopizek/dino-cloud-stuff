# Define the following parameters.
$ResourceGroup = "rg-gewe-dino-lab-01"
$Location = "Germany West Central"

#Create a resource group.
New-AzResourceGroup -Name $ResourceGroup -Location $Location