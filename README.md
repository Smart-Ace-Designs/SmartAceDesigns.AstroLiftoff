# SmartAceDesigns.AstroLiftoff
This repository contains two items:

1. A PowerShell module that consists of a function for deploying a Smart-Ace-Designs Astro project template. This module is not currently available in the "PowerShell Gallery" and will require you to manually install it in your modules folder. This function includes the alias `New-AstroProject`, the original name prior to being added to the module, for backwards compatibility.

2. A standaline PowerShell function that can be used in lieu of using the above PowerShell module. This function can be added to a PowerShell profile file such as "Microsoft.PowerShell_profile.ps1".

## Examples
```sh
New-SADAstroProject -ProjectName name -Location directory -Template template-name -PackageManager name
```
```sh
New-AstroProject -ProjectName name -Location directory -Template template-name -PackageManager name
```
