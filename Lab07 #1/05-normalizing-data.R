#-----------------------------------------------------------------------------------------------------
# 2. Normalización / estandarización de datos
#-----------------------------------------------------------------------------------------------------
casas <- read.csv("BostonHousing.csv")
View(casas)

#Caso#1: Normalización ajustando al promedio y desviación típica

casas.z <- scale(casas)
View(casas.z)

#Caso #2: Normalización ajustando al promedio (center = TRUE y scale = FALSE)

casas.mean <- scale(casas, center = TRUE, scale = FALSE)
View(casas.mean)

#Caso #3: Normalización ajustando a la desviación típica o estándar (center = FALSE y scale = TRUE)

casas.sd <- scale(casas, center = FALSE, scale = TRUE)
View(casas.sd)


#Normalización de más de una variable conservando las variables originales
#-----------------------------------------------------------------------------------------------------

normalizar.cols <- function(df, cols){
  nombres <- names(df)
    for (col in cols){
    nombre <- paste(nombres[col], "z", sep = ".")
    df[nombre]<- scale(df[,col])
    }
  cat(paste("Hemos normalizado ", length(cols), " variable(s)"))
  df
}

casas <- normalizar.cols(casas, c(1,3,5:8))

View(casas)











