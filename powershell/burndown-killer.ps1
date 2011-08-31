#====================================================================================
# @Author: Morten Granlund
# @Date: 2011-08-30
# @Description:
# -------------
# WARNING! Scrum Masters and fainthearted, look away! 
# This is the Ultimate Burndown Chart Killer Script, automating the re-estimation
# of what's left on your change in the current sprint. Set this script as a
# daily "Scheduled Task" in a Windows environment.
#====================================================================================

$src = "C:\Users\mogranlu\Dropbox\Repository\PowerShell\excel\burndown.xlsx"
$decrement = "8"
$cellRange = "BD23:BZ23"

#----------------------------------------------------------------------------------------------------------
# Workaround for a .NET problem when your operating system and your MS Office 
# use different languages! Function copied and pasted from (and problem explained at):
# http://powershell.com/cs/blogs/tobias/archive/2010/08/19/automating-office-and-excel-in-powershell.aspx
#----------------------------------------------------------------------------------------------------------
function Use-Culture {
	param(
		[System.Globalization.CultureInfo]
		[Parameter(Mandatory=$true)]
		$culture,
		[ScriptBlock]
		[Parameter(Mandatory=$true)]
		$code
	)

	trap {
		[System.Threading.Thread]::CurrentThread.CurrentCulture = $currentCulture
	}

	$currentCulture = [System.Threading.Thread]::CurrentThread.CurrentCulture
	[System.Threading.Thread]::CurrentThread.CurrentCulture = $culture
	Invoke-Command $code
	[System.Threading.Thread]::CurrentThread.CurrentCulture = $currentCulture
}

# Create new object reference
$excel = New-Object -comobject Excel.Application

# Open the excel spreadsheet (using another way of getting around the culture (locale) problem in .NET):
$ci= [System.Globalization.CultureInfo]'en-US'
$book=$excel.Workbooks.PSBase.GetType().InvokeMember('Open', [Reflection.BindingFlags]::InvokeMethod, $null,$excel.Workbooks, $src, $ci)

# We want worksheet #1 in this spreadsheet
$worksheet = $book.Worksheets.Item(1)

$theCell = $worksheet.Range($cellRange).FormulaLocal =  $decrement

# Save the spreadsheet (running the Save() method on $excel will cause a weird warning: "RESUME.XLW already exists"!)
Use-Culture en-US { $book.Save() }

$excel.Quit()
