# Define the following parameters.
$ResourceGroup = "rg-gewe-dino-lab-01"
$Location = "Germany West Central"

$WebAppName = "wa-gewe-dino-lab-01"
$AppServicePlanName = "asp-gewe-dino-lab-01"

# Create a new Web App.
New-AzWebApp -ResourceGroupName $ResourceGroup -Name $WebAppName -Location $Location -AppServicePlan $AppServicePlanName