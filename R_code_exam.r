# R_code_exam.r

# Copernicus data: https://land.copernicus.vgt.vito.be/PDF/portal/Application.html

# 1. R_code_first.r	
# 2. R_code_spatial.r	
# 3. R_code_spatial2.r
# 4. R_code_point_pattern	
# 5. R_code_teleril.r	
# 6. R_code_landcover.r	
# 7. R_code_multitemp.r	
# 8. R_code_multitemp_NO2.r	
# 9. R_code_snow.r	
# 10. R_code_patches.r	
# 11. R_code_crop.r -  exam simulation. 
# 12. Species Distribution Modelling

#################################################################
#################################################################
#################################################################


### 1. R code first

# Primo codice R

# installazione pacchetti
install.packages("sp")

library(sp)

data(meuse)

meuse

head(meuse)


plot(meuse$cadmium,meuse$lead)

attach(meuse)

plot(cadmium,lead)


# grafico abbellito: colore rosso, simbolo....
plot(cadmium,lead,pch=19,cex=2,col="red")


pairs(meuse[,3:6])


#################################################################
#################################################################
#################################################################

### 2. R code spatial

# R spaziale: funzioni spaziali in Ecologia del paesaggio

install.packages("sp")

# con library() richiamiamo il pacchetto
library(sp)

# dati
data(meuse)

meuse

head(meuse)

# plot cadmium e lead

# alleghiamo il dataframe
attach(meuse)

plot(cadmium,lead,col="red",pch=19,cex=2)

# exercise: plot di copper e zinc con simbolo trinagolo (17) e colore verde
plot(copper,zinc,col="green",pch=17,cex=2)

# cambiare le etichette
plot(copper,zinc,col="green",pch=17,cex=2,xlab="rame",ylab="zinco")

# multiframe o multipanel
par(mfrow=c(1,2))
plot(cadmium,lead,col="red",pch=19,cex=2)
plot(copper,zinc,col="green",pch=17,cex=2)

# invertiamo i grafici riga/colonna in colonna/riga
par(mfrow=c(2,1))
plot(cadmium,lead,col="red",pch=19,cex=2)
plot(copper,zinc,col="green",pch=17,cex=2)

# multigrame automatico
install.packages("GGally")
library(GGally)
ggpairs(meuse[,3:6])

# Spatial!!
head(meuse)

coordinates(meuse)=~x+y
plot(meuse)

# funzione spplot per plottare i dati spazialmente
spplot(meuse,"zinc")


#################################################################
#################################################################
#################################################################


### 3. R code spatial 2

####### R spatial

install.packages("sp")

# libreria sp
library(sp)

# dati da usare
data(meuse)
head(meuse)

# coordinate del dataset
coordinates(meuse)=~x+y

# spplot dei dati di zinco
spplot(meuse,"zinc")

# Exercise: spplot dei dati di rame
head(meuse)
# un'altra possibilità per vedere i nomi delle colonne è:
names(meuse)
spplot(meuse,"copper")

# bubble
bubble(meuse,"zinc")

# Exercise: bubble del rame, colorato di rosso
bubble(meuse,"copper",col="red")

# foraminiferi (Sofia), carbon capture (Marco)
# array
foram <- c(10, 20, 35, 55, 67, 80)
carbon <- c(5, 15, 30, 70, 85, 99)
plot(foram, carbon, col="green", cex=2, pch=19)

# Dati dall'esterno sul covid-19
# cartella da creare su Windows: C:/lab, su Linux: ~/lab, su Mac: percorso/lab
setwd("~/lab") # Linux
setwd("C:/lab") # Windows
setwd("/Users/nome_utente/Desktop/lab") # Mac

# leggere la tabella
covid <- read.table("covid_agg.csv",head=TRUE)


#################################################################
#################################################################
#################################################################

