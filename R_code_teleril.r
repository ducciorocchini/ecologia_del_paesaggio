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






