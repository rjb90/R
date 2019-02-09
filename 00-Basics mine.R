# R Basics

getwd() #getwd sirve para saber en que directorio estoy. 

#Esta es la manera de crear variables en R:
x <- 2
y <- 3

ls() #Esto me dice los objetos que tengo creados

#Con esto puedo identificar si una variable esta creada y me dice True or False
exists("x")

#Para eliminar objetos del enviorment uso rm
rm(x) #Elimino el objeto x           
rm(x, y) #Elimino los objetos x e y
rm(list = ls()) #Esto me elimina todos los objetos que han sido creados      


# Usar ayuda help ------------------------------------------------------------
help(mean)      # Esto me indica la ayuda sobre una determinada función 
?mean           # Hace lo mismo que el comando help
example(mean)   # Me da un ejemplo de lo que es la media


# packages en R ---------------------------------------------------

# Primero hay que instalar y cargar el paquete 
# El lugar mas común para obtener el paquete es de CRAN

install.packages("dplyr")
library(dplyr)   

#Uso una función particular del paquete instalado:
dplyr::select(iris, 
              'Sepal.Length')

help(package = "dplyr")      
vignette(package = "dplyr")
vignette("dplyr")

# También puedo instalar paquetes desde GitHub
install.packages("devtools")
library(devtools)
install_github("hadley/dplyr")

# Quick list of useful R packages: https://support.rstudio.com/hc/en-us/articles/201057987-Quick-list-of-useful-R-packages


# Asignación y evaluación con R -------------------------------------------------

x <- 16 #Asignación
x #Evaluación


z <- expression(z <- 4)
z
eval(z)

y <- 1 
z <- 4
x * y * z

# Operaciones con R  -------------------------------------------------------
8 + 9 / 5 ^ 2

1 / 7

options(digits = 3)
1 / 7

42 / 4          # división
42 %/% 4        # integer
42 %% 4         # modulo 

x <- 1000
abs(x)      # valor absoluto
sqrt(x)     # raíz quadrada
exp(x)      # exponencial
log(x)      # logaritmo
log(x, 10)
log10(x) 
10^log10(x) 
log2(x) 
2^log2(x)

cos(x)      # funciones trigonométricas
sin(x) 
tan(x)

1 / 0           # infinito
Inf - Inf       # NaN
-1 / 0          # infinito negativo
0 / 0           # NaN
sqrt(-9)        # Nans produced


# Vectorización -----------------------------------------------------------

x <- c(1, 3, 4)
y <- c(1, 2, 4)

x
y

# vector vacío 
z <- as.vector(NULL)

# `for` loop donde añado elementos de los vectores x e y en el vector z
for (i in seq_along(x)) {
  z[i] <- x[i] + y[i]
  print(z)
}

z

#Operaciones con vectores
x + y
x * y
x > y
c <- 3 #En R no hay escalares
is.vector(c)

######################
# Data types
######################

# Números ----------------------------------------------------
dbl_var <- c(1, 2.5, 4.5)  
dbl_var

int_var <- c(1L, 6L, 10L) #Si colocamos una L después de los valores, me da un int
int_var

# identificación del tipo de vector
typeof(dbl_var)
typeof(int_var)

# Conversión de vectores
as.numeric(int_var)
as.integer(dbl_var)

1:10 #Creo un vector entre 1 y 10

#Generación de secuencias regulares
seq(from = 1, to = 21, by = 2)
seq(0, 21, length.out = 15)

#Genero una secuencia de números del 1 al 10 de .1 a .1, calculo su coseno y lo ploteo
plot(cos(seq(0,10,0.1)),type="l")
lines(sin(seq(0,10,0.1)), col='red')


# Generación de secuencias repetidas
rep(1:4, times = 2) 
rep(1:4, each = 2)


# Comparación de números

x <- c(1, 4, 9, 12)
y <- c(4, 4, 9, 13)
x == y #Es falso porque hay uno falso
sum(x == y) #Entonces, que me sume lo que es verdadero
which(x == y) #Con which me dice cuales son los index que coinciden    
x[which(x == y)] #y asi me dice cuales son los que coinciden

