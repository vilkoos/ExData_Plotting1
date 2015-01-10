
# if needed run script plot0_load_data.R to create the dataframe pow
# str(pow) gives:
'2880 obs. of  9 variables:
$ Date                 : Date, format: "2007-02-01" "2007-02-01" "2007-02-01" "2007-02-01" ...
$ DateTime             : POSIXct, format: "2007-02-01 00:00:00" "2007-02-01 00:01:00" "2007-02-01 00:02:00" "2007-02-01 00:03:00" ...
$ Global_active_power  : num  0.326 0.326 0.324 0.324 0.322 0.32 0.32 0.32 0.32 0.236 ...
$ Global_reactive_power: num  0.128 0.13 0.132 0.134 0.13 0.126 0.126 0.126 0.128 0 ...
$ Voltage              : num  243 243 244 244 243 ...
$ Global_intensity     : num  1.4 1.4 1.4 1.4 1.4 1.4 1.4 1.4 1.4 1 ...
$ Sub_metering_1       : num  0 0 0 0 0 0 0 0 0 0 ...
$ Sub_metering_2       : num  0 0 0 0 0 0 0 0 0 0 ...
$ Sub_metering_3       : num  0 0 0 0 0 0 0 0 0 0 ...
'

#### open the png graphics device ##############
png(filename = "plot4.png", pointsize = 12)

#### make a 2 by 2 grid to put the four plots in #######
par(mfrow = c(2, 2))

#### make plot row 1, col 1 ##############
plot(pow$DateTime, pow$Global_active_power, 
     type= "l",
     xlab = "",
     ylab = "Global Active Power (kiloWatts)",
     main = ""
)

#### make plot row 1, col 2 ##############
plot(pow$DateTime, pow$Voltage, 
     type= "l",
     xlab = "datetime",
     ylab = "Voltage",
     main = ""
)

#### make plot row 2, col 1 ##############
plot( pow$DateTime, pow$Sub_metering_1,
      type= "l",
      col = "black",
      xlab = "",
      ylab = "Energy sub metering",
      main = ""
)
lines(pow$DateTime, pow$Sub_metering_2,
      col = "red"
)
lines(pow$DateTime, pow$Sub_metering_3,
      col = "blue"
)
legend("topright", 
       lty    = c(1,1,1),
       lwd    = c(2.5,2.5,2.5),
       col    = c("black","red","blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty    = "n"
)

#### make plot row 2, col 2 ##############
plot(pow$DateTime, pow$Global_reactive_power, 
     type= "l",
     xlab = "datetime",
     ylab = "Global_reactive_power",
     main = ""
)

#### close the png device ######################
dev.off() 


