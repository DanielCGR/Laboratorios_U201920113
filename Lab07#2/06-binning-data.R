
# APLICANDO LIMPIEZA DE DATOS EN R/RSTUDIO
#--------------------------------------------------------------------------------------------------------------------------

#   1. Categorización de datos numéricos
#--------------------------------------------------------------------------------------------------------------------------

estudiantes <- read.csv("data-conversion.csv")

niveles <- c(-Inf, 10000, 31000, Inf)
nom.nivel <- c('Bajo', 'Medio', 'Alto')

estudiantes$Income.cat <- cut(estudiantes$Income, breaks = niveles, labels = nom.nivel)

View(estudiantes)

str(estudiantes)

estudiantes$Income.cat2 <- cut(estudiantes$Income, breaks = 4,labels = c("Nivel 1", "Nivel 2", "Nivel 3", "Nivel 4"))

View(estudiantes)
#--------------------------------------------------------------------------------------------------------------------------

#     Variables ficticias para categorizaciones
#--------------------------------------------------------------------------------------------------------------------------
estudiantes <- read.csv("data-conversion.csv")

install.packages("fastDummies")
library(fastDummies)

dummyestudiantes <- dummy_cols(estudiantes, select_columns = c("State", "Gender"), remove_selected_columns = TRUE)

names(dummyestudiantes)

View(dummyestudiantes)

dummy_cols(estudiantes$State)

dummy_cols(estudiantes, select_columns = c("State"), remove_selected_columns = TRUE)

dummy_cols(estudiantes, select_columns = c("State", "Gender"), remove_selected_columns = TRUE)
#--------------------------------------------------------------------------------------------------------------------------

#   2. Detección y corrección de valores atípicos
#--------------------------------------------------------------------------------------------------------------------------
ozone.data <- read.csv("ozone.csv", stringsAsFactors = FALSE)

outliers.values <- boxplot(ozone.data$pressure_height)$out

outliers.values

summary(ozone.data$pressure_height)

boxplot(ozone.data$pressure_height, main = "Pressure Heigh", boxwex = 0.5)

boxplot(pressure_height ~ Month, data = ozone.data, main = "Pressure Height per Month")

boxplot(ozone_reading ~ Month, data = ozone.data, main = "Ozone reading per Month")

boxplot(ozone_reading ~ Month, data = ozone.data, main = "Ozone reading per Month")$out
#--------------------------------------------------------------------------------------------------------------------------

#     Corrección de valores atípicos
#--------------------------------------------------------------------------------------------------------------------------

#       Caso #1: Cambio de outliers por el promedio y/o la mediana
#--------------------------------------------------------------------------------------------------------------------------
fix_outliers <- function(x, removeNA = TRUE){
  #Calculamos los quantiles 1) por arriba del 5% y por debajo del 95%
  quantiles <- quantile(x, c(0.05, 0.95), na.rm = removeNA)
  x[x<quantiles[1]] <- mean(x, na.rm = removeNA)
  x[x>quantiles[2]] <- median(x, na.rm = removeNA)
  x
}

sin.outliers <- fix_outliers(ozone.data$pressure_height)

par(mfrow = c(1,2))
boxplot(ozone.data$pressure_height, main = "Presión con Outliers")
boxplot(fix_outliers(ozone.data$pressure_height), main = "Presión sin Outliers")
#--------------------------------------------------------------------------------------------------------------------------

#       Caso #2: Cambio de outliers enmascarando sus valores (capping) 
#--------------------------------------------------------------------------------------------------------------------------
replace_outliers <- function(x, removeNA = TRUE){
  qrts <- quantile(x, probs = c(0.25, 0.75), na.rm = removeNA)
  # si el outlier esta por debajo del cuartil 0.5 o por arriba de 0.95
  caps <- quantile(x, probs = c(.05, .95), na.rm = removeNA)
  # Calculamos el rango intercuartilico
  iqr <- qrts[2]-qrts[1]
  # Calculamos el 1.5 veces el rango intercuartiligo (iqr)
  altura <- 1.5*iqr
  #reemplazamos del vector los outliers por debajo de 0.05 y 0.095
  x[x<qrts[1]-altura] <- caps[1]
  x[x>qrts[2]+altura] <- caps[2]
  x
}

par(mfrow = c(1,2))
boxplot(ozone.data$pressure_height, main = "Presión con Outliers")
boxplot(replace_outliers(ozone.data$pressure_height), main = "Presión sin Outliers")
#--------------------------------------------------------------------------------------------------------------------------

#   3. Crear ficheros de datos
#--------------------------------------------------------------------------------------------------------------------------

#     Caso #1: Crear y cargar ficheros Rdata y rds
#--------------------------------------------------------------------------------------------------------------------------
clientes <- c("Arturo", "Bill", "Jack")
fechas <- c("2021-05-01", "2021-04-28", "2021-03-30")
pagos <- c(315.1, 205.4,450.2)

fechas <- as.Date(c("2021-05-01", "2021-04-28", "2021-03-30"))

pedidos <- data.frame(clientes, fechas, pagos)

View(pedidos)
#--------------------------------------------------------------------------------------------------------------------------

#       Ficheros RData
#--------------------------------------------------------------------------------------------------------------------------
save(pedidos, file = "pedidos.Rdata")

cliente.frec <- c("Arturo", "Jack")
save(pedidos, cliente.frec, file = "pedidos.Rdata")

save.image(file = "alldata.Rdata" )
#--------------------------------------------------------------------------------------------------------------------------

#       Ficheros rds
#--------------------------------------------------------------------------------------------------------------------------
saveRDS(pedidos, file = "pedidos.rds")
#--------------------------------------------------------------------------------------------------------------------------

#       Eliminación de objetos del ambiente global
#--------------------------------------------------------------------------------------------------------------------------
remove(pedidos)
#--------------------------------------------------------------------------------------------------------------------------


#       Carga de archivos RData y rds
#--------------------------------------------------------------------------------------------------------------------------
load("pedidos.RData")

attach("pedidos.RData")

orders <- readRDS("pedidos.rds")
#--------------------------------------------------------------------------------------------------------------------------

#     Caso #2: Crear un fichero CSV a partir de un dataframe
#--------------------------------------------------------------------------------------------------------------------------
write.csv(pedidos,'pedidos.csv', na="NA",row.names=FALSE)

write.csv(pedidos,'pedidos2.csv', na="NA")
#--------------------------------------------------------------------------------------------------------------------------




















