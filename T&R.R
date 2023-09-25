
###Upload datasets, add na.string to identify different characters used as missing data

emcoruna<-read.csv('C:/Users/Antía/Documents/R/ATLA_1/DATA/OHI/prep/TR/Emprego_Turismo_ACORUNA_iconv.csv', sep=";")
emlugo<-read.csv('C:/Users/Antía/Documents/R/ATLA_1/DATA/OHI/prep/TR/Emprego_Turismo_LUGO_iconv.csv', sep=";")
empontevedra<-read.csv('C:/Users/Antía/Documents/R/ATLA_1/DATA/OHI/prep/TR/Emprego_Turismo_PONTEVEDRA_iconv.csv', sep=";")


library(tidyr)

emcoruna<-separate(data= emcoruna, col = X , into=c("Ano","Mes"))
names(emcoruna)[names(emcoruna) == "X.1"] <- "Provincia"
emlugo<-separate(data= emlugo, col = X , into=c("Ano","Mes"))
names(emlugo)[names(emlugo) == "X.1"] <- "Provincia"
empontevedra<-separate(data= empontevedra, col = X , into=c("Ano","Mes"))
names(empontevedra)[names(empontevedra) == "X.1"] <- "Provincia"

###Does it make sense to merge datasets?
employm_merges<-merge(emcoruna,emlugo, by='Mes')

##ADD both hotels and rural tourism as one variable
class(emcoruna$Turismo.rural)
emcoruna$Hoteleiros<-as.numeric(emcoruna$Hoteleiros)
emcoruna$Turismo.rural<-as.numeric(emcoruna$Turismo.rural)
emcoruna$Total<-emcoruna$Hoteleiros + emcoruna$Turismo.rural

emlugo$Hoteleiros<-as.numeric(emlugo$Hoteleiros)
emlugo$Turismo.rural<-as.numeric(emlugo$Turismo.rural)
emlugo$Total<-emlugo$Hoteleiros + emlugo$Turismo.rural

empontevedra$Hoteleiros<-as.numeric(empontevedra$Hoteleiros)
empontevedra$Turismo.rural<-as.numeric(empontevedra$Turismo.rural)
empontevedra$Total<-empontevedra$Hoteleiros + empontevedra$Turismo.rural

emcoruna_tot<-aggregate(Total ~ Ano , emcoruna, sum)
emlugo_tot<-aggregate(Total ~ Ano , emlugo, sum)
empontevedra_tot<-aggregate(Total ~ Ano , empontevedra, sum)


emcoruna_tot$Provincia<-"A Coruña"
emlugo_tot$Provincia<-"Lugo"
empontevedra_tot$Provincia<-"Pontevedra"

employm_merges<-rbind(emcoruna_tot,emlugo_tot,empontevedra_tot)


## Prepare data for total employment

emtotal<-read.csv('C:/Users/Antía/Documents/R/ATLA_1/DATA/OHI/prep/TR/Afiliados_medios_mod.csv', sep=";")
emtotal<-separate(data= emtotal, col = Provincia , into=c("Codigo","Provincia"))

head(emtotal)
names(emtotal)[names(emtotal) == "Total.Regimenes.RG.RETA..TODAS.LAS.SECCIONES"] <- "Total_emplo"

emtotal<-aggregate(Total_emplo ~ Ano , emtotal, sum)
emtotal<-subset(emtotal,select = - (c(Periodo, REGIMEN.GENERAL.TODAS.LAS.SECCIONES, REG..ESP..AUTONOMOS.TODAS.LAS.SECCIONES)))


#Merge datasets and calculate proportion

               
Empleo_Tur <- merge(employm_merges, emtotal, by="Ano")
Empleo_Tur$Proporcion<-Empleo_Tur$Total/Empleo_Tur$Total_emplo



                
                
                
                
                
                
                
                
                
                
                
                
emtotal<-as.integer(emtotal$Provincia)
gsub('Coru','A Coruña', t , fixed = TRUE)




#Plotting to visualise

class(emcoruna$Total)

library(ggplot2)
ggcor<-ggplot(data=employm_merges,mapping = aes(x = Ano, y = Total))
ggcor2<-ggcor + geom_point()
ggcor3<-ggcor2 +  geom_smooth(method="lm")

coruplot<-plot(emourense$Total ,col="#70c1b3",las=2,pch=19, xlab="Ano", ylab = "Total" ,main="A Coruña",cex.main=2)
lines(predict(lm(emcoruna$Total)),col='brown')




## OURENSE

emourense<-read.csv('C:/Users/Antía/Documents/R/ATLA_1/DATA/OHI/prep/TR/Emprego_Turismo_OURENSE_iconv.csv', sep=";")
emourense<-separate(data= emourense, col = X , into=c("Ano","Mes"))
names(emourense)[names(emourense) == "X.1"] <- "Provincia"


emourense$Hoteleiros<-as.numeric(emourense$Hoteleiros)
emourense$Turismo.rural<-as.numeric(emourense$Turismo.rural)
emourense$Total<-emourense$Hoteleiros + emourense$Turismo.rural

emourense_tot<-aggregate(Total ~ Ano , emourense, sum)

emourense_tot$Provincia<-"Ourense"


