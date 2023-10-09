import requests
import sys

# Define the URL of your website
website_url = "https://stg-yuriipavlovtest-staging.kinsta.cloud/"

try:
    # Send an HTTP GET request to the website
    response = requests.get(website_url)

    # Check if the response status code is 200 (OK)
    if response.status_code == 200:
        print(f"Success: {website_url} returned a 200 OK status code.")
    else:
        print(f"Failure: {website_url} returned a {response.status_code} status code.")
        sys.exit(1)  # Exit with a non-zero status code to indicate failure

except Exception as e:
    # Handle any exceptions that may occur during the request
    print(f"An error occurred: {str(e)}")
    sys.exit(1)  # Exit with a non-zero status code to indicate failure
