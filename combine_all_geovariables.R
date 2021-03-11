#install.packages("RPostgreSQL")
require("RPostgreSQL")
#this completes installing packages
#now start creating connection
con<-dbConnect(dbDriver("PostgreSQL"), dbname="gaap", host="localhost", port=5432, user="postgres",password="123")
#this completes creating connection
#get all the tables from connection
dbListTables(con)

tables<-list()

for (i in 1:215){

tables[[i]]<-dbGetQuery(con, paste("SELECT * from", dbListTables(con)[i]))

}

names(tables)<-dbListTables(con)


nam<-colnames(geocovars)[10:263]

write.csv(nam, "nam.csv")

list2env(tables,envir=.GlobalEnv)

####nam1 was editted in the sequence of geocovars following the order of Carol's file 
####and loaded into the environment

nam1<-as.data.frame(nam1)
geocovars_name<-c(nam1[,2])

DF_obj <- lapply(geocovars_name, get)

mergefun <- function(x, y) merge(x, y, by= "id")
merged_DF <- Reduce(mergefun, DF_obj )

######all surface area was exculded below
geo_covars<-merged_DF[,-c(176,185,194,203,212,221,230,239,248,257)]

colnames(geo_covars)<-c("id", nam)
write.csv(geo_covars, "geo_covars.csv")
