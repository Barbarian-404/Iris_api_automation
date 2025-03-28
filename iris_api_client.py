#!/usr/bin/env python3
import requests
import json
import argparse
import urllib3
import os

# Disable warnings about insecure requests (ignoring SSL certificate validation)
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

def get_cases(url, token, output_file=None, pretty=False):
    """
    Fetch cases from the IRIS API
    
    Args:
        url (str): The API URL
        token (str): The authentication token
        output_file (str): Path to the output markdown file
        pretty (bool): Whether to display the full JSON in a pretty format
        
    Returns:
        None
    """
    headers = {
        "Authorization": f"Bearer {token}",
        "Content-Type": "application/json"
    }
    
    try:
        # Make the request, ignoring SSL certificate validation
        response = requests.get(url, headers=headers, verify=False)
        
        # Check if the request was successful
        response.raise_for_status()
        
        # Parse the JSON response
        data = response.json()
        
        if pretty:
            # Display the full JSON in a pretty format
            print(json.dumps(data, indent=4))
        else:
            # Extract only the case name and case description
            cases = data.get('data', [])
            if cases:
                # Create markdown content
                md_content = "# IRIS Cases\n\n"
                for case in cases:
                    case_name = case.get('case_name', 'N/A')
                    case_description = case.get('case_description', 'N/A')
                    md_content += f"## {case_name}\n\n{case_description}\n\n"
                
                # Write to file or print to console
                if output_file:
                    with open(output_file, 'w') as f:
                        f.write(md_content)
                    print(f"Case information written to {output_file}")
                else:
                    print(md_content)
            else:
                print("No cases found.")
    
    except requests.exceptions.RequestException as e:
        print(f"Error making request: {e}")
    except json.JSONDecodeError:
        print("Error parsing JSON response")
    except Exception as e:
        print(f"An unexpected error occurred: {e}")

def main():
    parser = argparse.ArgumentParser(description='Fetch cases from the IRIS API')
    parser.add_argument('--url', default='https://iris.westeros.cpt/manage/cases/list?cid=1',
                        help='The API URL (default: https://iris.westeros.cpt/manage/cases/list?cid=1)')
    parser.add_argument('--token', required=True,
                        help='The authentication token')
    parser.add_argument('--output', default='iris_cases.md',
                        help='Output markdown file (default: iris_cases.md)')
    parser.add_argument('--pretty', action='store_true',
                        help='Display the full JSON in a pretty format')
    
    args = parser.parse_args()
    
    get_cases(args.url, args.token, args.output, args.pretty)

if __name__ == '__main__':
    main()
