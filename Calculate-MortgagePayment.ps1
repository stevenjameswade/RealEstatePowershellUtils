<#Mortgage Calculator
I got this from here https://www.nerdwallet.com/mortgages/mortgage-calculator/calculate-mortgage-payment
For the paper and pencil mathletes out there, the mortgage payment calculation looks like this:

M = P [ i(1 + i)^n ] / [ (1 + i)^n – 1]

The variables are as follows:

M = monthly mortgage payment
P = the principal amount
i = your monthly interest rate. Your lender likely lists interest rates as an annual figure, so you’ll need to divide by 12, for each month of the year. So, if your rate is 5%, then the monthly rate will look like this: 0.05/12 = 0.004167.
n = the number of payments over the life of the loan. If you take out a 30-year fixed rate mortgage, this means: n = 30 years x 12 months per year, or 360 payments.
#>

[double]$propertyCost
[double]$monthlyPayment
[double]$annualPercentageRate
[double]$monthlyPercentageRate
[double]$downpaymentPercent 

Function Calculate-MortgagePayment { 

Param( [Parameter(Mandatory = $true)] $propertyCost, [Parameter(Mandatory = $false) ] $annualPercentageRate = 5.2, [Parameter(Mandatory = $false) ] $downpaymentPercent = 20, [Parameter(Mandatory = $false) ] $numberofyears = 30)

# M = P [ i(1 + i)^n ] / [ (1 + i)^n – 1]
$annualPercentageRate = $annualPercentageRate /100
 #P = principal
 $P = ($propertyCost*( .01*(100-$downpaymentPercent)))
 #i is monthly interest rate
$i = $annualPercentageRate/12

 #n = total number of payments
$n= 12 * $numberofyears
$monthlyPayment = (($P *($i *([math]::pow((1 + $i),$n))))/([math]::pow((1 + $i),($n))-1))


 return $monthlyPayment
}