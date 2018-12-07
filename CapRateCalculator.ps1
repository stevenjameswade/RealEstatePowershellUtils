<#
I'm writing this to help me analyze deals faster by feeding in key numbers, the calculator will do the rest. More work is still needed


#Mortage Data
    https://www.mortgagecalculator.org/

#Rent Data
    https://www.rentometer.com/analysis/
    Maybe try https://www.rentdata.org/lookup (looks like they have an api)


Property Management = this is normally abou 10% of rent
Capex and Vacancy
Vacancy = 10%
Capex = 10%
#>
<# Old Script


$PropertyValue = Read-Host 'What does the property cost?' 

[double] $MonthlyRent = Read-Host 'Estimate the monthly rent'

[double]$PropertyTaxPercent = Read-Host "What is the property tax in percent?"
$PropertyTaxPercent = $PropertyTaxPercent /100

[double] $PropertyManagementPercentage =.1
[double] $CapExpensesPercentage =.1
[double] $VacancyCostPercentage =.1

#[double]$OperatingCosts = Read-Host "What are the monthly operating costs in dollars? EG, Maintenance, Management, Capital Expenditure. This doesn't include mortgate"

[double]$MonthlyDebtService = Read-Host "What will you have to pay monthly for mortgage/other debt service?"
$MonthlyOperatingCosts  = $MonthlyRent*($PropertyManagementPercentage +$CapExpensesPercentage +$VacancyCostPercentage)

[double]$NetOperatingIncome = ($MonthlyRent *12) - $PropertyValue*$PropertyTaxPercent  -($MonthlyOperatingCosts *12)

[double]$AnnualCashFlow = $NetOperatingIncome - ($MonthlyDebtService *12)
$MonthlyCashFlow = $AnnualCashFlow /12 

#$NetOperatingIncome = Read-Host 'Estimate the Net Operating Income'
#NetOperating income is the yearly income minus yearly expenses.


[double]$CAPRate = ($NetOperatingIncome / $PropertyValue) * 100

$message = 'Your CAPRate is ' +  $CAPRate  + '%. Your monthly cash flow would is  ' + $MonthlyCashFlow +', or ' + $AnnualCashFlow + ' annually.'
Write-Host $message

#>

#Need to add Insurance to the calculation
Function Calculate-CapRate { #this doesn't work yet, fix it

Param( [Parameter(Mandatory = $true)] $propertyCost, [Parameter(Mandatory = $true)] $monthlyRent, [Parameter(Mandatory = $false)] $propertyTaxPercent = 2 , 
[Parameter(Mandatory = $true)] $monthlyDebtService, [Parameter(Mandatory = $false)][double] $PropertyManagementPercentage =.1, [Parameter(Mandatory = $false)] [double] $CapExpensesPercentage =.1
,[Parameter(Mandatory = $false)] [double] $VacancyCostPercentage =.1
,[Parameter(Mandatory = $false)] $Address ,[Parameter(Mandatory = $false)] $Bedrooms
)
$PropertyTaxPercent = $PropertyTaxPercent /100
$MonthlyOperatingCosts  = $MonthlyRent*($PropertyManagementPercentage +$CapExpensesPercentage +$VacancyCostPercentage)


[double]$NetOperatingIncome = ($MonthlyRent *12) - $PropertyValue*$PropertyTaxPercent  -($MonthlyOperatingCosts *12)

[double]$AnnualCashFlow = $NetOperatingIncome - ($MonthlyDebtService *12)
$MonthlyCashFlow = $AnnualCashFlow /12 


[double]$CAPRate = ($NetOperatingIncome / $propertyCost) * 100

#$message = 'Your CAPRate is ' +  $CAPRate  + '%. Your monthly cash flow would is  ' + $MonthlyCashFlow +', or ' + $AnnualCashFlow + ' annually.'
#Write-Host $message


 $temp = New-Object System.Object
    $temp | Add-Member -MemberType NoteProperty -Name "Address" -Value $Address
    $temp | Add-Member -MemberType NoteProperty -Name "propertyCost" -Value $propertyCost
    $temp | Add-Member -MemberType NoteProperty -Name "CAPRate" -Value $CAPRate
    $temp | Add-Member -MemberType NoteProperty -Name "MonthlyCashFlow" -Value $MonthlyCashFlow
    $temp | Add-Member -MemberType NoteProperty -Name "AnnualCashFlow" -Value $AnnualCashFlow
    $temp | Add-Member -MemberType NoteProperty -Name "NetOperatingIncome" -Value $NetOperatingIncome
    $temp | Add-Member -MemberType NoteProperty -Name "MonthlyOperatingCosts" -Value $MonthlyOperatingCosts


    $temp | Add-Member -MemberType NoteProperty -Name "monthlyRent" -Value $monthlyRent
    $temp | Add-Member -MemberType NoteProperty -Name "monthlyDebtService" -Value $monthlyDebtService
    $temp | Add-Member -MemberType NoteProperty -Name "Bedrooms" -Value $Bedrooms
    $temp | Add-Member -MemberType NoteProperty -Name "PropertyManagementPercentage" -Value $PropertyManagementPercentage
    $temp | Add-Member -MemberType NoteProperty -Name "VacancyCostPercentage" -Value $VacancyCostPercentage
    $temp | Add-Member -MemberType NoteProperty -Name "CapExpensesPercentage" -Value $CapExpensesPercentage

 <# I moved this to the Analyze-Deal Function
 $temp | Export-Csv allAnalyzedDeals.CSV -Encoding Unicode -NoTypeInformation -Append
 New-Variable -Name $Address -Value $temp -Scope Global
#>
 return $temp
 
 
}