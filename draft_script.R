##### ARRANGE DATA #######

#Install Packages needed
R.Version()
install.packages(c("devtools","usethis","zoo","naniar","dplyr"))

install.packages("zoo")
install.packages('tidyverse', repos='https://cloud.r-project.org')
library("usethis")
library("tidyverse")
library("devtools")

devtools::install_github('ohi-science/ohicore')
library(ohicore)

installed.packages()

#Upload datasets, IMPORTANT! add na.string to identify different characters used as missing data

IGE_tourism<-read.csv('C:/Users/Antía/Documents/R/ATLA_1/DATA/IGE_Tourist_26072023.csv',na.strings = c("", "..","NA"))
head(IGE_tourism)
View(IGE_tourism)


try_IGE_tourism<-read.csv('C:/Users/Antía/Documents/R/ATLA_1/DATA/IGE_Tourist_26072023_M_R.csv',na.strings = c("", "..","NA"))

head(try_IGE_tourism)
View(try_IGE_tourism)
names(try_IGE_tourism)


file.show('C:/Users/Antía/Documents/R/ATLA_1/DATA/IGE_Tourist_26072023.csv')


# Change column names and remove  X.2

names(try_IGE_tourism)[names(try_IGE_tourism) == "Ano"] <- "Ano"
names(try_IGE_tourism)[names(try_IGE_tourism) == "Tipo.aloxamento"] <- "Tipo_Aloxamento"
names(try_IGE_tourism)[names(try_IGE_tourism) == "X"] <- "Area"
names(try_IGE_tourism)[names(try_IGE_tourism) == "X.1"] <- "Codigo"
names(try_IGE_tourism)[names(try_IGE_tourism) == "Establecementos"] <- "Numero_Establecementos"

try_IGE_tourism<-subset(try_IGE_tourism,select = - X.2)


######Fill in empty spaces

#replace NA by blank spaces

try_IGE_tourism[is.na(try_IGE_tourism)]<-""


#METHOD 1
#define function and use it (USED)
#****Codigo funcinou nalgún intento, pero non sei todavia como/porque? Codigo ten que ser de tipo caracter

fillTheBlanks <- function(try_IGE_tourism, missing=""){
  rle <- rle(as.character(try_IGE_tourism))
  empty <- which(rle$value==missing)
  rle$values[empty] <- rle$value[empty-1] 
  inverse.rle(rle)
}

str(try_IGE_tourism)

try_IGE_tourism$Tipo_Aloxamento<-fillTheBlanks(try_IGE_tourism$Tipo_Aloxamento)
try_IGE_tourism$Area<-fillTheBlanks(try_IGE_tourism$Area)

try_IGE_tourism$Codigo<-as.numeric(try_IGE_tourism$Codigo)
try_IGE_tourism$Codigo<-fillTheBlanks(try_IGE_tourism$Codigo)

View(try_IGE_tourism)

#(NON EMPREGADO) METHOD 2:Package zoo

library(zoo)

try_IGE_tourism$Tipo.aloxamento[try_IGE_tourism$Tipo.aloxamento == ""] <- NA
try_IGE_tourism$Tipo.aloxamento <- na.locf(try_IGE_tourism$Tipo.aloxamento)
try_IGE_tourism$Codigo[try_IGE_tourism$Codigo == ""] <- NA
try_IGE_tourism$Codigo <- na.locf(try_IGE_tourism$Codigo)

str(try_IGE_tourism$Codigo)

head(try_IGE_tourism)

# (NON EMPREGADO) Find NA


library(naniar)

try_IGE_tourism%>%replace_with_na(replace = list(Tipo_Aloxamento=".."))
try_IGE_tourism%>%replace_with_na(replace = list(Ano=".."))
try_IGE_tourism%>%replace_with_na(replace = list(Numero_Establecementos=".."))
try_IGE_tourism%>%replace_with_na(replace = list(Tipo_Aloxamento=""))
try_IGE_tourism%>%replace_with_na(replace = list(Ano=""))
try_IGE_tourism%>%replace_with_na(replace = list(Numero_Establecementos=""))

summary(try_IGE_tourism)


###(NON EMPREGADO )FILTER OUT MIXED ROWS

#METHOD 1: dlpyr

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



###plot








######   PLAY AREA #################


is.nan(try_IGE_tourism$Numero_Establecementos)


data<-try_IGE_tourism[which(try_IGE_tourism$Ano == ''& try_IGE_tourism$)]
view(data)

try_IGE_tourism[try_IGE_tourism==".."]<-"NA"


try<-na.omit(try_IGE_tourism$Codigo)

try_IGE_tourism$COD<-NA
try_IGE_tourism$COD<-fillTheBlanks(try_IGE_tourism$Codigo)



usethis::create_from_github(repo_spec = "https://github.com/ousesende/ATLA_1.git",destdir = "~/Documents/R/ATLA_1/")

here::dr_here()



