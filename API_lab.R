## What libraries do we need to load? 
library(httr)
library(jsonlite)

## Source in your hidden api-keys.R file
source("api-keys.R")

##  Let's construct the API call.
base_uri <- "https://www.googleapis.com/civicinfo/v2"

resource <- "/representatives"

query_params <- list(
  key = civic_info_api_key, address =
    "14 e cache la poudre st"
)

address <- query_params[["address"]]

response <- GET(paste0(base_uri, resource), query = query_params)

response_content <- content(response, "text")

parsed_data <- fromJSON(response_content)

## Yay! Now we should have our data. Let's View(parsed_data) to see what we have to work with.

## Let's try out some fun data wrangling questions!
# Concatenate the full address of what you passed into the API call (as if we were writing it to mail a letter)
address <- parsed_data$normalizedInput
addy <- paste0(address[["line1"]], "\n", address[["city"]], ", ", address[["state"]], " ", address[["zip"]])
strsplit(addy, "\n")[[1]]

# Here's a challenge... can you find the ratio of officials in the Democratic Party to officials in the Republican Party?
party <- parsed_data$officials[["party"]]
party <- table(party) # check out this Stack Overflow post: ()[https://stackoverflow.com/questions/1923273/counting-the-number-of-elements-with-the-values-of-x-in-a-vector]
num_dems <- party[names(party) == "Democratic Party"]
num_repub <- party[names(party) == "Republican Party"]
ratio <- num_dems / num_repub
