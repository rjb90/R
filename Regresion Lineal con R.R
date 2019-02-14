# Regresión lineal


library(tidyverse)
library(openintro) #Contiene data sets

head(births)

ggplot(births, aes(x=weeks, y=weight))+geom_smooth()
ggplot(births, aes(x=weeks, y=weight))+geom_point()
ggplot(births, aes(x=weeks, y=weight))+geom_point(alpha=1)+geom_smooth(method='lm') #Obtengo una curva que me resume los puntos

fit=lm(weight~weeks, data=births) #Obtengo el intercept o sea la ordenadoa al origen y en week es la pendiente
fit

fit$coef

ggplot(births, aes(x=weeks, y=weight))+geom_point(alpha=1)+geom_abline(intercept = fit$coef[1], slope=fit$coef[2])
ggplot(births, aes(x=weeks, y=weight))+geom_point(alpha=1)+geom_abline(intercept = fit$coef[1], slope=fit$coef[2])+geom_smooth(method='lm')
#Con esa ultima puedo ver que las rectas son las mismas, hay una sobre la otra

births %>% filter(weeks ==40) #Para 40 semanas tengo 29 datos, 29 niños que nacieron a las 40 semanas

births %>% filter(weeks ==30)

lm(weight~smoke, births) #Obtengo pendiente y ordenada al origen de la recta
summary(fit)

t.test(weight~smoke, data=births)

y=births$weight
TSS = sum((y-mean(y))^2)
TSS #Esta es la variablidad total de los datos

pred=fit$fitted
head(pred)
head(y)

RSS=sum((y-pred)^2)
RSS #Esta es la manera no explicada del modelo

1-RSS/TSS #La variabilidad explicado por los datos es del 46%


datos=births
datos$weeks = datos$weeks - median(datos$weeks)
#Es interesante hacer esto asi podemos ver lo que cambia
datos$weeks


ajuste=lm(weight~weeks,data=births)
ajuste
layout(matrix(1:4,2,2))
plot(ajuste)

births$weight.sim=simulate(ajuste)$sim_1
layout(matrix(1:4,2,2))
plot(lm(weight.sim~weeks,data=births))

ajuste.mult=lm(weight~.,data=births)
summary(ajuste.mult)
births %>% mutate_all(as.numeric) %>% cor(use="pairwise")

panel.cor<-function(x,y) {
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r=cor(x,y,use="pairwise")
  grises=paste0("grey",round((1-abs(r))*100))
  text(.5,.5,round(r,2),col=grises)}
pairs(weight~.,data=births,lower.panel=panel.smooth,upper.panel=panel.cor)