### 4. R code point pattern

  # codice per analisi dei pattern legati ai punti

  install.packages("ggplot2")
  install.packages("spatstat")

  library(ggplot2) # comando alternativo require(ggplot2)
  library(spatstat)

  setwd("~/lab")
  # setwd("/Users/utente/lab") #mac
  # setwd("C:/lab/") # windows

  # importare dati
  covid <- read.table("covid_agg.csv", head=T)

  head(covid)

  plot(covid$country,covid$cases) 
  # attach(covid) 
  # plot(country,cases)

  plot(covid$country,covid$cases,las=0) # parallel labels
  plot(covid$country,covid$cases,las=1) # horizontal labels
  plot(covid$country,covid$cases,las=2) # perpendicular labels
  plot(covid$country,covid$cases,las=3) # vertical labels

  plot(covid$country,covid$cases,las=3,cex.lab=0.5, cex.axis=0.5) # vertical labels


  # ggplot2
  data(mpg)
  head(mpg)

  # data
  # aes
  # tipo di geometria
  ggplot(mpg,aes(x=displ,y=hwy)) + geom_point()
  ggplot(mpg,aes(x=displ,y=hwy)) + geom_line()
  ggplot(mpg,aes(x=displ,y=hwy)) + geom_polygon()

  # ggplot di covid
  ggplot(covid,aes(x=lon,y=lat,size=cases)) + geom_point()

  # density
  # create dataset for spatstat
  attach(covid)
  covids <- ppp(lon, lat, c(-180,180), c(-90,90))

  d <- density(covids)

  plot(d)
  points(covids)

  # save the .RData

  setwd("~/lab")
  load("point_pattern.RData")

  ls()

  plot(d)
  # palette
  cl <- colorRampPalette(c('yellow','orange','red')) (100)
  plot(d, col=cl)

  # Exercise
  # plot della mappa della densità dal verde al blu

  points(covids)


  install.packages("rgdal")
  library(rgdal)

  coastlines <- readOGR("ne_10m_coastline.shp")

  plot(coastlines, add=T)

  # Exercise: plot della mappa di densità con una nuova colorazione, e aggiunta delle coastlines
  cl <- colorRampPalette(c('blue','light blue','light green','yellow')) (100)
  plot(d, col=cl)
  plot(coastlines, add=T, col="yellow")

  cl2 <- colorRampPalette(c('red','orange','yellow','green', 'blue')) (800)
  plot(d, col=cl2)
  plot(coastlines, add=T)

  cl3 <- colorRampPalette(c('green', 'violet', 'blue')) (200)
  plot(d, col=cl3)
  plot(coastlines, add=T)

  cl4 <- colorRampPalette(c('violet','yellow','green'))(100)
  plot(d, col=cl4)
  plot(coastlines, add=T)

  cl5 <- colorRampPalette(c('darkcyan', 'purple', 'red')) (200) 
  plot(d, col=cl5)
  plot(coastlines, add=T)

  cl6 <- colorRampPalette(c('darkcyan', 'purple', 'red')) (200) 
  plot(d, col=cl6)
  plot(coastlines, add=T)

  cl7<-colorRampPalette(c('white','blue','green','red','orange','yellow')) (150)
  plot(d, col=cl7)
  plot(coastlines, add=T)


  ### Exercise: caricare il workspace point_pattern.RData (load("...")) e crare un garfico della mappa di densità

  library(spatstat)
  library(rgdal) # for the coastlines

  setwd("~/lab/")
  load("point_pattern.RData")
  ls()

  cl5 <- colorRampPalette(c('cyan', 'purple', 'red')) (200) 
  plot(d, col=cl5, main="
  ")
  points(covids)
  coastlines <- readOGR("ne_10m_coastline.shp")
  plot(coastlines, add=T)

  # interpolazione

  head(covid)
  marks(covids) <- covid$cases
  s <- Smooth(covids)
  plot(s)

  # Exercise: plot(s) with points and coastlines
  cl5 <- colorRampPalette(c('cyan', 'purple', 'red')) (200) 
  plot(s, col=cl5, main="estimate of cases")
  points(covids)
  coastlines <- readOGR("ne_10m_coastline.shp")
  plot(coastlines, add=T)

  text(covids)

  ##### mappa finale
  par(mfrow=c(2,1))

  # densità
  cl5 <- colorRampPalette(c('cyan', 'purple', 'red')) (200) 
  plot(d, col=cl5, main="
  ")
  points(covids)
  coastlines <- readOGR("ne_10m_coastline.shp")
  plot(coastlines, add=T)

  # interpolazione del numero di casi
  cl5 <- colorRampPalette(c('cyan', 'purple', 'red')) (200) 
  plot(s, col=cl5, main="estimate of cases")
  points(covids)
  coastlines <- readOGR("ne_10m_coastline.shp")
  plot(coastlines, add=T)

  ###### San Marino 
  # setwd("~/lab/")
  # library(spatstat)

  load("Tesi.RData")
  ls()

  head(Tesi)
  attach(Tesi)

  summary(Tesi)

  # x varia da 12.42 a 12.46
  # y varia da 43.91 a 43.94
  # point pattern: x,y,c(xmin,xmax),c(ymin,ymax)
  Tesippp <- ppp(Longitude, Latitude, c(12.41,12.47), c(43.9,43.95))

  dT <- density(Tesippp)

  plot(dT)
  points(Tesippp, col="green")

  colors()

  ######### 

  setwd("~/lab/")
  load("sanmarino.RData")
  library(spatstat)
  ls()

  # dT=density map, Tesi=dataset originale, Tesi_ppp=point pattern

  plot(dT)
  points(Tesippp, col="green")

  head(Tesi)

  marks(Tesippp) <- Tesi$Species_richness
  interpol <- Smooth(Tesippp)
  plot(interpol)
  points(Tesippp, col="green")

  library(rgdal)
  sanmarino <- readOGR("San_Marino.shp")

  plot(sanmarino)
  plot(interpol, add=T)
  points(Tesippp,col="green")
  plot(sanmarino, add=T)

  # Exercise: plot multiframe di densità e interpolazione
  par(mfrow=c(2,1))

  plot(dT, main="Density of points")
  points(Tesippp,col="green")

  plot(interpol, main="Estimate of species richness")
  points(Tesippp,col="green")

  # Exercise: plot multiframe di densità e interpolazione uno acacnto all'alto
  par(mfrow=c(1,2))

  plot(dT, main="Density of points")
  points(Tesippp,col="green")

  plot(interpol, main="Estimate of species richness")
  points(Tesippp,col="green")


#################################################################
#################################################################
#################################################################

### 5. R code teleril

# Codice R per analisi di immagini satellitari

# packages: raster

install.packages("raster")

library(raster)

setwd("~/lab/") # linux
# setwd("C:/lab/") # windows
# setwd("/Users/nome/Desktop/lab") # mac

p224r63_2011 <- brick("p224r63_2011_masked.grd")

plot(p224r63_2011)

# B1: blue
# B2: green
# B3: red
# B4: near infrared (nir) 
# B5: medium infrared
# B6: thermal infrared
# B7: medium infrared

# save RData

# day 2
setwd("~/lab/") # linux
# setwd("C:/lab/") # windows
# setwd("/Users/nome/Desktop/lab") # mac

load("teleril.RData")

ls()
# [1] "p224r63"      "p224r63_2011"
library(raster)

plot(p224r63_2011)

cl <- colorRampPalette(c('black','grey','light grey'))(100) # 
plot(p224r63_2011, col=cl) 

# grey scale low amount of colours
cllow <- colorRampPalette(c('black','grey','light grey'))(5) # 
plot(p224r63_2011, col=cllow) 

names(p224r63_2011)
# [1] "B1_sre" "B2_sre" "B3_sre" "B4_sre" "B5_sre" "B6_bt"  "B7_sre"

clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) # 
plot(p224r63_2011$B1_sre, col=clb)
# attch(dataframe) non funziona con il pacchetto raster
# simbolo che lega la colonna (la banda) al dataset (immagine satellitare): $
  
# Exercise: plottare la banda dell'infrarosso vicino con 
# colorRampPalette che varia dal rosso, all'arancione, al giallo
clnir <- colorRampPalette(c('red','orange','yellow'))(100) # 
plot(p224r63_2011$B4_sre, col=clnir)

# multiframe
par(mfrow=c(2,2))

# blue
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) # 
plot(p224r63_2011$B1_sre, col=clb)

