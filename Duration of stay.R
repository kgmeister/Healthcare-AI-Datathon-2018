setwd("C:/Programs and stuff/R Projects/Datathon 2019")
install.packages ('tidyverse')
library ('tidyverse')
library (lubridate)
#Loading the inpatient dataset
inpatient<- read.csv("inpatientcase.csv")

head (inpatient)


#Creating the patient ID, admission date/time, discharge date time dataframe
Adm_Disc_Stay <- inpatient[, c('case_no', 'adm__datetime', 'dis_datetime')]

#Removing the "UTC" in admission and discharge date/times
gsub("e", "", Adm_Disc_Stay)

head (Adm_Disc_Stay)
Adm_Disc_Stay
Adm_Disc_Stay ['8C53B0178',]

#Removing rows containing NA
Adm_Disc_Stay <- Adm_Disc_Stay %>% drop_na()



duration <- Adm_Disc_Stay$'dis_datetime' %--% Adm_Disc_Stay$'adm__datetime'
