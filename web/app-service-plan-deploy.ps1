# Define the following parameters.
$ResourceGroup = "rg-gewe-dino-lab-01"
$Location = "Germany West Central"

$AppServicePlanName = "asp-gewe-dino-lab-01"
$AppServicePlanTier = "Free"

# Create a new App Service Plan.
New-AzAppServicePlan -Name $AppServicePlanName -ResourceGroupName $ResourceGroup -Location $Location -Tier $AppServicePlanTier