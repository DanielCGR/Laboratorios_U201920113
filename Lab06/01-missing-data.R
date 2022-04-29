#-----------------Eliminar datos sin valor-----------------

data <- read.csv("missing-data.csv", na.strings = "" )
data.limpia <- na.omit(data)

is.na(data[4,2])
is.na(data[4,1])
is.na(data$Income)

#----------------Limpieza selectiva de datos sin valor----------------
#-----------------------Caso#1-----------------------
data.income.limpio <- data[!is.na(data$Income),]

#-----------------------Caso#2-----------------------
complete.cases(data)
data.limpia2 <- data[complete.cases(data),]

#-----------------------Caso#3-----------------------
data$Income[data$Income == 0]
data$Income[data$Income == 0] <- NA
data$Income[data$Income == 0]

#-----------------------Caso#4-----------------------
mean(data$Income)
mean(data$Income, na.rm=TRUE)

sd(data$Income)
sd(data$Income, na.rm=TRUE)

sum(data$Income)
sum(data$Income, na.rm=TRUE)