# green
clg <- colorRampPalette(c('dark green','green','light green'))(100) # 
plot(p224r63_2011$B2_sre, col=clg)

# red
clr <- colorRampPalette(c('dark red','red','pink'))(100) # 
plot(p224r63_2011$B3_sre, col=clr)

# nir
clnir <- colorRampPalette(c('red','orange','yellow'))(100) # 
plot(p224r63_2011$B4_sre, col=clnir)

dev.off()

# natural colours
# 3 componenti: R G B
# 3 bande: R = banda del rosso, G = banda del verde, B = banda del blu
# 
# plotRGB(p224r63_2011,r=3,g=2,b=1)

# B1: blue - 1
# B2: green - 2
# B3: red - 3
# B4: near infrared (nir) - 4 

# plotrgb: no!
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")

# nir
# false colours
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

# salvataggio
pdf("primografico.pdf") # png("primografico.png")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
dev.off()

# multiframe
par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
dev.off()

# nir nella compnente R(Red)
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
# Exercise: nir nella componente G(Green)
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
# Exercise: nir nella componente B(Blue)
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

###--- day 2

# install.apckages("raster")
library(raster)

setwd("~/lab/") # linux
# setwd("C:/lab/") # windows
# setwd("/Users/nome/Desktop/lab") # mac

