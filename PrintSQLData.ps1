# Teamcity configuration
Set-StrictMode -Version Latest

# Error Handler
$ErrorActionPreference = "Stop"

# Imports
Import-Module SqlServer

# Scheduling
# Daily Script

# Global Variables
$serverInstance = ""
$dbName = ""
$schemaName = ""
$tableName = ""

# Functions
function printData {
    [CmdletBinding()]
    param ($serverInstance, $dbName, $schemaName, $tableName) 
    
    Write-Host "[INFO] Output of the database $dbName:" -ForegroundColor Green
    $data = read-sqltabledata -serverInstance $serverInstance -databasename $dbName -schemaname $schemaName -tablename $tableName -outputas datatable  
    
    # using echo for string formatting
    echo $data
}

# Main
printData $serverInstance $dbName $schemaName $tableName
printData "server" "dbName" "dbo" "tableName"
