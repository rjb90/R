require(tidyverse)
letters
sample(letters, 5)
muestra=sample(letters,100,replace=TRUE)
muestra
table(muestra)

# Muestreo aleatorio simple --------------------------------
# Estados americanos
state.name # la lista de estados americanos como Población
sample(state.name, size=5) #Obtengo una muestra de mi base de datos de los estados americanos
muestra = sample (state.name, size = 200) #Me da un error porque la muestra es mas grande que el total de los datos

# Precios de la gasolinera en España
require(readxl) #para leer fichero de excel en R
gasolineras = read_excel("gasolineras.xls",skip=3) #Fuente: https://geoportalgasolineras.es
gasolineras

getwd()

summary(gasolineras$Precio) #resumen de la distribución del precio

n=250 # tamaño muestral
muestra <- gasolineras %>% sample_n(size=n) 
summary(muestra$Precio) #distribución del precio en la muestra

# Muestreo estratificado (proporcional) Me aseguro que la muestra sea equiprobabilistica
muestra <- gasolineras %>% group_by(Provincia) %>% sample_frac(.1) # 1% en cada provincia  
muestra %>% summarise(media=mean(Precio),n = n())

gasolineras <- gasolineras %>% separate("Toma de datos",c("Fecha","Hora")," ")
gasolineras

qplot(Fecha, Precio,data=gasolineras,geom="boxplot") #Con esto obtengo un gráfico para ver
muestra <- gasolineras %>% group_by(Provincia,Fecha) %>% sample_frac(.1)
muestra

# Distribución binomial --------------------------------

n=40
p=.2 #probabilidad de daño igual al 20%
ndaños=rbinom(500,n,p) #simulación del número de frutas dañadas en 500 cajas de n manzanas
ndaños
qplot(ndaños,geom="bar") #distribución del número de frutas dañadas


####### Altura de niñas españolas de 5 años 
mu=108 #altura media de las niñas (en cm)
sigma=10 #variación promedia de la altura entre niñas (en cm)  
alturas=rnorm(2000,mu,sigma) #alturas de 2000 niñas seleccionadas al azar en la población 
summary(alturas)

qplot(alturas) #Veo que es una distrbución normal

mean(alturas<115)
pnorm(115,mean = 108, sd = 10)
qnorm(.75,108,10)
qnorm(.95,108,10)
qnorm(.05,108,10)  

R=10000
y=rnorm(25, mean = 330, sd = 5)
y
mean(y)
summary(y)

media_replicada = replicate(R,mean(rnorm(25,330,5)))
media_replicada
head(media_replicada,100)
mean(media_replicada<=327.5)
sd(media_replicada)
medias=replicate(R,mean(rnorm(100,330,5)))
sd(medias)

qnorm(0,25)


# Inferencia sobre medias --------------------------------

## Distribución de la media muestral en muestras de 25 botellas
K=1000 #número de muestras
medias=replicate(K,mean(rnorm(25,330,5)))
summary(medias) #distribución de las medias 
sd(medias)
qplot(medias)


### Utilización del Test de Student en R ####
muestra=c(326.4,324.5,319.2,332.9,328.9,331.3,327.4,323.6,322.7,323.9,325.3,329.6,338,328.8,327.6,333,333.7,335.6,319.2,320.2,327.9,330.3,326.9,320.2,330.4)
t.test(muestra,mu=330) #contrasta si mu=330
t=(mean(muestra)-330)/(sd(muestra)/sqrt(25))
t
t.test(muestra,mu=3300)
qt(.975,24)
mean(muestra)+qt(.975,24)*sd(muestra)/sqrt(25)
mean(muestra)-qt(.975,24)*sd(muestra)/sqrt(25)


# Comparando medias
require(openintro)
glimpse(births) #?births para más detalles
qplot(smoke,weight,data=births,geom="boxplot")
t.test(weight~smoke,data=births)




