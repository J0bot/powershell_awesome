Using Namespace System.Windows.Forms
Using Namespace System.Drawing


Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

Clear-History

[int] $width = 400
[int] $height = 400
[int] $btnSize = 40
[int] $score
[Timer] $timer


# Form
$frm = New-Object Form

$frm.Size = New-Object Size($width, $height)

# Button
$btn = New-Object Button
$btn.Add_Click({
    Write-Host "Awsome"
    $global:score+=1
    MoveRandom
})
$btn.Size = New-Object Size($btnSize, $btnSize)


# Score
$lblScore = New-Object Label


# Timer
$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 1000
$timer.add_tick({
    MoveRandom
})
$timer.Start()


function MoveRandom()
{
    [int] $randomX = Get-Random -Maximum ($width-$btnSize)
    [int] $randomY = Get-Random -Maximum ($height-$btnSize)
    [Point] $pos = New-Object Point($randomX, $randomY)
    $lblScore.Text = $score.ToString()
    $btn.Location = $pos 
}

$frm.Controls.Add($btn)
$frm.Controls.Add($lblScore)
$frm.ShowDialog()
$timer.Stop()
$timer.Dispose()
[GC]::Collect()