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

# green
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

























