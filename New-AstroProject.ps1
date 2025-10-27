function New-AstroProject
{
    <#
    .SYNOPSIS
    Generates a new Astro project from a custom template.

    .DESCRIPTION
    This is a standalone version of the "New-SADAstroProject" function, included in the "SmartAceDesigns.AstroLiftoff" PowerShell module.
    It generates a new Astro project based on a custom template hosted by "https://github.com/Smart-Ace-Designs".
    This includes:

    - Using the Astro create-astro@latest CLI to deploy the initial template.
    - Navigating to the project folder and peforming an initial install.
    - Using the Astro @astrojs/upgrade CLI to update key Astro packages.
    - Using the selected package manager to update support packages.
    - Initializing a git repository.
    - Creating additional support directories and .env file.
    - Using the prettier CLI to provide an intial format of all project files.
    - Providing an option to launch the site and/or open the project folder with VS Code post deployment.

    This function can be added to your "Microsoft.PowerShell_profile.ps1" PowerShell profile file in lieu of using the "SmartAceDesigns.AstroLiftoff" module.

    .PARAMETER ProjectName
    Specifies the name to use for the project directory.

    .PARAMETER Location
    Specifies the root directory path of the new Astro project directory.

    .PARAMETER Template
    Specifies the name of the custom Astro template to use:

    - astro-major-tom (Astro | Component homepage)
    - astro-moonbase (Astro | Vue | shadcn-vue | Component homepage)
    - astro-space (Astro | Blank homepage)
    - astro-starbreeze (Astro | Starwind UI | Blank homepage)

    .PARAMETER StartApp
    Specifies whether to launch the development web server (http://localhost:4321) for the project, post deployment.

    .PARAMETER StartCode
    Specifies whether to open the project folder with VS Code, post deployment.

    .PARAMETER PackageManager
    Specifies which package manager to use (npm | bun) with the template.

    .EXAMPLE
    PS C:\>New-AstroProject -ProjectName astro-test -Location D:\Demo -Template astro-space

    Description
    -----------
    Deploys a new Astro project "D:\Demo\astro-test" using the "astro-space" template.

    .EXAMPLE
    PS C:\>New-AstroProject -ProjectName astro-test -Location D:\Demo -Template astro-space -StartApp

    Description
    -----------
    Deploys a new Astro project "D:\Demo\astro-test" using the "astro-space" template and automatically starts the development web server after the deployment has completed.

    .LINK
    https://github.com/Smart-Ace-Designs/SmartAceDesigns.AstroLiftoff
    #>

    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true)] [string]$ProjectName,
        [Parameter(Mandatory = $true)] [string]$Location,
        [Parameter(Mandatory = $true)] [ValidateSet(
            "astro-major-tom",
            "astro-moonbase",
            "astro-space",
            "astro-starbreeze"
        )] [string]$Template,
        [Parameter(Mandatory = $false)] [switch]$StartApp,
        [Parameter(Mandatory = $false)] [switch]$StartCode,
        [Parameter(Mandatory = $false)] [ValidateSet(
            "bun",
            "npm"
        )] [string]$PackageManager = "bun"
    )

    switch ($PackageManager)
    {
        "bun" {$PackageManagerX = "bunx"}
        "npm" {$PackageManagerX = "npx"}
    }

    Clear-Host
    $Message = "Astro Deployment Tool"
    $Width = $Host.UI.RawUI.WindowSize.Width
    Write-Host
    Write-Host ((" " * ($Width - $Message.Length)) + $Message) -ForegroundColor Green
    Write-Host ("=" * $Width)

    if (!(Get-Command -Name $PackageManager -ErrorAction SilentlyContinue))
    {
        Write-Host "`nPackage manager ($PackageManager) not found."
        Write-Host "Operation cancelled...liftoff failed!"
        return
    }

    if (Test-Path -Path "$Location\$ProjectName")
    {
        Write-Host "`nProject folder ($ProjectName) already exists. Please select a different project name."
        Write-Host "Operation cancelled...liftoff failed!"
        return
    }

    Set-Location $Location
    if (Get-Command -Name git -ErrorAction SilentlyContinue)
    {
        & $PackageManager create astro@latest -- --template smart-ace-designs/$($Template) `
            --git --no-install $ProjectName
    }
    else
    {
        Write-Host "`nWarning: Git was not detected on this system. Git initialization will be skipped." -ForegroundColor DarkYellow
        & $PackageManager create astro@latest -- --template smart-ace-designs/$($Template) `
            --no-git --no-install $ProjectName
    }

    if (!(Test-Path -Path $ProjectName))
    {
        Write-Host "`nProject folder ($ProjectName) was not created."
        Write-Host "Operation cancelled...liftoff failed!"
        Write-Host "`nIf using Bun please run `"bun pm cache rm`" to clear the cache and try again."
        return
    }

    Write-Host
    Set-Location $ProjectName
    switch ($PackageManager)
    {
        "bun" {& $PackageManager install --no-summary}
        "npm" {& $PackageManager install --silent}
    }

    & $PackageManagerX @astrojs/upgrade
    & $PackageManager update --silent --save

    if (!(Test-Path -Path "src/components"))
    {
        [void](New-Item -Name "components" -Path src -ItemType Directory)
    }
    if (!(Test-Path -Path "src/assets"))
    {
        [void](New-Item -Name "assets" -Path src -ItemType Directory)
    }

    Write-Host
    & $PackageManagerX prettier . --write --log-level silent
    & $PackageManagerX prettier . --check
    if ($StartCode -and (Get-Command -Name code -ErrorAction SilentlyContinue)) {code .}
    Write-Host
    Write-Host ("=" * $Width)
    if ($StartApp) {& $PackageManager run dev}
}
