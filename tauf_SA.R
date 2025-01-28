###############################
# 1. Load package
###############################

###############################
# 2. Custmize data
###############################
parameter <- c("lamda", "c", "b", "h", "delta", "a", "d","bb","hh")
value <- c(5*10^4, 1, 2.5*10^(-4), 5*10^(-5), 5, 10, 5, 1.2, 0.4)
length_para <- length(parameter)

maxSA1 <- list()
maxSA2 <- list()
tauSA1 <- list()
tauSA2 <- list()

###############################
# 2. Calculate standard
###############################
x_stan <- read.csv("x.csv", header = F)
x_stan <- as.data.frame(x_stan)
x_stan <- x_stan[1:1001,1:4]
colnames(x_stan) <- c("t", "x", "y", "w")

p_stan <- read.csv("p_differential.csv", header = F)
p_stan <- as.data.frame(p_stan)
colnames(p_stan) <- c("t", "stan")
p_stan <- p_stan[order(p_stan$t),]
p_stan <- p_stan[1:1001,1:2]

merge_data <- cbind(x_stan, p_stan)
length_merge_data <- nrow(merge_data)

b <- value[3]

for (k in 1:length_merge_data) {
  x <- merge_data[k,2]
  y <- merge_data[k,3]
  stan <- merge_data[k,6]
  merge_data[k,7] <- b*x*y*stan
}
max_stan <- max(merge_data[,7])
num_max_stan <- which(merge_data[,7]==max_stan)

ps1 <- max_stan
ps1_log <- log(ps1)
ps2 <- merge_data[num_max_stan,1]
ps2_log <- log(ps2)

###############################
# 2. Calculate each parameter
###############################

for (i in 1:length_para) {
  # i=1
  xdata <- read.csv(paste("x_",parameter[i],".csv", sep=""), header = F)
  xdata <- as.data.frame(xdata)
  if(i<8){
    h1 <- xdata[1:10001,1:3]
    h2 <- xdata[10002:20002,2:3]
    h3 <- xdata[20003:30003,2:3]
    h4 <- xdata[30004:40004,2:3]
    h5 <- xdata[40005:50005,2:3]
  }else{
    h1 <- xdata[1:10001,1:3]
    h2 <- xdata[1:10001,2:3]
    h3 <- xdata[1:10001,2:3]
    h4 <- xdata[1:10001,2:3]
    h5 <- xdata[1:10001,2:3]
  }
  xdata <- data.frame(h1, h2)
  xdata <- data.frame(xdata, h3)
  xdata <- data.frame(xdata, h4)
  xdata <- data.frame(xdata, h5)
  xdata <- xdata[1:1001,1:11]
  colnames(xdata) <- c("t", "x0.833", "y0.833", "x0.909", "y0.909", "x1", "y1", "x1.1", "y1.1", "x1.2", "y1.2")
  
  pdata <- read.csv(paste("p_differential_",parameter[i],".csv", sep=""), header = F)
  pdata <- as.data.frame(pdata)
  h1 <- pdata[1:10001,1:2]
  h2 <- pdata[10002:20002,2]
  h3 <- pdata[20003:30003,2]
  h4 <- pdata[30004:40004,2]
  h5 <- pdata[40005:50005,2]
  pdata <- data.frame(h1, h2)
  pdata <- data.frame(pdata, h3)
  pdata <- data.frame(pdata, h4)
  pdata <- data.frame(pdata, h5)
  colnames(pdata) <- c("t", "0.833", "0.909", "1", "1.1", "1.2")
  pdata <- pdata[order(pdata$t),]
  pdata <- pdata[1:1001,1:6]
  

  FM_data <- as.data.frame(pdata[,1])
  length_data <- nrow(xdata)
  for (n in 1:5) {
    for (l in 1:length_data) {
      x <- xdata[l,2*n]
      y <- xdata[l,2*n+1]
      p <- pdata[l,n+1]
      if(i==3){
        FM_data[l,n+1]<- b*rate[n]*x*y*p
      }else{
        FM_data[l,n+1]<- b*x*y*p
      }
    }
  }
  colnames(FM_data) <- c("t", "0.833", "0.909", "1", "1.1", "1.2")
  
  max_chan <- max(FM_data[,2])
  num_max_chan <- which(FM_data[,2]==max_chan)
  
  pc1 <- max_chan
  pc1_log <- log(pc1)
  pc2 <- FM_data[num_max_chan,1]
  pc2_log <- log(pc2)
  
  para_s <- value[i]
  para_s_log <- log(para_s)
  para_c <- 0.833*para_s
  para_c_log <- log(para_c)
  
  maxsa1 <- (para_s/ps1)*((pc1-ps1)/(para_c-para_s))
  maxsa2 <- (pc1_log-ps1_log)/(para_c_log-para_s_log)
  tausa1 <- (para_s/ps2)*((pc2-ps2)/(para_c-para_s))
  tausa2 <- (pc2_log-ps2_log)/(para_c_log-para_s_log)
  
  maxSA1 <- c(maxSA1, maxsa1)
  maxSA2 <- c(maxSA2, maxsa2)
  tauSA1 <- c(tauSA1, tausa1)
  tauSA2 <- c(tauSA2, tausa2)
}

maxSA1 <- as.data.frame(maxSA1)
colnames(maxSA1) <- parameter
maxSA2 <- as.data.frame(maxSA2)
colnames(maxSA2) <- parameter
tauSA1 <- as.data.frame(tauSA1)
colnames(tauSA1) <- parameter
tauSA2 <- as.data.frame(tauSA2)
colnames(tauSA2) <- parameter

data <- rbind(maxSA1, maxSA2, tauSA1, tauSA2)