# Igualdad exacta
x <- c(4, 4, 9, 12)
y <- c(4, 4, 9, 13)
identical(x, y) #False porque no son 100% identicos


# Redendeo de valores

x <- c(1, 1.35, 1.7, 2.05, 2.4, 2.75, 3.1, 3.45, 3.8, 4.15, 4.5, 4.85, 5.2, 5.55, 5.9)
round(x)
ceiling(x) #Redondeo hacia arriba
floor(x) #Redondeo hacia abajo
round(x, digits = 1) #Redondear a un decimal específico


# Trabajar con caracteres -------------------------------------------------

# Creación de strings

a <- "learning to create"
b <- "character strings"

#Concatenación de strings
paste(a, b) #Junto ambos strings

paste("The life of", pi)           
paste("I", "love", "R") #Concatenación de múltiples strings          
paste("I", "love", "R", sep = "-") #Concatenación de strings con algo de por medio

paste0("I", "love", "R") #paste0 se usa para concatenar los strings sin espacios de por medio

paste("R", 1:5, sep = " v1.") #Concatenación de objetos con distinta longitud    

x <- "print strings"
sprintf("Learning to %s in R", x)   
y <- "in R"
sprintf("Learning to %s %s", x, y) #Asi puedo concatenar strings con variables y formar otro str

version <- R.version$major
version <- as.numeric(version)
sprintf("This is R version: %d", version)

# Contar str e int
length("How many elements are in this string?") #Un solo str
length(c("How", "many", "elements", "are", "in", "this", "string?")) #7 objectos str

nchar("How many characters are in this string?") #nchar se usa para contar catacteres
nchar(c("How", "many", "characters", "are", "in", "this", "string?")) #De esta manera me dice los car de c/str

# stringr

install.packages("stringr")
library(stringr)

str_c("Learning", "to", "use", "the", "stringr", "package", sep = " ") # str_c() hace lo mismo que la función paste()

# str_length() es similar a nchar() pero compara
text = c("Learning", "to", NA, "use", "the", NA, "stringr", "package")
nchar(text)
str_length(text)

# str_sub() is similar to substr()
x <- "Learning to use the stringr package"
str_sub(x, start = 10, end = 15) #Selección de una parte del objeto str

str_sub(x, end = 15) <- "I know how to use" #Reemplazo de elementos dentro del objeto str
x

text <- c("Text ", "  with", " whitespace ", " on", "both ", " sides ")
str_trim(text, side = "both")

# Operaciones Set para str
set_1 <- c("lagunitas", "bells", "dogfish", "summit", "odell")
set_2 <- c("sierra", "bells", "harpoon", "lagunitas", "founders")
union(set_1, set_2)
intersect(set_1, set_2)
setdiff(set_1, set_2) #Devuelve elementos del set_1 que no están en el set_2
identical(set_1, set_2) #Me indica que ambos no son identicos
'sierra' %in% set_2 #bool para identificar si un elemento está incluido en un str

sort(set_2, decreasing = TRUE) #Mezclar str



# Expresiones regulares ----------------------------------------

sub(pattern = "\\$", "\\!", "I love R$")

gsub(pattern = "\\\\", " ", "I\\need\\space") #subtitución de \\ con espacios en blanco


# Expresiones lógicas (bool) ---------------------------------------------------

x <- 5

x > 13

x <- c(5, 14, 10, 22)

x > 13

12 == 12

12 <= c(12, 11)

12 %in% c(12, 11, 8)

x <- c(12, NA, 11, NA, 8)
is.na(x)

x <- c(5, 14, 10, 22)
sum(x > 13)


# Manejando fechas ------------------------------------------------------

Sys.timezone() # Zona horaria acutal
Sys.Date() #día actual
Sys.time() #hora actual

install.packages('lubridate')
library(lubridate)

now() #De esta manera puedo obtener fecha y hora actual

