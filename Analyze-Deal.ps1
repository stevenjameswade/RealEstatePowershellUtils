<#Analyze-Deal
This combines fair-market rent, capRate and mortgage payment caluculator. It requires all 3 functions to be imported
Assumes 30 year loan, 5.2 interest rate and fair market rent. So Far, doesn't take out cost for Insurance
#>

Function Analyze-Deal {
Param( [Parameter(Mandatory = $true)][double] $propertyCost,[Parameter(Mandatory = $true)] $ZipCode,
 [Parameter(Mandatory = $false) ] $Bedrooms = 2, [Parameter(Mandatory = $false) ][double] $annualPercentageRate = 5.2, 
 [Parameter(Mandatory = $false) ][double] $downpaymentPercent = 20, [Parameter(Mandatory = $false) ][double] $numberofyears = 30,
 [double] $PropertyManagementPercentage =.1, [Parameter(Mandatory = $false)] [double] $CapExpensesPercentage =.1,
 [Parameter(Mandatory = $false)] [double] $VacancyCostPercentage =.1,
 [Parameter(Mandatory = $false)] $Address,
 [Parameter(Mandatory = $false)] $monthlyRent)
 
 $monthlyMortgagePayment = Calculate-MortgagePayment -propertyCost $propertyCost -annualPercentageRate $annualPercentageRate -numberofyears $numberofyears -downpaymentPercent $downpaymentPercent 
 
 if($monthlyRent -eq $null){
 $fairMarketRent = Get-FairMarketRent -ZipCode $ZipCode -Bedrooms $Bedrooms
 $monthlyRent = $fairMarketRent
 }
 
 $info = Calculate-CapRate -propertyCost $propertyCost -monthlyRent $monthlyRent -propertyTaxPercent $propertyTaxPercent -monthlyDebtService $monthlyMortgagePayment -PropertyManagementPercentage $PropertyManagementPercentage -CapExpensesPercentage $CapExpensesPercentage -VacancyCostPercentage $VacancyCostPercentage -Address $Address -Bedrooms $Bedrooms

#$monthlyMortgagePayment, $fairMarketRent


$info | Export-Csv allAnalyzedDeals.csv -Encoding Unicode -NoTypeInformation -Append
 New-Variable -Name $Address -Value $info -Scope Global
 $CAPRate = '{0:N}' -f $info.CAPRate
 $MonthlyCashFlow = '{0:N}' -f  $info.MonthlyCashFlow
 $AnnualCashFlow = '{0:N}' -f $info.AnnualCashFlow



   $Message = 'CAPRate: ' +  $CAPRate  + '%.  monthlyCashFlow: $' + $MonthlyCashFlow +', or $' + $AnnualCashFlow + ' annually.'
   Write-Host $Message

#   $copy = Read-Host "Copy to Clipboard? y/n"
#if($copy -eq 'y')
#{
$Message | clip.exe
#}

  return $info | select -Property  CAPRate, MonthlyCashFlow, AnnualCashFlow, Address


}