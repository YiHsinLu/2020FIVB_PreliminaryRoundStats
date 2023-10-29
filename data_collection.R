install.packages("rvest")
library(rvest)

url <- "https://volleybox.net/players"
page <- read_html(url)
# Extract player names
names <- page %>% html_nodes(".playersListRow .name") %>% html_text()

# Extract player nationalities
nationalities <- page %>% html_nodes(".playersListRow .country") %>% html_text()
player_data <- data.frame(Name = names, Nationality = nationalities)
print(player_data)


# Load the required packages
library(rvest)

# Define the URL of the page you want to scrape
url <- "https://volleybox.net/players"

# Send an HTTP GET request to the URL and parse the HTML content
page <- read_html(url)

# Extract player data from the page, filtering by nationality (Japan)
player_data <- page %>%
  html_nodes(".playersListRow") %>%
  html_nodes(".country") %>%
  html_text() %>%
  data.frame(Name = page %>% html_nodes(".name") %>% html_text(),
             Nationality = .)

# Filter the player data to include only players from Japan
japan_players <- player_data[player_data$Nationality == "Japan", ]

# Print or manipulate the scraped data for Japanese players as needed
print(japan_players)

# Load the required packages
library(rvest)

# Define the URL of the page you want to scrape
url <- "https://volleybox.net/players"

# Send an HTTP GET request to the URL and parse the HTML content
page <- read_html(url)

# Extract player data from the page, filtering by nationality (Japan)
player_data <- page %>%
  html_nodes(".playersListRow") %>%
  html_attr("data-original-title")

# Filter the player data to include only players from Japan
japan_players <- player_data[grep("Nationality: Japan", player_data)]

# Print or manipulate the scraped data for Japanese players as needed
print(japan_players)


# Load the required packages
library(rvest)

# Define the URL of the specific player
player_url <- "https://volleybox.net/yuji-nishida-p11693"

# Send an HTTP GET request to the player's URL and parse the HTML content
page <- read_html(player_url)

# Extract player data from the page
player_data <- page %>%
  html_nodes(".playerInfo") %>%
  html_text()

# Print or manipulate the scraped data for the specific player as needed
cat(player_data)


# Load the required packages
library(rvest)

# Function to scrape player information
scrape_player_info <- function(player_name) {
  # Construct the player's URL
  player_url <- paste0("https://volleybox.net/players", tolower(gsub(" ", "-", player_name)), "-p11693")
  
  # Send an HTTP GET request to the player's URL and parse the HTML content
  page <- read_html(player_url)
  
  # Extract player data from the page
  player_info <- page %>%
    html_nodes(".playersBox .list-group-item") %>%
    html_text()
  
  # Extract position, height, weight, spike, and block from player_info
  position <- player_info[grep("Position:", player_info)]
  height <- player_info[grep("Height:", player_info)]
  weight <- player_info[grep("Weight:", player_info)]
  spike <- player_info[grep("Spike:", player_info)]
  block <- player_info[grep("Block:", player_info)]
  
  # Create a data frame for the player's information
  player_data <- data.frame(
    Name = player_name,
    Position = gsub("Position:", "", position),
    Height = gsub("Height:", "", height),
    Weight = gsub("Weight:", "", weight),
    Spike = gsub("Spike:", "", spike),
    Block = gsub("Block:", "", block)
  )
  
  return(player_data)
}

# Specify the player you want to collect data for (e.g., "Yuji Nishida")
player_name <- "Yuji Nishida"

# Scrape data for the specified player
player_data <- scrape_player_info(player_name)

# Print the scraped data
print(player_data)


# Install and load the rvest package if you haven't already
install.packages("rvest")
library(rvest)

# Define the URL of the webpage you want to scrape
url <- "https://volleybox.net/players"

# Send an HTTP GET request to the URL and parse the HTML
page <- read_html(url)

# Find the player profiles for Yuji Nishida and Yuki Ishikawa
nishida_profile <- page %>% html_node(xpath = '//*[@data-original-title="Yuji Nishida"]')
ishikawa_profile <- page %>% html_node(xpath = '//*[@data-original-title="Yuki Ishikawa"]')

