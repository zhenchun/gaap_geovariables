
  require(dplyr)
  
  
  
load("9.6_geocovars_site55.Rdata")
g55<-geocovars
g55<-g55[, 9:293]

load("geocovars_1km_v9.6_NOosm.Rdata")

g7000<-geocovars
g7000<-g7000[, 9:289]

idx<-match(colnames(g55), colnames(g7000))

g7000_reorder<-g7000[, idx[1:272]]

g55_max<-apply(g55,2,max)  
 
g55_min<-apply(g55,2,min)  

