$key="YOUR_KEY"
$endpoint="YOUR_ENDPOINT"



# Code to call Face service for face detection
$img_file = "img1.jpg"
if ($args.count -gt 0 -And $args[0] -in ("img1.jpg", "img2.jpg", "img3.jpg"))
{
    $img_file = $args[0]
}

$img = "https://raw.githubusercontent.com/humblefool1998/testai/main/data/$img_file"

$headers = @{}
$headers.Add( "Ocp-Apim-Subscription-Key", $key )
$headers.Add( "Content-Type","application/json" )

$body = "{'url' : '$img'}"

write-host "Analyzing image...`n"
$result = Invoke-RestMethod -Method Post `
          -Uri "$endpoint/face/v1.0/detect?detectionModel=detection_01&returnFaceId=true&returnFaceAttributes=age,smile,facialHair,glasses,emotion,hair,makeup,accessories" `
          -Headers $headers `
          -Body $body | ConvertTo-Json -Depth 5

$analysis = ($result | ConvertFrom-Json)
foreach ($face in $analysis)
{
    Write-Host("Face location: $($face.faceRectangle)`n - Age:$($face.faceAttributes.age)`n - Emotions: $($face.faceAttributes.emotion)`n")
}