if (!is.na(nishida_profile) && !is.na(ishikawa_profile)) {
  # Extract the data for Yuji Nishida
  nishida_position <- nishida_profile %>% html_node(".position") %>% html_text()
  nishida_height <- nishida_profile %>% html_node(".height") %>% html_text()
  nishida_weight <- nishida_profile %>% html_node(".weight") %>% html_text()
  nishida_spike <- nishida_profile %>% html_node(".attack") %>% html_text()
  nishida_block <- nishida_profile %>% html_node(".block") %>% html_text()
  
  # Extract the data for Yuki Ishikawa
  ishikawa_position <- ishikawa_profile %>% html_node(".position") %>% html_text()
  ishikawa_height <- ishikawa_profile %>% html_node(".height") %>% html_text()
  ishikawa_weight <- ishikawa_profile %>% html_node(".weight") %>% html_text()
  ishikawa_spike <- ishikawa_profile %>% html_node(".attack") %>% html_text()
  ishikawa_block <- ishikawa_profile %>% html_node(".block") %>% html_text()
  
  # Print the extracted data
  cat("Yuji Nishida:\n")
  cat(paste("Position: ", nishida_position, "\n", sep = ""))
  cat(paste("Height: ", nishida_height, "\n", sep = ""))
  cat(paste("Weight: ", nishida_weight, "\n", sep = ""))
  cat(paste("Spike: ", nishida_spike, "\n", sep = ""))
  cat(paste("Block: ", nishida_block, "\n", sep = ""))
  
  cat("\nYuki Ishikawa:\n")
  cat(paste("Position: ", ishikawa_position, "\n", sep = ""))
  cat(paste("Height: ", ishikawa_height, "\n", sep = ""))
  cat(paste("Weight: ", ishikawa_weight, "\n", sep = ""))
  cat(paste("Spike: ", ishikawa_spike, "\n", sep = ""))
  cat(paste("Block: ", ishikawa_block, "\n", sep = ""))
} else {
  cat("Player profiles not found on the page")
}

library(tidyverse)
library(Rcrawler)
Rcrawler(Website = "https://volleybox.net",
         crawlUrlfilter = "/yuji-nishida-p11693",
         no_cores = 4,
         no_conn = 4,
         MaxDepth = 1,
         saveOnDisk = FALSE)



#################################

ContentScraper(Url = "https://volleybox.net/yuji-nishida-p11693",
               XpathPatterns = c("//div[@class = 'profile-left']/div/d1/dt[1,1]"))



# Load the Rcrawler package
library(Rcrawler)

# Define the URL of the webpage you want to scrape
start_url <- "https://volleybox.net/players"

# Create a configuration for Rcrawler
config1 <- list(
  ContentScraper = list(
    item = list(
      Title = list(Selectors = "h1[itemprop='name']", Type = "text"),
      Profile_URL = list(Selectors = "a:contains('View profile')", Type = "href")
    )
  )
)

# Run the Rcrawler function
scraped_data <- Rcrawler(start_url,
                         no_cores = 4,
                         MaxDepth = 1)

# Extract the collected data
player_names <- scraped_data$ContentScraper$Title
player_urls <- scraped_data$ContentScraper$Profile_URL

# Print the extracted data
print(player_names)
print(player_urls)


library(rvest)
library(tidyverse)
library(dplyr)

ContentScraper(Url = "https://volleybox.net",
               XpathPatterns = "/yuji-nishida")

Rcrawler(Website = "https://volleybox.net",
         crawlUrlfilter = "",
         no_cores = 4,
         no_conn = 4,
         MaxDepth = 1,
         saveOnDisk = FALSE)

url = "https://volleybox.net/-p11693"
url = "https://volleybox.net/yuki-ishikawa-p705"
page = read_html(url)

player_info = page %>%
  html_elements(xpath = "//*[@class = 'info-data marginBottom10  ']") %>%
  html_text()

lappend <- function (lst, ...){
  lst <- c(lst, list(...))
  return(lst)
}

url_players ="https://volleybox.net/players"
page_players = read_html(url_players)

playerurl_list = page_players%>%
  html_elements(xpath = "//*[@id = 'player_list_container']") %>%
  html_text()


playerurl_list = page_players%>%
  html_nodes(".pRelative")


url = paste0("https://www.google.com/search?q=Volleybox+", gsub(" ", "+", "Micah Christenson"))
page = read_html(url)

links = page %>%
  html_nodes("a") %>% # get the a nodes with an r class
  html_attr("href")

#clean the text  
links = gsub('/url\\?q=','',sapply(strsplit(links[as.vector(grep('url',links))],split='&'),'[',1))

intersect(links, "https://volleybox.net")

links[1]# as a dataframe
websites <- data.frame(links = links, stringsAsFactors = FALSE)
View(websites)

Filter(function(u) any("https://volleybox.net" %in% u), links[3])


