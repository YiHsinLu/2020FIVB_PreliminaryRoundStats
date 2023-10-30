# 2020FIVB_PreliminaryRoundStats
The data is from Kaggle and the statistics for the preliminary round of 2020 FIVB (Fédération Internationale de Volleyball). Then I want to know more about the relationship between players and their information or statistics.

## Team Japan
My favorite team in FIVB.

![](https://asianvolleyball.net/new/wp-content/uploads/2023/07/aaaa.jpeg)
[image from](https://asianvolleyball.net/new/japan-beat-world-champions-italy-and-make-it-to-the-vnl-podium/)

## 1 Data
### 1.1 Kaggle
* [Kaggle: FIBV - 2020 - Statistics - Preliminary Round](https://www.kaggle.com/datasets/victorvincifantucci/fibv-2020-statistics-preliminary-round/data)
* Latest FIBV statistics about the international volleyball scenario.

****

* You can also download this repository and then read the `.csv` file I cleaned on Rstudio.

```{r}
read.csv("DataFrame/Players_stats2020.csv")
```

However, the problem is that we only have the statistics of players' behavior, and the dataset doesn't store the personal information of players such as position, height, weight, etc. 

****

### 1.2 VolleyBox
* [VolleyBox](https://volleybox.net/)
  + Players' personal information
  + You can also download this repository and then read the `.csv` file I cleaned on Rstudio.

```{r}
read.csv("DataFrame/Player_infoVolleybox2023.csv")
```

* Volleyball players' Facebook, and social media.
* but no "API"
* difficulty: we couldn't use the names of players to find their page on VolleyBox.

#### Step1. Use the Google search engine to collect their URL 
```{r}
plr = #players name 
url = paste0("https://www.google.com/search?q=Volleybox+", gsub(" ", "+", plr))
page = read_html(url)
  
links = page %>%
  html_nodes("a") %>% # get the a nodes with an r class
  html_attr("href")
  
link = gsub('/url\\?q=','',sapply(strsplit(links[as.vector(grep('url',links))],split='&'),'[',1))
link_volbox = Filter(function(u) any(grepl("https://volleybox.net/",u), grepl("-p",u), grepl("/clubs",u)), link)
plr_link = link_volbox

```
#### Step2. Collect their info.
The point is that you need to find the information position on the webpage. (press `F12` to check the HTML) In my project, the position, height, weight, birth, spike, block, and dominant hand is in `<dd class='info-data marginBottom10  '>`, so I use Xpath to find them.
```{r}
page = read_html(plr_link)

player_info = page %>%
  html_elements(xpath = "//*[@class = 'info-data marginBottom10  ']") %>%
  html_text()
```

However, if you want to collect many pages just like me, then you must **be careful** about the time between two `read_html`. If you connect the url too many times, the webpage server will block you out and your code will return "Error in open.connection(x, "rb") : HTTP error 429." I utilize `Sys.sleep` function to control the times between the connections.

```{r}
Sys.sleep(1) #pause for 1 second
```
And I use random variables for the time.
```{r}
Sys.sleep(runif(1,5,15))
```