load("teleril.RData")

# list
ls()

p224r63_1988 <- brick("p224r63_1988_masked.grd")

plot(p224r63_1988)

# multiframe
par(mfrow=c(2,2))

# blue
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) # 
plot(p224r63_1988$B1_sre, col=clb)

# green
clg <- colorRampPalette(c('dark green','green','light green'))(100) # 
plot(p224r63_1988$B2_sre, col=clg)

# red
clr <- colorRampPalette(c('dark red','red','pink'))(100) # 
plot(p224r63_1988$B3_sre, col=clr)

# nir
clnir <- colorRampPalette(c('red','orange','yellow'))(100) # 
plot(p224r63_1988$B4_sre, col=clnir)

dev.off()

# B1: blue - 1
# B2: green - 2
# B3: red - 3
# B4: near infrared (nir) - 4 

plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")

# Exercise: plot the image using the nir on the "r" component in the RGB space
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")

# plot delle due immagini 1988 e 2011
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin", main="1988")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin", main="2011")
dev.off()

# spectral indices
# dvi1988 = nir1988-red1988

dvi1988 <- p224r63_1988$B4_sre - p224r63_1988$B3_sre
plot(dvi1988)

# Exercise: calculate dvi for 2011
dvi2011 <- p224r63_2011$B4_sre - p224r63_2011$B3_sre
plot(dvi2011)

cldvi <- colorRampPalette(c('light blue','light green','green'))(100) # 
plot(dvi2011, col=cldvi)

# multitemporal analysis
difdvi <- dvi2011 - dvi1988
plot(difdvi)
cldifdvi <- colorRampPalette(c('red','white','blue'))(100) # 
plot(difdvi, col=cldifdvi)

# visualize the output
# multiframe 1988rgb, 2011rgb, difdiv
par(mfrow=c(3,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plot(difdvi, col=cldifdvi)
dev.off()

# Changing the grain (resolution)
p224r63_2011lr <- aggregate(p224r63_2011, fact=10)
p224r63_2011
p224r63_2011lr

par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011lr, r=4, g=3, b=2, stretch="Lin")
dev.off()

# lower resolution
p224r63_2011lr50 <- aggregate(p224r63_2011, fact=50)
p224r63_2011lr50
# original 30m -> resampled 1500m

par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011lr, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011lr50, r=4, g=3, b=2, stretch="Lin")

# dvi2011 low resolution
dvi2011lr50 <- p224r63_2011lr50$B4_sre - p224r63_2011lr50$B3_sre
plot(dvi2011lr50)

# dvi1988 low resolution
p224r63_1988lr50 <- aggregate(p224r63_1988, fact=50)
dvi1988lr50 <- p224r63_1988lr50$B4_sre - p224r63_1988lr50$B3_sre

