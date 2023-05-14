#!/bin/pwsh

Get-Content $args[0] | foreach {
  Write-Output "Exportiong $_"
  $name, $value = $_.split('=')
  set-content env:\$name $value
}