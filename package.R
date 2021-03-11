for (i in 1:247){
  
  require(package[i,1])
}

library(package[,1])


lapply(package[,1], require, character.only = TRUE)

install.packages("XLConnect","rJava", "raster", "spData", "spdep")
