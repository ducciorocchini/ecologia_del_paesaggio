# R code analisi multitemporale di variazione della land cover

setwd("~/lab/")
# setwd("/Users/utente/lab") #mac
# setwd("C:/lab/") # windows

library(raster)
# install.packages("RStoolbox")
library(RStoolbox)

defor1 <- brick("defor1_.jpg") # .png for Mac
defor2 <- brick("defor2_.jpg")

defor1
# names: defor1_.1, defor1_.2, defor1_.3 
# defor1_.1 = NIR
# defor1_.2 = red
# defor1_.3 = green

plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")

# Exercise plot della seconda data
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

# classificazione non supervisionata
d1c <- unsuperClass(defor1, nClasses=2)

plot(d1c$map)
cl <- colorRampPalette(c('black','green'))(100) # 
plot(d1c$map, col=cl)

# possibilità 2
cl <- colorRampPalette(c('green','black'))(100) # 
plot(d1c$map, col=cl)

# esempio sul significato del $
# mappageologica <- geomap(im_sat,nClasses=....)
# plot(mappageologica$lito)
# plot(mappageologica$lineaments)

# classificazione di defor2
# Exercise: classificare con due classi l'immagine satellitare defor2
d2c <- unsuperClass(defor2, nClasses=2)
plot(d2c$map, col=cl)

# plot delle due mappe ottenute
par(mfrow=c(2,1))
plot(d1c$map, col=cl)
plot(d2c$map, col=cl)

par(mfrow=c(1,2))
plot(d1c$map, col=cl)
plot(d2c$map, col=cl)

freq(d1c$map)
# aree aperte = 37039
# foresta = 304253

totd1 <- 37039 + 304253
totd1
# 341292

percent1 <- freq(d1c$map) * 100 / totd1

# percentuali
# foreste: 89.1
# aree aperte: 10.9

#---- 

freq(d2c$map)
# aree aperte: 165055
# foreste: 177671

totd2 <- 165055 + 177671
totd2
# 342726

percent2 <- freq(d2c$map) * 100 / totd2

# percent
# aree aperte: 48.2
# foreste: 51.8

#-----

cover <- c("Agriculture","Forest")
before <- c(10.9,89.1)
after <- c(48.2,51.8)

output <- data.frame(cover,before,after)
output


# library(ggplot2)
# p1<-ggplot(output, aes(x=cover, y=before, color=cover)) + geom_bar(stat="identity", fill="white")
# 
# p2<-ggplot(output, aes(x=cover, y=after, color=cover)) + geom_bar(stat="identity", fill="white")

# https://cran.r-project.org/web/packages/egg/vignettes/Ecosystem.html
# install.packages("gridExtra")
# library(gridExtra)

# grid.arrange(p1, p2, nrow = 1) # this needs griExtra

########## day 2
setwd("~/lab/")
# setwd("/Users/utente/lab") #mac
# setwd("C:/lab/") # windows

load("defor.RData")

ls()

par(mfrow=c(1,2))
cl <- colorRampPalette(c('black','green'))(100) # 
plot(d1c$map, col=cl)
plot(d2c$map, col=cl)

#install.packages("ggplot2")
library(ggplot2)
# histograms of the % cover before deforestation
ggplot(output, aes(x=cover, y=before, color=cover)) + 
geom_bar(stat="identity", fill="white")

# Exercise: plot the histograms of the land cover after deforestation
ggplot(output, aes(x=cover, y=after, color=cover)) + 
geom_bar(stat="identity", fill="white")

install.packages("gridExtra")
library(gridExtra) # oppure: require(Extra)

# grid.arrange(plot1, plot2, nrow = 1) # this needs griExtra

grafico1 <- ggplot(output, aes(x=cover, y=before, color=cover)) + 
geom_bar(stat="identity", fill="white")+
ylim(0, 100)

grafico2 <- ggplot(output, aes(x=cover, y=after, color=cover)) + 
geom_bar(stat="identity", fill="white")+
ylim(0, 100)

# Exercise: use grid.arrange to plot the two graphs 
grid.arrange(grafico1, grafico2, nrow = 1)



