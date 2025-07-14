setwd("C:/esameTelerilevamento") # Per impostare la cartella di lavoro

library(terra) # Usato per le funzioni rast() e flip()
library(imageRy) # Usato per le funzioni im.plotRGB() e im.classify()
library(viridis) # Usato per creare indici con palette di colori adatte a chi soffre di daltonismo
library(ggplot2) # Usato per mostrare i dati in maniera grafica con la funzione ggplot()
#library(patchwork) # Per visualizzare più grafici al stesso tempo, infine non era necessario

# Le immagini sono state scaricate graze a copernicus browser (https://browser.dataspace.copernicus.eu)
# Coordinate per trovare l'area d'interesse (21,27 km^2): {"type":"Polygon","coordinates":[[[16.006841,43.606676],[15.932881,43.606676],[15.932881,43.638882],[16.006841,43.638882],[16.006841,43.606676]]]}

# Il primo passaggio è di caricare tutte le immagini su R, sono state scelte 4 date:
# 11.07.2023. (prima dell'incendio), 16.07.2023. (appena dopo l'incendio), 15.06.2024., e 16.04.2025.
# Ognuna delle 4 immagini ha 5 bande: banda 04 (rosso), 03 (verde), 02 (blu), 08 (NIR, cioe near-infrared, usata per monitorare la vegetazione), e la banda 12 (SWIR 2, utile per monitorare l'umidità) 
# (SWIR: Short-Wave Infrared)
# Ogni banda viene assegnata ad un oggetto:

temp01B02<-rast("2023-07-11-B02.tiff")
temp01B03<-rast("2023-07-11-B03.tiff")
temp01B04<-rast("2023-07-11-B04.tiff")
temp01B08<-rast("2023-07-11-B08.tiff")
temp01B12<-rast("2023-07-11-B12.tiff")

temp02B02<-rast("2023-07-16-B02.tiff")
temp02B03<-rast("2023-07-16-B03.tiff")
temp02B04<-rast("2023-07-16-B04.tiff")
temp02B08<-rast("2023-07-16-B08.tiff")
temp02B12<-rast("2023-07-16-B12.tiff")

temp03B02<-rast("2024-06-15-B02.tiff")
temp03B03<-rast("2024-06-15-B03.tiff")
temp03B04<-rast("2024-06-15-B04.tiff")
temp03B08<-rast("2024-06-15-B08.tiff")
temp03B12<-rast("2024-06-15-B12.tiff")

temp04B02<-rast("2025-04-16-B02.tiff")
temp04B03<-rast("2025-04-16-B03.tiff")
temp04B04<-rast("2025-04-16-B04.tiff")
temp04B08<-rast("2025-04-16-B08.tiff")
temp04B12<-rast("2025-04-16-B12.tiff")

# Le 5 bande vengono unite in un'unico stack, per creare un'immagine con tutte le bande, e così per ogni data:

temp01<-c(temp01B04, temp01B03, temp01B02, temp01B08, temp01B12)
temp02<-c(temp02B04, temp02B03, temp02B02, temp02B08, temp02B12)
temp03<-c(temp03B04, temp03B03, temp03B02, temp03B08, temp03B12)
temp04<-c(temp04B04, temp04B03, temp04B02, temp04B08, temp04B12)

# I .tiff vengono girati 180°, per qualche strano motivo, una volta caricati su R, le immagini vengono capovolte (possibile bug)
# Controllare se questo passaggio è necessario
# Questo passaggio NON è più necessario

temp01flip <- flip(temp01, 'vertical')
temp02flip <- flip(temp02, 'vertical')
temp03flip <- flip(temp03, 'vertical')
temp04flip <- flip(temp04, 'vertical')

# per visualizzare le immagini con colorazione normale (bande red, green e blue):


im.plotRGB(temp01, 1, 2, 3)
im.plotRGB(temp02, 1, 2, 3)
im.plotRGB(temp03, 1, 2, 3)
im.plotRGB(temp04, 1, 2, 3)

# Per visualizzare le immagini in NIR (per visualizzare ed analizzare la vegetazione):

im.plotRGB(temp01, 4, 3, 2)
im.plotRGB(temp02, 4, 3, 2)
im.plotRGB(temp03, 4, 3, 2)
im.plotRGB(temp04, 4, 3, 2)

# NDVI (Normalized Difference Vegetation Index):
# Utile per indicare la densità della vegetazione e se è sotto stress
# Per calcolarlo: NDVI = (banda 08 - banda 04) / (banda 08 + banda 04)

dif01a = temp01[[4]] - temp01[[1]] 
sum01a = temp01[[4]] + temp01[[1]]
ndvi01 = dif01a / sum01a

dif02a = temp02[[4]] - temp02[[1]] 
sum02a = temp02[[4]] + temp02[[1]]
ndvi02 = dif02a / sum02a

dif03a = temp03[[4]] - temp03[[1]] 
sum03a = temp03[[4]] + temp03[[1]]
ndvi03 = dif03a / sum03a

dif04a = temp04[[4]] - temp04[[1]] 
sum04a = temp04[[4]] + temp04[[1]]
ndvi04 = dif04a / sum04a

# Se siamo pigri:
# ndvi01 <- im.ndvi(temp01, 4, 1)
# ndvi02 <- im.ndvi(temp02, 4, 1)
# ndvi03 <- im.ndvi(temp03, 4, 1)
# ndvi04 <- im.ndvi(temp04, 4, 1)

par(mfrow=c(2,2)) # per mostrare tutte 4 NDVI al stesso tempo

plot(ndvi01)
plot(ndvi02)
plot(ndvi03)
plot(ndvi04)

# Per qualche motivo gli indici vengono creati con la colorazione viridis di default, altrimenti lo possiamo fare manualmente:

