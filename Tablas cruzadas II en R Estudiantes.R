#### Refrencias utilizadas ####
# https://github.com/fdelaunay/tutorial-dplyr-es/blob/master/R/tutorial-dplyr.md

#Decisiones bajo incertidumbre en las organizaciones

#Análisis de datos para la toma de una decisión. Uso de tablas cruzadas

#Este ejercicio consiste en analizar los precios de la marihuana para uso
#recreativo en Estados Unidos

#Paso 1: Importar y cargar las librerías requeridas

install.packages("dplyr")
library(dplyr)

#Paso 2: Lectura de datos

#Lea los datos del archivo "Precios marihuana" y asígnelos a un objeto
#cuyo nombre sea "precios"

#Sugerencia: Aunque el archivo esté en formato .txt, es posible usar la función read.csv. 
#Asegurese de remover el signo $ de la columna Revenue y de
#Escriba el argumento header=TRUE para que R reconozca los encabezados del archivo.


precios <- read.csv("~/github/Tablas-Cruzadas-en-R---II/Precios marihuana.txt")

# path_file = file.choose()
# precios <- read.csv(path_file)


#Use las funciones filter, group_by y summarise de la librería dplyr para
#agrupar los datos y resolver las siguientes preguntas:

#Extraiga las filas correspondientes a los estados de California, New York e Illinois

Precios_Estados <- filter(precios, precios$state %in% c("California","New York","Illinois"))

#Muestre los datos de los tres estados para todas las calidades de marihuana

state_quality <- Precios_Estados %>% 
       group_by(state, quality) %>% 
       summarise(total_quality_score = sum(quality_score), 
                 total_amount = sum(amount),
                 total_price = sum(price))
View(state_quality)

#Muestre el precio promedio por onza (columna ppo) para cada calidad de marihuana, en cada uno de
#los tres #estados analizados

promedio_onza <- Precios_Estados %>% 
  group_by(quality,state) %>% 
  summarise(mean_price = mean(price), mean_ppo = mean(ppo))
View(promedio_onza)

#Presente este precio promedio en un documento

# Crear documento HTML con los precios promedio x onza 
knitr::knit2html(rmarkdown::render("promedios_precios_onza.Rmd"), stylesheet = 'mystyle.css')
# Arbir el archivo HTML creado en el navegador por defecto
htmlFile <- file.path("promedios_precios_onza.html")
rstudioapi::viewer(htmlFile)
