install.packages("rvest")
install.packages("xml")
install.packages("XML")

library(rvest)
library(xml)
library(XML)

#-----------------------------------------CASO 1-----------------------------------------
#---------------------------------------------------------------------------------------------------------------------------
# a) Creamos la variable con el URL
upc_url <- 'https://pregrado.upc.edu.pe/facultad-de-ingenieria/ciencias-de-la-computacion/'

# b) Leemos cada línea de la pagina
upc_read <- readLines(upc_url, encoding = "UTF-8", warn = FALSE)

# c) Analizamos el contenido de la pagina
parsed_upc <- htmlParse(upc_read, encoding = "UTF-8")

# d) Identificamos los ‘párrafos’ de la pagina
upc_enter_text <- parsed_upc["//p"]

# e) Averiguamos cuantos párrafos existen en la pagina
length(upc_enter_text)

# f) Visualizamos el contenido de alguno de los párrafos
upc_enter_text [[10]]

# g) Averiguamos cuantos enlaces tiene la pagina
length(getHTMLLinks(upc_read))

# h) Averiguamos cuantas tablas tiene la pagina
length((readHTMLTable(upc_read)))

#---------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------Caso 2-----------------------------------------
#---------------------------------------------------------------------------------------------------------------------------
wiki_url <- 'https://es.wikipedia.org/wiki/Ayuda:Tablas'
wiki_read <- readLines(wiki_url, encoding = "UTF-8", warn = FALSE)
parsed_wiki <- htmlParse(wiki_read, encoding = "UTF-8")
wiki_intro_text <- parsed_wiki["//p"]
length(wiki_intro_text)

length(getHTMLLinks(wiki_read))

length((readHTMLTable(wiki_read)))

names(readHTMLTable(wiki_read))

readHTMLTable(wiki_read)$"Una tabla ejemplo\n"

#---------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------Caso 3-----------------------------------------
#---------------------------------------------------------------------------------------------------------------------------

# a) Cargamos los paquetes rvest y xml2
library(xml2)
library(rvest)

# b) Especificamos la URL que deseamos analizar, utilizando la instrucción read_html leemos el código HTML
pelis <- read_html("https://www.imdb.com/search/title/?count=100&release_date=2020,2020&title_type=feature")

# c) Obtenemos primero la clasificación (ranking de la película).
#   ➢ Usamos el selector CSS para raspar la seccion de Ranking. A la instrucción html_nodes le especificamos que selector CSS queremos recuperar.
rank_data_html <- html_nodes(pelis,'.text-primary')

#   ➢ Convertimos a texto los datos de ranking recuperados y los visualizamos:
rank_data <- html_text(rank_data_html)
head(rank_data)

#   ➢ Pre-procesamos estos datos convirtiendolos a numericos
rank_data<-as.numeric(rank_data)
head(rank_data)

# d) Obtenemos ahora los títulos de la película.
#   ➢ Constatamos que el selector se llama “.lister-item-header a”, entonces, obtenemos los datos correspondientes a ese clasificador con la instrucción html_nodes() y vemos su contenido.
tit_data_html <- html_nodes(pelis,'.lister-item-header a')
tit_data <- html_text(tit_data_html)
head(tit_data)

# e) Obtenemos la descripción de la película
desc_data_html <- html_nodes(pelis,'.ratings-bar+ .text-muted')
desc_data <- html_text(desc_data_html)
head(desc_data)

#   ➢ Pre-procesado: Eliminamos “\n” en cada párrafo.
desc_data <- gsub("\n","",desc_data)
head(desc_data)

# f) Obtenemos la duración de la película
runtime_data_html <- html_nodes(pelis,'.text-muted .runtime')
runtime_data <- html_text(runtime_data_html)
head(runtime_data)

#   ➢ Pre-procesado: Eliminamos “min” en cada elemento de la lista y lo convertimos a numerico.
runtime_data<-gsub(" min","",runtime_data)
runtime_data<-as.numeric(runtime_data)
head(runtime_data)

# g) Obtenemos el género de la película
genre_data_html <- html_nodes(pelis,'.genre')
genre_data <- html_text(genre_data_html)
head(genre_data)

#   ➢ Pre-procesado: Eliminamos “min” en cada elemento de la lista y lo convertimos a numerico.
genre_data<-gsub("\n","",genre_data)
head(genre_data)

