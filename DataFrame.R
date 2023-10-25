
library(dplyr)
library(tidyverse)
library(Rtsne)
library(plotly)



vol_plrs_a = read.csv('Men_Statistics/men_best_attackers.csv')
vol_plrs_blk = read.csv('Men_Statistics/men_best_blockers.csv')
vol_plrs_ser = read.csv('Men_Statistics/men_best_servers.csv')
vol_plr_sco = read.csv('Men_Statistics/men_best_scores.csv')
vol_plr_res = read.csv('Men_Statistics/men_best_recievers.csv')
vol_plr_dig = read.csv('Men_Statistics/men_best_diggers.csv')



plr_name = intersect(intersect(vol_plrs_a$Name, vol_plr_sco$Name), vol_plrs_ser$Name)
vol_plrs_ser[is.na(vol_plrs_ser)]=0




best_WS = list(player = vol_plrs_a[,2:4],
               attack = vol_plrs_a[,-c(1,8,9)],
               serve = vol_plrs_ser[,-1],
               block = vol_plrs_blk[,-c(1,8)],
               dig = vol_plr_dig[,-c(1,8)],
               score = vol_plr_sco[,-c(1,5:7)])


best_WS_data = best_WS %>% reduce(full_join, by=c('ShirtNumber', 'Name', 'Team'))

best_WS_data[is.na(best_WS_data)]=0



best_WS_dataScale = as.data.frame(cbind(best_WS_data[,1:3],scale(as.matrix(best_WS_data[,4:20]))))


# First map


set.seed(19970608)
tsneVol = Rtsne(best_WS_dataScale[,-c(1:3)], check_duplicates = FALSE)

visualtsneFIVB = as.data.frame(cbind(tsneVol$Y, best_WS_data$Team))
colnames(visualtsneFIVB) = c("V1","V2","Team")

visualtsneFIVB = transform(visualtsneFIVB, V1 = as.numeric(V1), V2 = as.numeric(V2))

plot_ly(visualtsneFIVB, x = ~V1, y = ~V2, color = ~Team, text = best_WS_data$Name)



#Attack


best_WS$attack %>% mutate(percentage = round(Shots/Spikes, digits = 2))