plot(ndvi01, col=viridis (100))
plot(ndvi02, col=viridis (100))
plot(ndvi03, col=viridis (100))
plot(ndvi04, col=viridis (100))

dev.off()

# NBR (Normalized Burn Ratio):
# Utilizzato per identificare aree d'incendio e classificare la loro intensità
# Per calcolarlo: NBR = (banda 08 - banda 12) / (banda 08 + banda 12)

dif01b = temp01[[4]] - temp01[[5]] 
sum01b = temp01[[4]] + temp01[[5]]
nbr01 = dif01b / sum01b

dif02b = temp02[[4]] - temp02[[5]] 
sum02b = temp02[[4]] + temp02[[5]]
nbr02 = dif02b / sum02b

dif03b = temp03[[4]] - temp03[[5]] 
sum03b = temp03[[4]] + temp03[[5]]
nbr03 = dif03b / sum03b

dif04b = temp04[[4]] - temp04[[5]] 
sum04b = temp04[[4]] + temp04[[5]]
nbr04 = dif04b / sum04b

par(mfrow=c(2,2))

plot(nbr01)
plot(nbr02)
plot(nbr03)
plot(nbr04)

# Possiamo anche uilizzare una colorazione differente:

plot(nbr01, col=inferno (100))
plot(nbr02, col=inferno (100))
plot(nbr03, col=inferno (100))
plot(nbr04, col=inferno (100))

dev.off()

# NDWI (Normalized Difference Water Index):
# Nel nostro caso non ci fornisce troppe informazioni pertinenti, però è utile saperlo
# Utilizzato per monitorare il contenuto di acqua in corpi idrici e vegetazione
# Per calcolarlo: NDWI = (banda 03 - banda 08) / (banda 03 + banda 08)

dif01c = temp01[[2]] - temp01[[4]] 
sum01c = temp01[[2]] + temp01[[4]] 
ndwi01 = dif01c / sum01c

dif02c = temp02[[2]] - temp02[[4]] 
sum02c = temp02[[2]] + temp02[[4]] 
ndwi02 = dif02c / sum02c

dif03c = temp03[[2]] - temp03[[4]] 
sum03c = temp03[[2]] + temp03[[4]] 
ndwi03 = dif03c / sum03c

dif04c = temp04[[2]] - temp04[[4]] 
sum04c = temp04[[2]] + temp04[[4]] 
ndwi04 = dif04c / sum04c

par(mfrow=c(2,2))

plot(ndwi01)
plot(ndwi02)
plot(ndwi03)
plot(ndwi04)

dev.off()

# Classificazione:
# I raster vengono divisi in cluster per distinguere gli elementi che compongono l'immagine satellitare (vegetazione, aree urbane, mare, e l'area bruciata)

class01<-im.classify(temp01, num_clusters = 3) 
class02<-im.classify(temp02, num_clusters = 4)
class03<-im.classify(temp03, num_clusters = 3)
class04<-im.classify(temp04, num_clusters = 3)

# Per class02 utilizziamo 4 clusters per distinguere l'area incendio dal suolo nudo/urbanizzato

# ricaviamo le frequenze dei pixel:

ftemp01<-freq(class01)
ftemp02<-freq(class02)
ftemp03<-freq(class03)
ftemp04<-freq(class04)

# pixel totali:

temp01tot<-ncell(class01)
temp02tot<-ncell(class02)
temp03tot<-ncell(class03)
temp04tot<-ncell(class04)

# E calcoliamo le percentuali:

proptemp01<-ftemp01/temp01tot
proptemp02<-ftemp02/temp02tot
proptemp03<-ftemp03/temp03tot
proptemp04<-ftemp04/temp04tot

perctemp01<-proptemp01*100
perctemp02<-proptemp02*100
perctemp03<-proptemp03*100
perctemp04<-proptemp04*100

# Con le percentuali possiamo costruire una tabella:

suolo <- c(27.03, 43.66, 27.46, 23.91) # per la seconda immagine facciamo 17.395339 + 26.261399 (l'area bruciata)
vegetazione <- c(64.61, 47.99, 64.16, 67.62)
anno <- c("2023 pre-inc", "2023 post-inc", "2024", "2025")
tabella <- data.frame(anno, suolo, vegetazione)

# e con il pachetto ggplot2 costruire un grafico a barre
# per mostrare le percentuali delle aree coperte da vegetazione e le aree con vegetazione assente:
# (da notare che della percentuale totale, 9.4% corrisponde al mare)

tabella$anno <- factor(tabella$anno, levels = c("2023 pre-inc", "2023 post-inc", "2024", "2025")) # Usato per ordinare gli anni in modo cronologico

# Grafico a barre per la vegetazione:

plotvegetazione <- ggplot(tabella, aes(x = anno, y = vegetazione, fill = anno)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(
    limits = c(0, 100),           
    breaks = seq(0, 100, by=10)) + 
  labs(title = "Vegetazione", 
       x = "Anno", 
       y = "Vegetazione (%)") +
  theme_minimal() +
  scale_fill_brewer(palette = "Set1")

# Grafico a barre per l'assenza di vegetazione:

plotsuolo <- ggplot(tabella, aes(x = anno, y = suolo, fill = anno)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(
    limits = c(0, 100),           
    breaks = seq(0, 100, by=10)) +
  labs(title = "Terreno senza vegetazione", 
       x = "Anno", 
       y = "Terreno senza vegetazione (%)") +
  theme_minimal() +
  scale_fill_brewer(palette = "Set1")

plotvegetazione
plotsuolo

dev.off()

im.plotRGB(temp02, 5, 4, 1) # mostra bene l'area di incendio, però non è adatta a persone che soffrono di daltonia
