
library(stringr)
library(dplyr)
library()



cold<-as.data.frame(aod2012[,1])

warm<-as.data.frame(aod2012[,1])

w<-list()

s<-list()


for (i in 1:6){
  
  w<-aod2012[,grepl(winter[i], names(aod2012))]
  cold<-cbind(cold,w)
  
  s<-aod2012[,grepl(summer[i], names(aod2012))]
  warm<-cbind(warm, s)
  
  
  }


warm<-warm[-1,]
cold<-cold[-1,]


warm$mean<-rowMeans(warm[,-1], na.rm = TRUE)
cold$mean<-rowMeans(cold[,-1], na.rm = TRUE)


a12<-aod2012[,c(1,282:647)]
a12$mean<-rowMeans(a12[,-1], na.rm = TRUE)

aod_sh_2012<-cbind(warm$field_1, warm$mean, cold$mean, a12$mean)
colnames(aod_sh_2012)<-c("id", "aod_2012s", "aod_2012w", "aod_2012_total")



#############################################################################
############################select variables################################
############################################################################
library(stringr)
library(dplyr)

geo<-as.data.frame(my.region[9])

coln<-str_sub(colnames(geo), 8)

colnames(geo)<-coln



for(i in 277:287){
  colnames(geocovars)[i]<-paste("log", colnames(geocovars)[i] , sep="_")
  
}

colnames(geocovars)[277:287]

colnames(geocovars)[284]<-"log_m_to_huangpu.river"
colnames(geocovars)[285]<-"log_m_to_road_ferry.route"


geocovars_sel<-geocovars %>% select(colnames(geo))

for (i in 1:11){
  
  geocovars_sel[i]<- log(geocovars_sel[i])
}

#########################################################################################

geo$type<-"sites"

geocovars_sel$type<-"points"

compr<-rbind(geo, geocovars_sel)


mean<-compr %>% 
  group_by(type) %>% 
  summarise(across(.cols = everything(),~mean(.x, na.rm = TRUE)))
mean$summr<-"mean"

max<-compr %>% 
  group_by(type) %>% 
  summarise(across(.cols = everything(),~max(.x, na.rm = TRUE)))
max$summr<-"max"

min<-compr %>% 
  group_by(type) %>% 
  summarise(across(.cols = everything(),~min(.x, na.rm = TRUE)))
min$summr<-"min"


compare<-rbind(mean, max, min)

compare<-compare[, c(1,142,2:141)]


write.csv(compare, "compare.csv")


