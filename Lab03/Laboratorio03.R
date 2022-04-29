
#------------------------CARGAR DATOS------------------------
print(iris)
#--------------------------------------------------------------------------

#------------------------INSPECCIONAR DATOS------------------------
# 1. Instrucciones básicas con data sets
#--------------------------------------------------------------------------
#   Instrucción         Resultado

#   head(iris)      ->    Visualizar primeras seis filas del dataset
#   tail(iris)      ->    Visualizar primeras seis últimas filas del dataset
#   summary(iris)   ->    Resumen estadístico de las columnas
#   str(iris)       ->    Estructura textual del objeto
#   dim(iris)       ->    Filas x columnas
#   nrow(iris)      ->   Número de filas
#   ncol(iris)      ->    Número de columnas
#   colnames(iris)  ->    Se obtiene el nombre de las columnas

#--------------------------------------------------------------------------
# 2. Selección de filas y columnas de un conjunto de datos
#--------------------------------------------------------------------------
#   Instrucción         Resultado

#   iris[1:7,]                       ->   Visualizar 7 primeras filas del dataset
#   iris[, 3:4]                      ->   Visualizar columnas 3 y 4 del dataset
#   iris[1:10, 3:4]                  ->   Visualizar 10 primeras filas de las columnas 3 y 4 del dataset

#   iris[, "Species"]                ->   Visualiza todos los valores de la columna llamada Species del dataset
#   iris$Species                     ->   Visualiza todos los valores de la columna llamada Species del dataset, equivale a iris[, "Species"]
#   iris[iris$Species == "setosa",]  ->   Visualiza todas las filas que cumplan la condición que la especie sea “setosa” dentro del dataset
#   iris[iris$Species == "setosa" &  ->   Visualiza todas las filas que cumplan la condición que la especie sea “setosa” y que la longitud del petalo sea mayor o igual a 1.5 
#   iris$Petal.Length >= 1.5,]          
#--------------------------------------------------------------------------
# 3. Copia o eliminación de un conjunto de datos
#--------------------------------------------------------------------------
#Copia:
my.iris <- iris
head(my.iris)
ls()

#Eliminación:
rm(my.iris)
ls()

#--------------------------------------------------------------------------
# 4. Creación / eliminación de columnas en un conjunto de datos
#--------------------------------------------------------------------------
#Crear columna:
my.iris <- iris
my.iris$Petal.Area <- my.iris$Petal.Length * my.iris$Petal.Width

#Eliminar columna:
my.iris$Petal.Area <- NULL

#--------------------------------------------------------------------------
# 5. Ordenamiento de filas dentro del conjunto de datos
#--------------------------------------------------------------------------
my.iris <- iris[order(iris$Petal.Length),]

#--------------------------------------------------------------------------
# 6. Creación de Vectores
#--------------------------------------------------------------------------

x <- 1:10
y <- iris$Species
1:5
5:1
c (1:5, 5:1)
c(1, 5, -1, 4)
c("uno", "dos", "tres")

seq(1, 5)
rep(1:5, 5) #repite la secuencia n veces
rep(1:5, each = 5) #repite cada element n veces
#--------------------------------------------------------------------------
#   6.1.Exploración de vectores
#--------------------------------------------------------------------------
plot(x)
length(x)
table(y)
summary(y)
head(x)
tail(x)
table(iris$Species)
#--------------------------------------------------------------------------
#   6.2.Selección de elementos de un vector
#--------------------------------------------------------------------------

x <- x^2
x
x[1:3]
x[c(1,3)] #selecciona los índices indicados
x[x > 25]
x[3:1] #seleccion de elementos de forma inversa
x[-(1:2)] #remueve los dos primeros elementos
x[-length(x)] #remueve el elemento equivalente a la posición señalada

w <- table(iris$Species)
w["setosa"]
w[c("setosa", "virginica")]

my.iris <- iris
colnames(my.iris)[5] <- "Especie"
colnames(my.iris)

z <- table(iris$Species)
names(z)
names(z)[1] <- "Tipo 1"
names(z)

z <- 1:10
z
z[z < 5] <- 100
z

x <- 1:10
x
sample(x,4)
sample(x,50)
sample(x, 50, replace = TRUE)
#--------------------------------------------------------------------------
#   6.3.Creación de funciones
#--------------------------------------------------------------------------
x <- 1:10
mean(x)
max(x)
median(x)
sum(x)
prod(x)

#       Función suma de cuadrados

x <- 1:10
suma_cuadrados <- function(x) sum(x*x)
suma_cuadrados(x)

#       Función media

media <- function(x){
  longitud <- length(x)
  suma <- sum(x)
  suma / longitud
}
#--------------------------------------------------------------------------
#   6.4.La función tapply
#--------------------------------------------------------------------------
tapply(iris$Petal.Length, iris$Species, mean)
#--------------------------------------------------------------------------
# 7. Creación de Listas
#--------------------------------------------------------------------------
is.list(iris)

#   ➢ Creación de listas

x <- list("a" = 2.5, "b" = TRUE, "c" = 1:3)
x

typeof(x)
length(x)

str(x)

x <- list(2.5,TRUE,1:3)
x

#   ➢ Accediendo a los componentes de una lista

x <- list(name = "John", age = 19, speaks = c("English", "French"))
x

#     a) Índice usando un vector entero
x[c(1:2)]

#     b) Usando un entero negativo para excluir el segundo componente
x[-2]

#     c) Índice usando vector lógico
x[c(T,F,F)]

#     d) Índice usando vector de caracteres
x[c("age","speaks")]

#   ➢ Modificando los componentes de una lista
x[["name"]] <- "Patricia"; x

#   ➢ Adicionando componentes a una lista
x[["married"]] <- TRUE
x

#   ➢ Eliminando componentes a una lista
x[["age"]] <- NULL
str(x)
x$married <- NULL
str(x)
#--------------------------------------------------------------------------

#------------------------VISUALIZACION GRAFICA------------------------
#--------------------------------------------------------------------------
# 1. Gráficos básicos en R
#--------------------------------------------------------------------------
#   1.1. Gráfica de variables continuas
hist(iris$Sepal.Width)

hist(iris$Sepal.Width, main = "Iris: Histograma de la anchura de los sépalos", xlab = "anchura del sépalo", ylab = "frecuencia",col = "steelblue")

#   1.2. Gráfica de variables categóricas
barplot(table(iris$Species))

#   1.3. Gráfica de la relación entre dos variables continuas
plot(iris$Petal.Length, iris$Petal.Width, main="Edgar Anderson's Iris Data")

#   1.4. Gráfica de la relación entre una variable continua y otra categórica
boxplot(iris$Sepal.Width ~ iris$Species, col = "gray", main = "Especies de iris\nsegún la anchura del sépalo")
#--------------------------------------------------------------------------




