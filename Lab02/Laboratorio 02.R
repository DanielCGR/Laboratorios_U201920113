
#------------------------CARGAR DATOS------------------------

titanic_data <- read.csv ("titanic_data.csv", header= TRUE, sep = ",")

#------------------------INSPECCIONAR DATOS------------------------

#ver contenido
View(titanic_data)

#ver filas iniciales
head(titanic_data,10)

#ver filas finales
tail(titanic_data,10)

#ver variables
names(titanic_data)

#ver estructura del conjunto de datos
str(titanic_data)

#ver resumen y estadisticas
summary(titanic_data)

#Convertir a factor
titanic_data$Survived <- as.factor(titanic_data$Survived)
titanic_data$Pclass <- as.factor(titanic_data$Pclass)
titanic_data$Sex <- as.factor(titanic_data$Sex)
titanic_data$Embarked <- as.factor(titanic_data$Embarked)
str(titanic_data)

#------------------------LIMPIEZA DE DATOS------------------------

#funcion sin_valor(dataframe) que desliega cuantos valores NA posee cada variable
sin_valor <- function(x){
  sum = 0
  for(i in 1:ncol(x))
  {
    cat("En la columna",colnames(x[i]),"total de valores NA:",colSums(is.na(x[i])),"\n")
  }
}

sin_valor(titanic_data)

#funcion en_blanco(dataframe) que desliega cuantos valores en blanco posee cada variable
en_blanco <- function(x){
  sum = 0
  for(i in 1:ncol(x))
  {
    cat("En la columna",colnames(x[i]),"total de valores en blanco:",colSums(x[i]==""),"\n")
  }
}

en_blanco(titanic_data)

# Investiguemos que pasajeros tienen en blanco el atributo Embarked
titanic_data$PassengerId[titanic_data$Embarked == ""]

# Verifiquemos ahora en que clase viajaban dichos pasajeros y cuanto les costó el boleto
titanic_data$Pclass[titanic_data$PassengerId == 62]
titanic_data$Fare[titanic_data$PassengerId == 62]
titanic_data$Pclass[titanic_data$PassengerId == 830]
titanic_data$Fare[titanic_data$PassengerId == 830]

#Creamos un nuevo dataset que no contenga a esos dos pasajeros

library(dplyr)

embark_fare <- titanic_data %>% filter(PassengerId != 62 & PassengerId != 830)

#Usamos la librería ggplot2 y scales para graficar el precio (Fare) medio que costó un boleto por clase (Pclass) y puerto de embarque (embarked).

library(ggplot2)
library(scales)

ggplot(data = embark_fare, aes(x = Embarked, y = Fare, fill = factor(Pclass))) +
  geom_boxplot() +
  geom_hline(aes(yintercept = 80),
             colour = "red", linetype = "dashed", lwd = 2) +
  scale_y_continuous(labels = dollar_format()) +
  theme_bw()

titanic_data$Embarked[c(62, 830)] <- "C"

#----NOTA----
is.na(titanic_data$Age)
titanic_data$Age <- ifelse(is.na(titanic_data$Age), mean(titanic_data$Age, na.rm = TRUE), titanic_data$Age)
titanic_data$Age <- as.integer(titanic_data$Age)


#------------------------VISUALIZACION GRAFICA------------------------

#Sobrevivencia de Pasajeros del Titanic: Más pasajeros murieron que los que sobrevivieron

table(titanic_data$Survived)

barplot(table(titanic_data$Survived), main="Pasajeros en Titanic", names= c("Murieron", "Sobrevivieron"))

prop.table(table(titanic_data$Survived))

#Pasajeros del Titanic por Clase: la tercera clase de pasajeros fue la más poblada, y por ende, la de costo por boleto más económico

barplot(table(titanic_data$Pclass), main="Pasajeros de Titanic por Clase", names= c("Primera", "Segunda", "Tercera"))

#Pasajeros del Titanic por Genero: existieron mucho más pasajeros hombres que mujeres.

table(titanic_data$Sex)
barplot(table(titanic_data$Sex), main="Pasajeros del Titanic por Genero", names= c("Mujer", "Hombre"))

#Sobrevivencia de Pasajeros por Genero: las mujeres tuvieron una mayor tasa de supervivencia que los hombres durante el naufragio. Explicado en parte por el protocolo de "mujeres y niños primero".

counts = table(titanic_data$Survived, titanic_data$Sex)
barplot(counts, col=c("green","yellow"), legend = c("Murieron", "Sobrevivieron"), main = "Sobreviviencia de Pasajeros por Genero")

#Sobrevivencia de Pasajeros por Clase: la primera clase tuvo una mayor tasa de supervivencia, acorde a la calidad/costo del pasaje, pero la suposición de personas adineradas que tienden a sobrevivir más puede que no ser tan veraz.

counts1 = table(titanic_data$Survived, titanic_data$Pclass) 
barplot(counts1, col=c("green","yellow"), legend = c("Murieron","Sobrevivieron"), main = "Sobreviviencia de Pasajeros por Clase", names= c("Primera", "Segunda", "Tercera"))


#------------------------CONCLUSIONES PRELIMINARES------------------------

# Solo el 38,38% de los pasajeros que abordaron el Titanic sobrevivieron.
# Abordaron muchos más pasajeros hombres que mujeres.
# La mayoría de pasajeros pertenecían a la tercera clase.
# Vemos que la tasa de supervivencia entre las mujeres fue significativamente mayor en comparación con los hombres. Explicado en parte por el protocolo de "mujeres y niños primero".