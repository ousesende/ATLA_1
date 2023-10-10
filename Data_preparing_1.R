##### ARRANGE DATA #######

#Install Packages needed

R.Version()
install.packages(c("devtools","usethis","zoo","naniar"))
install.packages('tidyverse', repos='https://cloud.r-project.org')
devtools::install_github('ohi-science/ohicore')

library(ohicore)
library("usethis")
library("tidyverse")
library("devtools")
library("zoo")
library("naniar")


    #Upload datasets, IMPORTANT! add na.string to identify different characters used as missing data

IGE_tourism<-read.csv('C:/Users/Antía/Documents/R/ATLA_1/DATA/IGE_Tourist_26072023.csv',na.strings = c("", "..","NA"))
try_IGE_tourism_2<-read.csv('C:/Users/Antía/Documents/R/ATLA_1/DATA/IGE_Tourist_26072023_M_R.csv',na.strings = c("", "..","NA"))
try_IGE_tourism<-read.csv('C:/Users/Antía/Documents/R/ATLA_1/DATA/try_IGE_tourism.csv',na.strings = c("", "..","NA"), sep=";")


    # Change column names and remove  X.2

names(try_IGE_tourism_2)[names(try_IGE_tourism_2) == "Ano"] <- "Ano"
names(try_IGE_tourism_2)[names(try_IGE_tourism_2) == "Tipo.aloxamento"] <- "Tipo_Aloxamento"
names(try_IGE_tourism_2)[names(try_IGE_tourism_2) == "X"] <- "Area"
names(try_IGE_tourism_2)[names(try_IGE_tourism_2) == "X.1"] <- "Codigo"
names(try_IGE_tourism_2)[names(try_IGE_tourism_2) == "Establecementos"] <- "Numero_Establecementos"

try_IGE_tourism_2<-subset(try_IGE_tourism_2,select = - X.2)


names(try_IGE_tourism)[names(try_IGE_tourism) == "Ano"] <- "Tipo_Aloxamento"
names(try_IGE_tourism)[names(try_IGE_tourism) == "Numero_Establecementos"] <- "Ano"
names(try_IGE_tourism)[names(try_IGE_tourism) == "X"] <- "Codigo" 
names(try_IGE_tourism)[names(try_IGE_tourism) == "Area"] <- "Numero_Establecementos"
names(try_IGE_tourism)[names(try_IGE_tourism) == "Codigo"] <- "Area"

try_IGE_tourism<-subset(try_IGE_tourism,select = - Tipo_Aloxamento)


#Fill in empty spaces

    #replace NA by blank spaces

try_IGE_tourism[is.na(try_IGE_tourism)]<-""


    #METHOD 1 - define function and use it (USED)
        #****Codigo funcinou nalgún intento, pero non sei todavia como/porque? Porque para empregar a funcion filltheblanks a variable ten que ser character non numerica

fillTheBlanks <- function(try_IGE_tourism, missing=""){
  rle <- rle(as.character(try_IGE_tourism))
  empty <- which(rle$value==missing)
  rle$values[empty] <- rle$value[empty-1] 
  inverse.rle(rle)
}


try_IGE_tourism$Tipo_Aloxamento<-fillTheBlanks(try_IGE_tourism$Tipo_Aloxamento)
try_IGE_tourism$Area<-fillTheBlanks(try_IGE_tourism$Area)

try_IGE_tourism$Codigo<-as.character(try_IGE_tourism$Codigo)
try_IGE_tourism$Codigo<-fillTheBlanks(try_IGE_tourism$Codigo)

write.table(try_IGE_tourism,"try_IGE_tourism.csv",sep=";",row.names = TRUE)


###FILTER OUT MIXED ROWS

#METHOD 1: dlpyr

library(dplyr)
filter(try_IGE_tourism, try_IGE_tourism$Ano %in% c("2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","2017","2018","2019","2020","2021","2022"))

#METHOD 2: Remove rows with empty cells with a loop (NON FURRULA)

# declaring an empty vector to store
# the rows with all the blank values
vec <- c()

# looping the rows
for (i in 1:nrow(try_IGE_tourism)){
  
  # counter for blank values in
  # each row
  count = 0
  
  # looping through columns
  for(j in 1:ncol(try_IGE_tourism)){
    
    # checking if the value is blank
    if(isTRUE(try_IGE_tourism[i,j] == "")){
      count = count + 1
    }
    
  }
  
  # if count is equivalent to number
  # of columns
  if(count == ncol(try_IGE_tourism)){
    
    # append row number
    vec <- append(vec,i)
  }
}

summary(try_IGE_tourism)

# deleting rows using index in vector (TAMPOUCO FURRULA)
Mod_try_IGE_tourism <- try_IGE_tourism[ -vec, ]
print ("Modified dataframe")
print (data_frame_mod)

