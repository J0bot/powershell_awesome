# ETML
# 11.06.2021
# Ahamd Jano and José Gasser
# Projet powershell : Can you catch the lmao button ?

Using Namespace System.Windows.Forms
Using Namespace System.Drawing


Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Largeur de la fenêtre
[int] $width = 800
# Hauter de la fenêtre
[int] $height = 800
# Taille du bouton
[int] $btnSize = 80
# Le score
[int] $score
# Timer
[Timer] $timer

# Form
$frm = New-Object Form

$frm.Size = New-Object Size($width, $height)

# Image
$image = [System.Drawing.Image]::FromFile("lmaoo.png")
# Button
$btn = New-Object Button
$btn.Add_Click({
    # Augmenter le score
    $global:score+=1

    # Déplacer le bouton aléatoirement
    MoveButtonRandomly

    # Minimum interval = 200
    if ($timer.Interval -gt 200) {
        # Accélerer le jeu
        $timer.Interval = $timer.Interval - 10
        Write-Host $timer.Interval
    }
    
})
$btn.Size = New-Object Size($btnSize, $btnSize)
$btn.Image = $image
$btn.BackgroundImageLayout = [ImageLayout]::Stretch

# Score

$lblScore = New-Object Label
$lblScore.Font = New-Object Font('Consolas', 24)
$lblScore.Size = New-Object Size($width, 50)

# Timer
$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 1000
$timer.add_tick({
    MoveButtonRandomly
})
$timer.Start()

# Changer la couleur du fond d'ecran
function ChangeBackgroundColor {
    $r = Get-Random -Maximum 256
    $g = Get-Random -Maximum 256
    $b = Get-Random -Maximum 256

    $frm.BackColor = [System.Drawing.Color]::FromArgb($r,$g,$b)
}

# Déplacer le bouton aléatoirement
function MoveButtonRandomly()
{
    [int] $randomX = Get-Random -Maximum ($width-($btnSize*2))
    [int] $randomY = Get-Random -Maximum ($height-($btnSize*2))
    [Point] $pos = New-Object Point($randomX, $randomY)
    $lblScore.Text = $score
    $btn.Location = $pos 
    ChangeBackgroundColor
}

# Ajouter les controls
$frm.Controls.Add($btn)
$frm.Controls.Add($lblScore)
$frm.ShowDialog()

# Vider la mémoire
$timer.Stop()
$timer.Dispose()
[GC]::Collect()
$score= 0 