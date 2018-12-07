#Get-FairMarketRent
#need to write in logice to only return the specific number of bedroom rent

 $FMRs = import-csv .\FMRsByZipUpdate.csv

 Function Get-FairMarketRent {

 Param( [Parameter(Mandatory = $true)] $ZipCode, [Parameter(Mandatory = $false) ] $Bedrooms = 2,[Parameter(Mandatory = $false)] [switch]$ShowAll)

 $requestFMR = $FMRs | where {$_.zipcode -eq $ZipCode} | select Zipcode,HUDMetroFairMarketRentAreaName,SAFMR0BR,SAFMR1BR,SAFMR2BR,SAFMR3BR,SAFMR4BR

 #Write-host $requestFMR
 #[int] ($requestFMR.SAFMR0BR) =(($requestFMR.SAFMR0BR).Split("$"))[1]
 #return $requestFMR
 if($ShowAll){
  Write-host $requestFMR
   return $requestFMR
 } 
 Elseif(!$ShowAll){
 [int] ($requestFMR.SAFMR0BR) =(($requestFMR.SAFMR0BR).Split("$"))[1]
 [int] ($requestFMR.SAFMR1BR) =(($requestFMR.SAFMR1BR).Split("$"))[1]
 [int] ($requestFMR.SAFMR2BR) =(($requestFMR.SAFMR2BR).Split("$"))[1]
 [int] ($requestFMR.SAFMR3BR) =(($requestFMR.SAFMR3BR).Split("$"))[1]
 [int] ($requestFMR.SAFMR4BR) =(($requestFMR.SAFMR4BR).Split("$"))[1]
 }
 #Write-Host "Fair Market Rent for a $Bedrooms room house in $ZipCode" = 
 Switch($Bedrooms)
 {
    0{ return $requestFMR.SAFMR0BR}
    1{ return $requestFMR.SAFMR1BR}
    2{ return $requestFMR.SAFMR2BR}
    3{ return $requestFMR.SAFMR3BR}
    4{ return $requestFMR.SAFMR4BR}

 }


 }