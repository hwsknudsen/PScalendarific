$year = (get-date).year

$requestUrl = "https://calendarific.com/api/v2/holidays?country=BM&year=$year&api_key=KEYXXX"
$response1 = Invoke-RestMethod -Uri $requestUrl -UseBasicParsing
$1 = $response1.response.holidays 

$year =$year+1
$requestUrl = "https://calendarific.com/api/v2/holidays?country=BM&year=$year&api_key=KEYXXX"
$response2 = Invoke-RestMethod -Uri $requestUrl -UseBasicParsing
$2 = $response2.response.holidays 

$year =$year+1
$requestUrl = "https://calendarific.com/api/v2/holidays?country=BM&year=$year&api_key=KEYXXX"
$response3 = Invoke-RestMethod -Uri $requestUrl -UseBasicParsing
$3 = $response3.response.holidays 

$response4 = $1 + $2 + $3


 
$4 = $response4| where-object {$_.type -ne 'National holiday'} | select name, description, @{ Name = 'Date';  Expression = {(get-date(($_.date).iso)).ToString("dd-MM-yyyy")}}, @{ Name = 'DateUnformatted';  Expression = {(get-date(($_.date).iso))}}, @{ Name = 'Weekday';  Expression = {(get-date(($_.date).iso)).Dayofweek}}, Type| Where-Object {$_.DateUnformatted -ge (get-date) -and ($_.DateUnformatted).Dayofweek -notlike "Saturday" -and ($_.DateUnformatted).Dayofweek -notlike "Sunday"} | select name,description, Date, Weekday, Type | ft -AutoSize

$4

 
$2 = $response4| where-object {$_.type -ne 'Season' -and $_.type -ne 'Observance' -and $_.type -ne 'Clock change/Daylight Saving Time'} | select name, @{ Name = 'Date';  Expression = {(get-date(($_.date).iso)).ToString("dd-MM-yyyy")}}, @{ Name = 'DateUnformatted';  Expression = {(get-date(($_.date).iso))}}, @{ Name = 'Weekday';  Expression = {(get-date(($_.date).iso)).Dayofweek}}, Type| Where-Object {$_.DateUnformatted -ge (get-date) -and ($_.DateUnformatted).Dayofweek -notlike "Saturday" -and ($_.DateUnformatted).Dayofweek -notlike "Sunday"} | select name, Date | ft -AutoSize #, Weekday, Type | ft -AutoSize

$2
