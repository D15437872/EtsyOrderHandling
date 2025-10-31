##### USER INTERFACE #####
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

[System.Windows.Forms.Application]::EnableVisualStyles() | Out-Null

function Show-DatePicker {
    param(
        [string]$Title = "Auswahl des Bestelldatums",
        [datetime]$Default = (Get-Date)
    )

    $form = New-Object System.Windows.Forms.Form
    $form.Text = $Title
    $form.ClientSize = New-Object System.Drawing.Size(420, 130)
    $form.StartPosition = "CenterScreen"
    $form.FormBorderStyle = "FixedDialog"
    $form.MaximizeBox = $false
    $form.MinimizeBox = $false
    $form.ShowInTaskbar = $true

    $label = New-Object System.Windows.Forms.Label
    $label.Text = "Bitte waehlen Sie das Datum aus."
    $label.AutoSize = $true
    $label.Top = 10
    $label.Left = 10
    $form.Controls.Add($label)

    # DateTimePicker
    $dtp = New-Object System.Windows.Forms.DateTimePicker
    $dtp.Format = [System.Windows.Forms.DateTimePickerFormat]::Custom
    $dtp.CustomFormat = "dd.MM.yyyy"
    $dtp.Width = 120
    $dtp.Top = 35
    $dtp.Left = 10
    $dtp.Value = $Default
    $form.Controls.Add($dtp)

    # OK-Button
    $ok = New-Object System.Windows.Forms.Button
    $ok.Text = "OK"
    $ok.Top = 70
    $ok.Left = 220
    $ok.Width = 80
    $ok.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $ok.Add_Click({ $form.DialogResult = [System.Windows.Forms.DialogResult]::OK; $form.Close() })
    $form.Controls.Add($ok)

    # Abbrechen-Button
    $cancel = New-Object System.Windows.Forms.Button
    $cancel.Text = "Abbrechen"
    $cancel.Top = 70
    $cancel.Left = 310
    $cancel.Width = 80
    $cancel.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
    $cancel.Add_Click({ $form.DialogResult = [System.Windows.Forms.DialogResult]::Cancel; $form.Close() })
    $form.Controls.Add($cancel)

    $form.AcceptButton = $ok
    $form.CancelButton = $cancel

    return $form.ShowDialog(), $dtp.Value
}

# --- Aufruf ---
$result, $dateValue = Show-DatePicker -Title "Datumseingabe" -Default (Get-Date)

if ($result -ne [System.Windows.Forms.DialogResult]::OK) {
    [System.Windows.Forms.MessageBox]::Show(
        "Ausfuehrung abgebrochen.",
        "Info",
        [System.Windows.Forms.MessageBoxButtons]::OK,
        [System.Windows.Forms.MessageBoxIcon]::Warning
    ) | Out-Null
    exit
}

# Gewähltes Datum als String
$datumString = $dateValue.ToString("dd.MM.yyyy")

######################################################
#### Find Credentials #####
$dirDesktop = [Environment]::GetFolderPath("Desktop")  
$dirCredentials = $dirDesktop + ""             # Set Path of your Credential txt-File on your Desktop (Lookup other file)

Get-Content $dirCredentials | ForEach-Object {
    if ($_ -match "^(.*?)\|(.*)$") {
        $name = $matches[1].Trim()
        $value = $matches[2].Trim()
        # Create variable dynamically
        Set-Variable -Name $name -Value $value
    }
}
######################################################

##### EXPORT API CALL ####

##### Recursive Data Handling #####

##### UPDATE API CALL #####

