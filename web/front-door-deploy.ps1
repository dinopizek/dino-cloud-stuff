# Define the following parameters.
$ResourceGroup = "rg-gewe-dino-lab-01"
$Location = "Global"

$FrontDoorName = $ProfileName = "fd-gewe-dino-lab-01"
$FrontDoorSku = "Standard_AzureFrontDoor"

$EndpointName = "frontend-endpoint-gewe-dino-lab-01"
$RoutingRuleName = "routing-rule-gewe-dino-lab-01"

$OriginGroupName = "origin-group-gewe-dino-lab-01"
$OriginName = "wa-gewe-dino-lab-01"
$OriginHostName = "wa-gewe-dino-lab-01.azurewebsites.net"

# Create a new Front Door profile.
New-AzFrontDoorCdnProfile -ResourceGroupName $ResourceGroup -Name $FrontDoorName -Location $Location -Sku $FrontDoorSku

# Create a new Front Door endpoint.
New-AzFrontDoorCdnEndpoint -ResourceGroupName $ResourceGroup -EndpointName $EndpointName -ProfileName $ProfileName -Location $Location

# Create a new Front Door health probe settings.
$HealthProbeSetting = New-AzFrontDoorCdnOriginGroupHealthProbeSettingObject -ProbeIntervalInSecond 60 -ProbePath "/" -ProbeRequestType GET -ProbeProtocol Http

# Create a new load balancing settings.
$LoadBalancingSetting = New-AzFrontDoorCdnOriginGroupLoadBalancingSettingObject -AdditionalLatencyInMillisecond 50 -SampleSize 4 -SuccessfulSamplesRequired 3

# Create a new Front Door origin group.
New-AzFrontDoorCdnOriginGroup -ResourceGroupName $ResourceGroup -OriginGroupName $OriginGroupName -ProfileName $ProfileName -HealthProbeSetting $HealthProbeSetting -LoadBalancingSetting $LoadBalancingSetting

# Add an app to Front Door origin group.
New-AzFrontDoorCdnOrigin -ResourceGroupName $ResourceGroup -OriginGroupName $OriginGroupName -OriginName $OriginName -HostName $OriginHostName -ProfileName $ProfileName -HttpPort 80 -HttpsPort 443 -Priority 1 -Weight 1000

# Create a new Front Door route.
$OriginGroupId = (Get-AzFrontDoorCdnOriginGroup -ResourceGroupName $ResourceGroup -OriginGroupName $OriginGroupName -ProfileName $ProfileName).Id
New-AzFrontDoorCdnRoute -ResourceGroupName $ResourceGroup -Name $RoutingRuleName -ProfileName $ProfileName -EndpointName $EndpointName -OriginGroupId $OriginGroupId -LinkToDefaultDomain Enabled