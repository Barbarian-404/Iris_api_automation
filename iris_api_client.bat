@echo off
REM IRIS API Client Batch File
REM Usage: iris_api_client.bat [--output filename.md] [--pretty]

set URL=https://iris.westeros.cpt/manage/cases/list?cid=1
set TOKEN=Y9hT6f60qEMnFxmyLzZBI0YidRIEiEa_tKiy8ADrYb2rFvhcS9GwBApRXMQuuHVLFq_p2gnU62vAD_Uy2JsLjA
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
