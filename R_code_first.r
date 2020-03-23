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