#   ➢ Pre-procesado: Eliminamos los espacios en blanco en exceso.
genre_data<-gsub(" ","",genre_data)
head(genre_data)

#   ➢ Pre-procesado: Tomamos solo el primer genero de cada pelicula.
genre_data<-gsub(",.*","",genre_data)
head(genre_data)

#   ➢ Pre-procesado: Convertimos cada texto de genero a factor.
genre_data<-as.factor(genre_data)
head(genre_data)

# h) Obtenemos la calificación de la película
rating_data_html <- html_nodes(pelis,'.ratings-imdb-rating strong')
rating_data <- html_text(rating_data_html)
head(rating_data)

#   ➢ Pre-procesado: Convertimos cada texto a numero.
rating_data<-as.numeric(rating_data)
head(rating_data)

# i) Obtenemos el metascore de la película
metascore_data_html <- html_nodes(pelis,'.metascore')
metascore_data <- html_text(metascore_data_html)
head(metascore_data)

#   ➢ Pre-procesado: Eliminamos los espacios en blanco en exceso y convertimos a numerico.
metascore_data<-gsub(" ","",metascore_data)
head(metascore_data)
length(metascore_data)
metascore_data<-as.numeric(metascore_data)
head(metascore_data)

# j) Obtenemos los votos obtenidos por la película
votos_data_html <- html_nodes(pelis,'.sort-num_votes-visible span:nth-child(2)')
votos_data <- html_text(votos_data_html)
head(votos_data)

#   ➢ Pre-procesado: Removemos las comas y convertimos a numerico
votos_data<-gsub(",","",votos_data)
votos_data<-gsub(",","",votos_data)
head(votos_data)

# k) Obtenemos el Gross_Earning_in_Mil de la película
gross_data_html <- html_nodes(pelis,'.ghost~ .text-muted+ span')
gross_data <- html_text(gross_data_html)
head(gross_data)

#   ➢ Pre-procesado: Eliminamos los signos $ y M y convertimos a numerico.
gross_data<-gsub("M","",gross_data)
gross_data<-substring(gross_data,2,6)
head(gross_data)
length(gross_data)
gross_data<-as.numeric(gross_data)
head(gross_data)

# l) Obtenemos el director de la película
director_data_html <- html_nodes(pelis,'.text-muted+ p a:nth-child(1)')
director_data <- html_text(director_data_html)
head(director_data)

#   ➢ Pre-procesado: Convertimos cada director a factor.
director_data<-as.factor(director_data)
head(director_data)

# m) Obtenemos el actor de la película
actor_data_html <- html_nodes(pelis,'.lister-item-content .ghost+ a')
actor_data <- html_text(actor_data_html)
head(actor_data)

#   ➢ Pre-procesado: Convertimos cada actor a factor.
actor_data<-as.factor(actor_data)
head(actor_data)

#---------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------Almacenamiento del dataset obtenido-----------------------------------------
#---------------------------------------------------------------------------------------------------------------------------
pelis_df<-data.frame(Rank = rank_data, Titulo = tit_data, Runtime = runtime_data, Genero = genre_data, Director = director_data, Actor = actor_data)
str(pelis_df)
write.csv(pelis_df,'pelis_df.csv', row.names = TRUE)

#---------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------Visualización de los datos-----------------------------------------
#---------------------------------------------------------------------------------------------------------------------------

# 1)

library('ggplot2')
qplot(data = pelis_df,Runtime,fill = Genero,bins = 30, main="Pelicula: Duracion vs Genero")

#   Pregunta: 
#     ¿Que podemos inferir a partir de esta visualización?
#       La mayoría de las películas ptienen una duración entre 100 a 125 minutos.

#     ¿Qué géneros de películas tienen una duración menor a 100 minutos? 
#       Principalmente películas de comedia, algunas de acción, horror y drama.

#     ¿Cuáles más de 120 minutos?
#       Películas de drama, biografías, alguna de accióny una que otra de horror.

# 2)

tot_pelis <- table(pelis_df$Genero)
tot_pelis

head(tot_pelis)

barplot(tot_pelis,main="Distribucion de Peliculas segun Genero",xlab="Genero",ylab="Total Peliculas")

#   Pregunta: 
#     ¿Qué genero de película fue la que tuvo mayores estrenos?
#       Las peliculas de acción son las más estrenadas.

#     ¿Cuál genero fue el menos producido?
#       Los géneros menos producidos son los de fantasía, misterio y trhiller.