Filter(function(u) any(grepl("https://volleybox.net/",u), grepl("/clubs",u)), links)

#============================================================================================================================
#Start with the list of volleyball players in our data set
load("C:/_YiHsin/DataAnalysis/FIBV_2020_Statistics_PreliminaryRound/2020FIVB_PreliminaryRoundStats/players_AttScoSer.RData")

library(progress)
library(rvest)
library(dplyr)
library(tidyverse)
library(Rcrawler)

#then we search on Google searching engine to find their links of Volleybox

pb <- progress_bar$new(format = "[:bar] :current/:total (:percent)", total = 69, clear = TRUE)

for(plr in plr_name[181:250]){
  url = paste0("https://www.google.com/search?q=Volleybox+", gsub(" ", "+", plr))
  page = read_html(url)
  
  links = page %>%
    html_nodes("a") %>% # get the a nodes with an r class
    html_attr("href")
  
  #clean the text  
  link = gsub('/url\\?q=','',sapply(strsplit(links[as.vector(grep('url',links))],split='&'),'[',1))
  link_volbox = Filter(function(u) any(grepl("https://volleybox.net/",u), grepl("-p",u)), link)
  plr_links = rbind(plr_links, link_volbox[1])
  
  pb$tick()
  Sys.sleep(runif(1,5,15))
}

 for(plr in plr_name){
  pb$tick(1)
  Sys.sleep(1)
}


#========================================================

# there are few missing value of players

missing_plr = c()

a = 0
for(i in 1:250){
  if(grepl("https://volleybox.net/", plr_links[i,1])==FALSE){
    plr_miss = c(i, plr_name[i], plr_links[i,1])
    missing_plr = rbind(missing_plr, plr_miss)
  }
}


plr_links[241,1] = "https://volleybox.net/micah-christenson-p1244/clubs"

#players id that have missing values
missing_plr= as.data.frame(missing_plr)
missing_plr$V1
#========================================================
#Solve the Error: 429

for(plr in plr_name[29:250]){
  loc = paste0("https://www.google.com/search?q=Volleybox+", gsub(" ", "+", plr))
  pas = des=paste("C:/_YiHsin/DataAnalysis/FIBV_2020_Statistics_PreliminaryRound/2020FIVB_PreliminaryRoundStats",plr,".html",sep="")
  download.file(loc, pas)
  pb$tick()
  Sys.sleep(runif(1,5,10))
}

#=======================================================
#function of conbinding for lists
lappend <- function (lst, ...){
  lst <- c(lst, list(...))
  return(lst)
}
#=======================================================
#Final step: Collect the info of players by their linkson their volleybox page

#testing the system for YukiIshikawa and Yuji Nishida

plr_info_lst = list()

url_14 = plr_links[14,1]
url_1 = plr_links[1,1]

page_14 = read_html(url_14)
page_1 = read_html(url_1)

player_info14 = page_14 %>%
  html_elements(xpath = "//*[@class = 'info-data marginBottom10  ']") %>%
  html_text()

plr_info_lst = lappend(plr_info_lst, player_info14)

player_info1 = page_1 %>%
  html_elements(xpath = "//*[@class = 'info-data marginBottom10  ']") %>%
  html_text()

plr_info_lst = lappend(plr_info_lst, player_info1)


#============================================================================
#start

library(progress)
library(rvest)
library(dplyr)
library(tidyverse)
library(Rcrawler)

plr_info_lst = list()
url = 0
pb <- progress_bar$new(format = "[:bar] :current/:total (:percent)", total = 250, clear = TRUE)

for (p in 1:250){
  url = plr_links[p,1]
  if(grepl("https://volleybox.net/", url)==TRUE){
    page = read_html(url)
    plr_info = page %>%
      html_elements(xpath = "//*[@class = 'info-data marginBottom10  ']") %>%
      html_text()
    Sys.sleep(runif(1,5,15))
  }else{
    plr_info = c()
    Sys.sleep(60)
  }
  plr_info_lst = lappend(plr_info_lst, plr_info)
  url = NA
  page = NA
  pb$tick()
  Sys.sleep(runif(1,5,15))
}

#=========================================================================

# Clean dataset
# complete parts of data

#take id of players who have missing values
plr_id_uncom = c()
for(i in 1:250){
  if(length(plr_info_lst[[i]])<10){
    print(c(i, plr_name[i]))
    plr_id_uncom= rbind(plr_id_uncom, i)
  }
}

#========================================================================
#finally, this time we select 224 players in the world


