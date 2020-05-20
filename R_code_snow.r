# R_code_snow.r

setwd("~/lab/")
# setwd("/Users/utente/lab") #mac
# setwd("C:/lab/") # windows

# install.packages("ncdf4")
library(ncdf4)
library(raster)

snowmay <- raster("c_gls_SCE500_202005180000_CEURO_MODIS_V1.0.1.nc")
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100) 

# Exercise: plot snow cover with the cl palette
plot(snowmay,col=cl)

##### import snow data

setwd("~/lab/snow")
# setwd("/Users/utente/lab/snow") #mac
# setwd("C:/lab/snow") # windows

# snow2000r <- raster("snow2000r.tif")

# lapply() example with NO2 data

# rlist=list.files(pattern=".png", full.names=T)

##save raster into list
##con lappy
# list_rast=lapply(rlist, raster)
# EN <- stack(list_rast)
# plot(EN)

rlist <- list.files(pattern=".tif")
rlist 

#save raster into list
#con lappy
list_rast <- lapply(rlist, raster)
snow.multitemp <- stack(list_rast)
plot(snow.multitemp,col=cl)

par(mfrow=c(1,2))
plot(snow.multitemp$snow2000r, col=cl)
plot(snow.multitemp$snow2020r, col=cl)

par(mfrow=c(1,2))
plot(snow.multitemp$snow2000r, col=cl, zlim=c(0,250))
plot(snow.multitemp$snow2020r, col=cl, zlim=c(0,250))

difsnow = snow.multitemp$snow2020r - snow.multitemp$snow2000r
cldiff <- colorRampPalette(c('blue','white','red'))(100) 
plot(difsnow, col=cldiff)

# prediction
# go to IOL and downloand prediction.r into the folder snow
# source("prediction.r")
# plot(predicted.snow.2025.norm, col=cl)
# since the code needs time, you can ddownload predicted.snow.2025.norm.tif from iol in the Data

predicted.snow.2025.norm <- raster("predicted.snow.2025.norm.tif")
plot(predicted.snow.2025.norm, col=cl)



