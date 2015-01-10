
###### step 1 - aquire data ######################################

# file manually downloaded on 9 jan 2015 from  https://github.com/rdpeng/ExData_Plotting1
# file manually unzipped into household_power_consumption.txt

###### step 2 - read, select and transform data ##############################

dat0 <- read.table("household_power_consumption.txt"
                  , header = TRUE
                  , sep = ";"
                  , na.strings = "?"
                  , stringsAsFactors = FALSE)
'data.frame:    2075259 obs. of  9 variables:
 $ Date                 : chr  "16/12/2006" "16/12/2006" "16/12/2006" "16/12/2006" ...
 $ Time                 : chr  "17:24:00" "17:25:00" "17:26:00" "17:27:00" ...
 $ Global_active_power  : num  4.22 5.36 5.37 5.39 3.67 ...
 $ Global_reactive_power: num  0.418 0.436 0.498 0.502 0.528 0.522 0.52 0.52 0.51 0.51 ...
 $ Voltage              : num  235 234 233 234 236 ...
 $ Global_intensity     : num  18.4 23 23 23 15.8 15 15.8 15.8 15.8 15.8 ...
 $ Sub_metering_1       : num  0 0 0 0 0 0 0 0 0 0 ...
 $ Sub_metering_2       : num  1 1 2 1 1 2 1 1 1 2 ...
 $ Sub_metering_3       : num  17 16 17 17 17 17 17 17 17 16 ...
'
# recast Date as type Date
dat0[,1] <- as.Date( dat0[,1],format="%d/%m/%Y")

# select the data of 2007-02-01 and 2007-02-02
dat <- dat0[which(dat0$Date == as.Date("2007-02-01") | dat0$Date == as.Date("2007-02-02") ),]
row.names(dat) <- NULL

# remove missing values
dat <- na.omit(dat) # no mssing vaules

# construct date time string
dat[,10] <- paste0(dat[,1]," ",dat[,2])
names(dat)[10] <- "dateTimeString"

# construct DateTime variable
dat[,11] <- as.POSIXct(dat[,10],format="%Y-%m-%d %H:%M:%S")
names(dat)[11] <- "DateTime"

### step 3 - construct the data frame to work with (pow) #################
pow <- dat[,c(1,11,3:9)]
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

### Step 4 - save analytic data into power.csv ###########################
write.csv(pow, "power.csv", row.names=FALSE)


### step 5 - clean up environment ##############
rm(dat)
rm(dat0)


