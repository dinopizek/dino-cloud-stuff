param networkWatcherName string = 'nw-use2-dr-prod-01'

resource networkWatcher 'Microsoft.Network/networkWatchers@2025-07-01' = {
  name: networkWatcherName
  location: 'eastus2'
  tags: {
    criticality: 'high'
    domain: 'itoperations'
  }
  properties: {}
}
