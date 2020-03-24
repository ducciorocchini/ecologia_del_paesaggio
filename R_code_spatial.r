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
