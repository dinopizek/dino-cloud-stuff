# Define the following parameters.
$ResourceGroup = "rg-gewe-dino-lab-01"
$Location = "Germany West Central"
$SubscriptionName = "rev-sub-corporate-workload-dev"

$CriticalityTag = "Low"
$DomainTag = "Corporate"

# Get the subscription id.
$Subscription = Get-AzSubscription -SubscriptionName $SubscriptionName

# Select the subscription context.
Set-AzContext -SubscriptionId $Subscription.Id | Out-Null

#Create a resource group.
#New-AzResourceGroup -Name $ResourceGroup -Location $Location

#Create a resource group with tags.
New-AzResourceGroup -Name $ResourceGroup -Location $Location -Tag @{Criticality=$CriticalityTag; Domain=$DomainTag}