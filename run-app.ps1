# Check if OpenAI API Key is provided as an argument
param (
    [string]$ApiKey
)

if ([string]::IsNullOrEmpty($ApiKey)) {
    Write-Host "Please provide your OpenAI API Key."
    $ApiKey = Read-Host -Prompt "Enter your OpenAI API Key"
}

if ([string]::IsNullOrEmpty($ApiKey)) {
    Write-Error "OpenAI API Key is required to run the application."
    exit 1
}

$env:SPRING_AI_OPENAI_API_KEY = $ApiKey

Write-Host "Starting Spring Boot Backend..."
Start-Process -FilePath ".\spring-boot-ai-chatbot\mvnw.cmd" -ArgumentList "spring-boot:run" -WorkingDirectory ".\spring-boot-ai-chatbot" -Environment @{ "SPRING_AI_OPENAI_API_KEY" = $ApiKey }

Write-Host "Starting React Frontend..."
Start-Process -FilePath "npm.cmd" -ArgumentList "start" -WorkingDirectory ".\chatbot-ui"

Write-Host "Application is starting..."
Write-Host "Backend will be at http://localhost:8080"
Write-Host "Frontend will be at http://localhost:3000"