# Conversión de str a fechas
x <- c("2015-07-01", "2015-08-01", "2015-09-01")
as.Date(x)

y <- c("07/01/2015", "07/01/2015", "07/01/2015")
as.Date(y, format = "%m/%d/%Y")

library(lubridate)
ymd(x)
mdy(y)

# Creación de fechas concatenando datos
yr <- c("2012", "2013", "2014", "2015")
mo <- c("1", "5", "7", "2")
day <- c("02", "22", "15", "28")

# ISOdate convierte a un objeto POSIXct 
ISOdate(year = yr, month = mo, day = day)
as.Date(ISOdate(year = yr, month = mo, day = day))

# Extracción y manipulación de fechas
x <- c("2015-07-01", "2015-08-01", "2015-09-01")
year(x)
month(x)
month(x, label = TRUE)

# Creación de secuencias de datos
seq(as.Date("2010-1-1"), as.Date("2015-1-1"), by = "years")
seq(as.Date("2015/1/1"), as.Date("2015/12/30"), by = "quarter")

# Calculos con fechas
x <- Sys.Date()
x

y <- as.Date("2015-09-11")
x > y
x - y

x <- as.Date("2012-03-1")
y <- as.Date("2012-02-28")
x - y

# Ejemplos con zonas horarias
x <- as.POSIXct("2017-01-01 01:00:00", tz = "US/Eastern")
y <- as.POSIXct("2017-01-01 01:00:00", tz = "US/Pacific")
y == x
y - x
x + days(4)
x - hours(4)



# Missing values ---------------------------------------------

x <- c(1:4, NA, 6:7, NA)
x
is.na(x)
which(is.na(x))
x[is.na(x)]
x[!is.na(x)] #Me devuelve los valore que no son NA
x[is.na(x)] <- mean(x, na.rm = TRUE)
x


# Estructuras de datos básicas ---------------------------------------------------

vector <- 1:10
list <- list(item1 = 1:10, item2 = LETTERS[1:18])
matrix <- matrix(1:12, nrow = 4)   
df <- data.frame(item1 = 1:18, item2 = LETTERS[1:18])

str(vector)
str(list)
str(matrix)
str(df)

#clases de las variables()
class(vector)
class(list)
class(matrix)
class(df)

# Atributos
attributes(df)
attributes(matrix)

names(df)
dim(matrix)
length(vector)
length(list)
length(df)

# Vectores

# Creación de vectores
x <- c(0.5, 0.6, 0.2)
x

y <- c(TRUE, FALSE, FALSE)
y

z <- c("a", "b", "c") 
z

seq(from = 1, to = 21, by = 2) 
rep(1:4, times = 2) 

# Agregar elementos a vectores ya existentes
v1 <- 8:17
c(v1, 18:22)

# Subconjunto de vectores
v1
v1[2]
v1[2:4]
v1[c(2, 4, 6, 8)]
v1[-1]

# Subconjuntos con valores lógicos
v1[c(TRUE, FALSE, TRUE, FALSE, TRUE, TRUE, TRUE, FALSE, FALSE, TRUE)]
v1[c(TRUE, FALSE)]


# Listas

# Creación de listas
l <- list(1:3, "a", c(TRUE, FALSE, TRUE), c(2.5, 4.2))
str(l)

# Como agregar objetos a listas preexistentes 
l1 <- list(1:3, "a", c(TRUE, FALSE, TRUE))
names(l1) <- c("item1", "item2", "item3")

# Subconjunto de listas
l1[1]
l1[[1]]
l1$item1

# Data Frames

# Creación de Data Frames
df <- data.frame(col1 = 1:3, 
                 col2 = c("this", "is", "text"), 
                 col3 = c(TRUE, FALSE, TRUE), 
                 col4 = c(2.5, 4.2, pi))
str(df)

nrow(df) #Me devuelve el número de filas
ncol(df) #Me devuelve el número de columnas

# Como agregar atributos al df
rownames(df) <- c("row1", "row2", "row3")
colnames(df) <- c("col_1", "col_2", "col_3", "col_4")
df

