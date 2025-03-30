@echo off
REM IRIS API Client Batch File
REM Usage: iris_api_client.bat [--output filename.md] [--pretty]

set URL=https://yoururl.com
set TOKEN=YOU TOKEN
set OUTPUT=iris_cases.md

if "%1"=="--pretty" (
    python iris_api_client.py --url %URL% --token %TOKEN% --pretty
) else if "%1"=="--output" (
    if not "%2"=="" (
        python iris_api_client.py --url %URL% --token %TOKEN% --output %2
    ) else (
        echo Error: Missing output filename
        echo Usage: iris_api_client.bat [--output filename.md] [--pretty]
    )
) else (
    python iris_api_client.py --url %URL% --token %TOKEN% --output %OUTPUT%
)
