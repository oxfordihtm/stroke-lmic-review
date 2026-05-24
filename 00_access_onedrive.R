# Access Microsoft One Drive files ---------------------------------------------

## Setup Microsoft 365 access ----
## NOTE: when running the following line for the first time, user will need to
## authenticate with Microsoft via Oxford SSO on a browser that will open.
## After initial authentication, the package stores tokens securely in the
## background and checks every time this line is run if the token is still
## active. If token is expired, it will refresh this token. Usually, no further
## authentication is needed.
onedrive <- Microsoft365R::get_business_onedrive()
onedrive_shared_files <- onedrive$list_shared_files()    ## List shared files
onedrive_files <- onedrive$list_items()

## Download contents of One Drive stroke-lmic-review folder ----
onedrive$download_folder(src = "stroke-lmic-review", dest = "data-raw")
