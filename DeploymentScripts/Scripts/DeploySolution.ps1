

Param (
	[Parameter(Mandatory=$true, HelpMessage="URL of site collection, to which should be added.")]
	[string] $SiteUrl,
	
	[Parameter(Mandatory=$true, HelpMessage="Absolute path to WSP. If not specified, relative solution path within 'Debug - No Code Analysis' will be used.")]
	[string] $WspFullName
)


$currentLocation = Split-Path $script:MyInvocation.MyCommand.Path
if(-not $tpcipSharedLoaded)
{
	& $currentLocation\Shared.ps1
}



#Message -message "Webapp url  " -NoNewLine
#foreach($my_sol in Get-SPSite -limit All )
#	{
#		echo $my_sol.Url
#	}


if (Get-SPSite -limit All | where {$_.Url -eq $SiteUrl})
{
	$WebAppUrl = (Get-SPSite $SiteUrl -limit 1).WebApplication.Url.TrimEnd('/');
}
else
{
	throw "WebAppUrl cannot be set, because site collection '$SiteUrl' doesn't exist."
}		
#Message -info $WebAppUrl



$solutionName = Split-Path -Path $WspFullName -Leaf
$slnToRemove = Get-SPSolution | where {$_.Name -eq $solutionName}
if($slnToRemove){
	Message -section "Uninstall solution $solutionName"
	$slnToRemove | Uninstall-FarmSolution
	$slnToRemove | Remove-SPSolution -Confirm:$false
}



Message -section "Deploy solution $solutionName"
Deploy-FarmSolution -WebAppUrl $WebAppUrl -WspFullName $WspFullName -upgradeSolutions $true



$ErrorActionPreference = $prevErrorActionPreference
