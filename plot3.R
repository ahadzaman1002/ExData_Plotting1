setwd("D:/Coursera/Explor_analysis")

library(tidyverse)
library(lubridate)


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


# ADDING DATE TIME TO THE DATA- 
sub_dta <- sub_dta %>% 
  mutate( date_time =     
            strptime(paste(Date, Time, sep=" "), "%Y-%m-%d %H:%M:%S"))



# GENERATING PLOT-
plot3 <- 
  sub_dta %>%
  ggplot(aes(x = ymd_hms(date_time)  )) +
  geom_line(aes(y = as.numeric(Sub_metering_1), color = "Sub_metering_1")  ) +
  geom_line(aes(y = as.numeric(Sub_metering_2), color = "Sub_metering_2")  ) +
  geom_line(aes(y = as.numeric(Sub_metering_3), color = "Sub_metering_3")  ) +
    scale_color_manual(values=c("black", "red", "blue"))+
  theme_classic() +
  theme( legend.position = c(0.85, 0.8)) +
  ylab("Energy sub metering") +
  xlab("Time of the day")
  
  


ggsave(filename = "./week1/plot3.png", plot = plot3, 
       width=480, height=480, units = "px") 


