<#
    ETML
    Auteurs : Ahmad Jano, José Carlos Gasser
    Date : 17.05.2021 13:20
    Description : Projet powershell
#>

Using Namespace System.Windows.Forms
Using Namespace System.Drawing

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

class UIManager {
    [int] $y
    [Form] $frm

    $labels = @{}

    UIManager(){
        $this.frm = New-Object Form
        $this.frm.FormBorderStyle = 'FixedSingle'
        $this.frm.MaximizeBox = $false
        $this.frm.MinimizeBox = $false
    }
    
    CreateLabel([string] $name, [string] $tag)
    {
        $lbl = New-Object Label
        $lbl.Tag = $tag
        $lbl.Name = $name
        $lbl.Width = $this.frm.Width
        $lbl.Parent = $this.frm
        $lbl.Location = [Point]::new(0, $this.y)

        $this.y += $lbl.Height

        $this.labels += @{ $name = $lbl }

        $this.frm.Controls.Add($lbl)
    }

    UpdateLabel([string] $name, [string] $text)
    {
        $lbl = $this.labels[$name]
        if ($lbl) {
            $lbl.Text = $lbl.Tag.Replace('{0}', $text)
        }
        else {
            Write-Error "Le label $name n'est pas trouvé"
        }
    }

    [void] Start()
    {
        [Application]::Run($this.frm)
    }
}

class SystemMonitor {
    [int[]] $usages

    [void] Start(){
            while ($true) {
                Start-Sleep 1

                $info = Get-WmiObject -Class Win32_PerfFormattedData_PerfOS_Processor
                $this.usages = $info.PercentProcessorTime

                Write-Host "SDF"
            }
    }
}

function Move-Control([Control] $ctrl, [int] $x, [int] $y)
{
    $ctrl.Location = New-Object System.Drawing.Point($x, $y)
}

$Monitor = [SystemMonitor]::new()

$UI = [UIManager]::new()

$UI.CreateLabel("cpu", "CPU Usage : {0}")
$UI.UpdateLabel("cpu", "ASDASDAS")
$UI.Start()
$Monitor.Start()

Write-Host $Monitor.usages.Count
