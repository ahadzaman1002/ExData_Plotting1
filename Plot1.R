setwd("D:/Coursera/Explor_analysis")

library(tidyverse)



list.files()


unzip("exdata_data_household_power_consumption.zip", list = TRUE)

# READING DATA FILE
dta <- 
  read.table(unz("exdata_data_household_power_consumption.zip", 
                 "household_power_consumption.txt"),
             header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")




head(dta)
str(dta)

length(unique(dta$Date))
unique(dta$Date)

# SUBSETTING DATA FILE

sub_dta <- dta %>% 
  mutate( Date =    format(as.Date(Date, "%d/%m/%Y"), "%Y-%m-%d")  
          ) %>% 
  filter(Date %in% c("2007-02-01", "2007-02-02")   )
  

str(sub_dta)

plot1 <-
sub_dta %>% 
  ggplot(aes(x =as.numeric(Global_active_power)) )+
  geom_histogram(color = "black", fill = "red", binwidth = 0.85 ) +
  theme_classic() +
  xlab("Global Active Power (kilowatts)") +
  ylab("Frequency") +
  ggtitle("Global Active power")


ggsave(filename = "./week1/plot1.png", plot = plot1, 
       width=480, height=480, units = "px")  







  



