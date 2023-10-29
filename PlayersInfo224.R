#224 players info.

# create a new emviroment
load("C:/_YiHsin/DataAnalysis/FIBV_2020_Statistics_PreliminaryRound/2020FIVB_PreliminaryRoundStats/player_info.RData")
#drop the players who have missing value
plr_info_lst = plr_info_lst[-plr_id_uncom]
plr_links = as.matrix(plr_links[-plr_id_uncom,1])
plr_name = plr_name[-plr_id_uncom]


# data frame for players info.

plr_info = c()
pb <- progress_bar$new(format = "[:bar] :current/:total (:percent)", total = 224, clear = TRUE)
new_plr_uncom =c()

for(i in 1:224){
  if(length(plr_info_lst[[i]])==12){
    plr_info = rbind(plr_info, plr_info_lst[[i]][4:10])
  }else{
    if(grepl("Outside Hitter",plr_info_lst[[i]][3])==TRUE||grepl("Opposite",plr_info_lst[[i]][3])==TRUE||grepl("Setter",plr_info_lst[[i]][3])==TRUE||grepl("Middle-blocker",plr_info_lst[[i]][3])==TRUE){
      plr_info = rbind(plr_info, plr_info_lst[[i]][3:9])
    }else if(grepl("Outside Hitter",plr_info_lst[[i]][4])==TRUE||grepl("Opposite",plr_info_lst[[i]][4])==TRUE||grepl("Setter",plr_info_lst[[i]][4])==TRUE||grepl("Middle-blocker",plr_info_lst[[i]][4])==TRUE){
      plr_info = rbind(plr_info, plr_info_lst[[i]][4:10])
    }else{
      plr_info = rbind(plr_info, plr_info_lst[[i]][4:10])
      new_plr_uncom = rbind(new_plr_uncom,i)
    }
  } 
  pb$tick()
}


new_plr_uncom = as.vector(new_plr_uncom)
#Outside Hitter, Opposite, Setter, Middle-blocker

#fix the language problem
plr_info[new_plr_uncom[1],1] = "Middle-blocker"
plr_info[new_plr_uncom[2],1] = "Opposite"
plr_info[new_plr_uncom[3],1] = "Opposite"
plr_info[new_plr_uncom[4],1] = "Outside Hitter"
plr_info[new_plr_uncom[5],1] = "Setter"
plr_info[new_plr_uncom[6],1] = "Outside Hitter"

plr_info[167,1] = "Setter"

# there is one player that hide his birth

plr_info[205,7] = plr_info[205,6]
plr_info[205,6] = plr_info[205,5]
plr_info[205,5] = plr_info[205,4]
plr_info[205,4] = plr_info[205,3]
plr_info[205,3] = plr_info[205,2]
plr_info[205,2] = "1997-09-24"
# data frame
plr_info = as.data.frame(plr_info)
colnames(plr_info) = c("Position", "Birth", "Height", "Weight", "Spike", "Block", "Dominant_hand")
