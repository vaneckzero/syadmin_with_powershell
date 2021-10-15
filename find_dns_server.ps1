((get-netipconfiguration).dnsserver) | ForEach-Object {
  if ($_.ServerAddresses -like "*127*"){
    $_.InterfaceAlias + " " + $_.ServerAddresses
    }
  }
