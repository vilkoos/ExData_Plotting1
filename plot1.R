
#======================================================
#   get the data
#======================================================

#### get data from the internet ##############
if (!file.exists("household_power_consumption.txt")) {
    url  = "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
    dest = "rawdata.zip"
    meth = "internal"
    quit = TRUE
    mode = "wb"
    download.file(url, dest, meth, quit, mode)
    # NOTE this works under windows 7, modify if nessesairy
    unzip("rawdata.zip")
    # clean-up the environment
    rm(dest); rm(meth); rm(mode); rm(quit); rm(url)
}

#### build data frame pow ##############################
dat0 <- read.table("household_power_consumption.txt"
                   , header = TRUE
                   , sep = ";"
                   , na.strings = "?"
                   , stringsAsFactors = FALSE)
# recast Date as type Date
dat0[,1] <- as.Date( dat0[,1],format="%d/%m/%Y")
# select the data of 2007-02-01 and 2007-02-02
dat <- dat0[which(dat0$Date == as.Date("2007-02-01") | dat0$Date == as.Date("2007-02-02") ),]
row.names(dat) <- NULL
# construct date time string
dat[,10] <- paste0(dat[,1]," ",dat[,2])
names(dat)[10] <- "dateTimeString"
# construct DateTime variable
dat[,11] <- as.POSIXct(dat[,10],format="%Y-%m-%d %H:%M:%S")
names(dat)[11] <- "DateTime"
### step 3 - construct the data frame to work with (pow) #################
pow <- dat[,c(1,11,3:9)]
# str(pow) gives:
#2880 obs. of  9 variables:
# Date                 : Date, format: "2007-02-01" "2007-02-01" "2007-02-01" "2007-02-01" ...
# DateTime             : POSIXct, format: "2007-02-01 00:00:00" "2007-02-01 00:01:00" "2007-02-01 00:02:00" "2007-02-01 00:03:00" ...
# Global_active_power  : num  0.326 0.326 0.324 0.324 0.322 0.32 0.32 0.32 0.32 0.236 ...
# Global_reactive_power: num  0.128 0.13 0.132 0.134 0.13 0.126 0.126 0.126 0.128 0 ...
# Voltage              : num  243 243 244 244 243 ...
# Global_intensity     : num  1.4 1.4 1.4 1.4 1.4 1.4 1.4 1.4 1.4 1 ...
# Sub_metering_1       : num  0 0 0 0 0 0 0 0 0 0 ...
# Sub_metering_2       : num  0 0 0 0 0 0 0 0 0 0 ...
# Sub_metering_3       : num  0 0 0 0 0 0 0 0 0 0 ...

#======================================================
#   make plot1.png
#======================================================

#### make the plot ###############################
hist(pow$Global_active_power, 
     col  = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kiloWatts)",
     xlim = c(0,7.5)
    )

#### copy to png #################################
dev.copy(png, "plot1.png")
dev.off() 

