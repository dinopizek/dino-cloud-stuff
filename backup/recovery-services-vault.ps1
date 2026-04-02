# Define the following parameters.
$ResourceGroup = "rg-gewe-dino-lab-01"
$Location = "Germany West Central"
$VaultName = "rsv-use2-corp-app-backup-test-01"

# Create a new Recovery Services Vault.
New-AzRecoveryServicesVault -Name $VaultName -ResourceGroupName $ResourceGroup -Location $Location