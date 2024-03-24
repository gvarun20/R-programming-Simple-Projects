rm(list=ls())  # removes all objects from the current workspace (R memory)
library(twitteR)
library(ROAuth)
library(RCurl)
library(httr)

CUSTOMER_KEY <- "fiKIjQoXQOxYvpwvvKimvaDgT"
CUSTOMER_SECRET <- "0Eynt3assMeJtyPONrkxb06siFOnnqBthsRdn1KslbM6KLDW2j"
ACCESS_TOKEN <- "619329845-oFty3GxjbYzUcn03amV3YEDAh5CyCSfnxOYtgfUj"
ACCESS_secret <- "TdISppuktmIKFI4PpCwOirn7v880RntflCXND7OiHxuZ6"
#setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)

setup_twitter_oauth(CUSTOMER_KEY, CUSTOMER_SECRET, ACCESS_TOKEN, ACCESS_secret)

mytweets <- searchTwitter("#Darbar",lang="en",n=100)

length(mytweets)
mytweets <- strip_retweets(mytweets)
length(mytweets)

tweets_df = twListToDF(mytweets)

write.csv(tweets_df, file='crypto1.csv', row.names=F)
