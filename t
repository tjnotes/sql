# Define the path to your solution file
$solutionPath = "C:\Path\To\YourSolution.sln"

# Read the content of the .sln file and select lines that define a project
$projectLines = Get-Content $solutionPath | Select-String '^Project\('

# Extract project names from each line
$projectNames = $projectLines -replace '^.+= "', '' -replace '" .+$', ''

# Output the project names
$projectNames