# difdvi low resolution
difdvilr50 <- dvi2011lr50 - dvi1988lr50
cldifdvi <- colorRampPalette(c('red','white','blue'))(100) # 
plot(difdvilr50, col=cldifdvi)

# multiframe
par(mfrow=c(2,1))
plot(difdvi, col=cldifdvi)
plot(difdvilr50, col=cldifdvi)


#################################################################
#################################################################
#################################################################

### 7. R code multitemp

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
plot(d2c$map, col=cl)+

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
geom_bar(stat="identity", fill="white"ggplot2
        ) +
ylim(0, 100)

grafico2 <- ggplot(output, aes(x=cover, y=after, color=cover)) + 
geom_bar(stat="identity", fill="white") +
ylim(0, 100)

# Exercise: use grid.arrange to plot the two graphs 
grid.arrange(grafico1, grafico2, nrow = 1)


#################################################################
#################################################################
#################################################################

### 8. R code multitemp NO2

# R code for analysing NO2 data from ESA - January to March 2020

library(raster)

setwd("~/lab/")
# setwd("/Users/utente/lab") #mac
# setwd("C:/lab/") # windows

EN01 <- raster("EN_0001.png")
plot(EN01)

# Exercise: import all the images
EN01 <- raster("EN_0001.png")
EN02 <- raster("EN_0002.png")
EN03 <- raster("EN_0003.png")
EN04 <- raster("EN_0004.png")
EN05 <- raster("EN_0005.png")
EN06 <- raster("EN_0006.png")
EN07 <- raster("EN_0007.png")
EN08 <- raster("EN_0008.png")
EN09 <- raster("EN_0009.png")
EN10 <- raster("EN_0010.png")
EN11 <- raster("EN_0011.png")
EN12 <- raster("EN_0012.png")
EN13 <- raster("EN_0013.png")


# EN1
# EN2
# .....
# EN10
# EN11
# EN12
# EN13
# ls()
# EN1 EN10 EN11 EN12 EN13 EN2...


# other method to import the images altogether

library(raster)

#-----

cl <- colorRampPalette(c('red','orange','yellow'))(100) # 
plot(EN01, col=cl)
plot(EN13, col=cl)

par(mfrow=c(1,2))
plot(EN01, col=cl)
plot(EN13, col=cl)

# difference
difno2 <- EN13 - EN01
cldif <- colorRampPalette(c('blue','black','yellow'))(100) # 
plot(difno2, col=cldif)

# plot images

par(mfrow=c(4,4))
plot(EN01, col=cl)
plot(EN02, col=cl)
plot(EN03, col=cl)
plot(EN04, col=cl)
plot(EN05, col=cl)
plot(EN06, col=cl)
plot(EN07, col=cl)
plot(EN08, col=cl)
plot(EN09, col=cl)
plot(EN10, col=cl)
plot(EN11, col=cl)
plot(EN12, col=cl)
plot(EN13, col=cl)


#### day 2

setwd("~/lab/")
# setwd("/Users/utente/lab") #mac
# setwd("C:/lab/") # windows

load("EN.RData")
ls()

setwd("~/lab/esa_no2")

rlist <- list.files(pattern=".png")
rlist

listafinale <- lapply(rlist, raster)
# brick

EN <- stack(listafinale) 

difEN <- EN$EN_0013 - EN$EN_0001

cld <- colorRampPalette(c('blue','white','red'))(100) # 
plot(difEN, col=cld)

cl <- colorRampPalette(c('red','orange','yellow'))(100) # 
plot(EN, col=cl)

boxplot(EN, horizontal=T,outline=F)
        

#################################################################
#################################################################
#################################################################

### 9. R code snow

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



#################################################################
#################################################################
#################################################################

### 10. R code patches

# R_code_patches.r

library(raster)
# install.packages("igraph")
library(igraph) # for pacthes
library(ggplot2) # for the final output plot

setwd("~/lab/")
# setwd("/Users/utente/lab") #mac
# setwd("C:/lab/") # windows

