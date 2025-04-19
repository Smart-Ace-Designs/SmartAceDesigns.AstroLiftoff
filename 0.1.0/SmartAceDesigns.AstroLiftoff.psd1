﻿<#
============================================================================================================================
Module manifest for module: SmartAceDesigns.AstroLiftoff

Generated by: Smart Ace Designs
Generated on: 04/15/2025
============================================================================================================================
#>

@{
RootModule = 'SmartAceDesigns.AstroLiftoff.psm1'
ModuleVersion = '0.1.0'
CompatiblePSEditions = @('Desktop','Core')
PowerShellVersion = '5.1'
GUID = '99d484e4-d391-4b7e-a45d-1adcfbc2da5b'
Author = 'Smart Ace Designs'
CompanyName = 'Smart Ace Designs'
Copyright = '(c) 2025 Smart Ace Designs. All rights reserved.'
Description = @'
Smart Ace Designs | Astro Lift Off module.  This module contains a function used for deploying a custom Astro template.
'@

PrivateData = @{
    PSData = @{
        ProjectUri = 'https://github.com/Smart-Ace-Designs/SmartAceDesigns.AstroLiftoff'
        LicenseUri = 'https://github.com/Smart-Ace-Designs/SmartAceDesigns.AstroLiftoff/blob/main/LICENSE'
        
        ReleaseNotes = @'
0.1.0 - Beta Release
- Initial design of module
'@
        
        Tags = @(
                'Astro',
                'Tailwind',
                'Vue',
                'NuxtUI',
                'Template',
                'Opinionated'
        )
    }
}

FunctionsToExport = @('New-SADAstroProject')
CmdletsToExport = '*'
VariablesToExport = '*'
AliasesToExport = '*'
}
