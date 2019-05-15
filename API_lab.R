## What libraries do we need to load? 
library(httr)
library(jsonlite)
## Source in your hidden api-keys.R file
source("keys.R")

##  Let's construct the API call.
base_uri <- "https://www.googleapis.com/civicinfo/v2"

resource <- "/representative"

query_params <- list(
  key = api_key, address = "185 E stevens Way NE, Seattle, WA 98195"
)  

address <- query_params[["address"]]

response <- GET(paste0(base_uri, resource), query = query_params)

response_content <- content(reponse, "text")

parsed_data <- fromJSON(response_content)

## Yay! Now we should have our data. Let's View(parsed_data) to see what we have to work with.


## Let's try out some fun data wrangling questions!
# Concatenate the full address of what you passed into the API call (as if we were writing it to mail a letter)

# Here's a challenge... can you find the ratio of officials in the Democratic Party to officials in the Republican Party?