d1c <- raster("d1c.tif")
d2c <- raster("d2c.tif")

par(mfrow=c(1,2))
cl <- colorRampPalette(c('black','green'))(100) # 
plot(d1c,col=cl)
plot(d2c,col=cl)

# forest: class 2; agriculture: class 1
d1c.for <- reclassify(d1c, cbind(1,NA))
d2c.for <- reclassify(d2c, cbind(1,NA))

par(mfrow=c(1,2))
cl <- colorRampPalette(c('black','green'))(100) # 
plot(d1c,col=cl)
plot(d1c.for, col=cl)

par(mfrow=c(1,2))
plot(d1c)
plot(d2c)

# creating patches
install.packages("igraph")
library(igraph) # for patches
d1c.for.patches <- clump(d1c.for)
d2c.for.patches <- clump(d2c.for)

# writeRaster(d1c.for.patches, "d1c.for.patches.tif")
# writeRaster(d2c.for.patches, "d2c.for.patches.tif")
# d1c.for.patches <- raster("d1c.for.patches.tif")
# d2c.for.pacthes <- raster("d2c.for.patches.tif")

# Exercise: plottare entrambe le mappe una accanto all'altra
clp <- colorRampPalette(c('dark blue','blue','green','orange','yellow','red'))(100) # 
par(mfrow=c(1,2))
plot(d1c.for.patches, col=clp)
plot(d2c.for.patches, col=clp)

# max patches d1 = 301
# max patches d2 = 1212

# plot results:
time <- c("Period 1","Period 2")
npatches <- c(301,1212)

output <- data.frame(time,npatches)
attach(output)

ggplot(output, aes(x=time, y=npatches)) + geom_bar(stat="identity", fill="white")


#################################################################
#################################################################
#################################################################

### 11. R code crop - exam simulation

library(raster)

setwd("~/lab/snow/") # Linux
# setwd("C:/lab/snow/") # Windows
# setwd("/Users/nome_utente/Desktop/lab/snow/") # Mac

# Exercise: upload the whole snow set


rlist <- list.files(pattern="snow")
rlist 

#save raster into list
#con lappy
list_rast <- lapply(rlist, raster)
snow.multitemp <- stack(list_rast)

clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) # 
plot(snow.multitemp,col=clb)

# zoom
snow.multitemp

plot(snow.multitemp$snow2010r, col=clb)

extension <- c(6, 20, 35, 50)
zoom(snow.multitemp$snow2010r, ext=extension)

plot(snow.multitemp$snow2010r, col=clb)
zoom(snow.multitemp$snow2010r, ext=drawExtent())

# crop
extension <- c(6, 20, 35, 50)
snow2010r.italy <- crop(snow.multitemp$snow2010r, extension)
plot(snow2010r.italy, col=clb)

# Exercise: crop the Italy extent on the whole stack of snow layers
snow.multitemp.italy <- crop(snow.multitemp, extension)
plot(snow.multitemp.italy, col=clb, zlim=c(20,200))

# boxplot
boxplot(snow.multitemp.italy, horizontal=T,outline=F)

#################################################################
#################################################################
#################################################################

### 12. Species Distribution Modelling

# install.packages("sdm")
# install.packages("rgdal")
library(sdm)
library(raster)
library(rgdal)

# species
file <- system.file("external/species.shp", package="sdm") 
species <- shapefile(file)

species
species$Occurrence
plot(species)

plot(species[species$Occurrence == 1,],col='blue',pch=16)

points(species[species$Occurrence == 0,],col='red',pch=16)

# environmental variables
path <- system.file("external", package="sdm") 

lst <- list.files(path=path,pattern='asc$',full.names = T) #
lst

preds <- stack(lst)

cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl)

plot(preds$elevation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$temperature, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$precipitation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$vegetation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

# model

d <- sdmData(train=species, predictors=preds)
d

m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=d, methods='glm') 
p1 <- predict(m1, newdata=preds)

plot(p1, col=cl)
points(species[species$Occurrence == 1,], pch=16)


####################################################

# EXAM PROJECT

# Here put your code









