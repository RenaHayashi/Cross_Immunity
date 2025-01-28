###############################
# 1. Load package
###############################
library( ggplot2 )

###############################
# 2. Custmize data
###############################
parameter <- c("lamda", "c", "b", "h", "delta", "a", "d","bb","hh")
value <- c(5*10^4, 1, 2.5*10^(-4), 5*10^(-5), 5, 10, 5, 1.2, 0.4)
length_para <- length(parameter)

SA1 <- list()
SA2 <- list()

for (i in 1:length_para) {
  # i=1
  change <- read.csv(paste("p_differential_",parameter[i],".csv", sep=""), header = F)
  change <- as.data.frame(change)
  
  h1 <- change[1:10001,1:2]
  h2 <- change[10002:20002,2]
  h3 <- change[20003:30003,2]
  h4 <- change[30004:40004,2]
  h5 <- change[40005:50005,2]
  change <- data.frame(h1, h2)
  change <- data.frame(change, h3)
  change <- data.frame(change, h4)
  change <- data.frame(change, h5)
  colnames(change) <- c("t", "0.833", "0.909", "1", "1.1", "*1.2")
  change <- change[order(change$t),]
  change <- change[1:501,]
  length_change <- nrow(change)
  
  for (j in 1:5) {
    pc0 <- change[1,j+1]
    pctau <- 0.8*pc0
    for (k in 1:length_change) {
      change[k,j+6]<- abs(change[k,j+1]-pctau)
    }
  }
  ps_min <- min(change[,9])
  tau_ps <- change[change$V9 == ps_min,]
  ps <- tau_ps[1, 1]
  ps_log <- log(ps)
  
  pc_min <- min(change[,7])
  tau_pc <- change[change$V7 == pc_min,]
  pc <- tau_pc[1, 1]
  pc_log <- log(pc)
  
  para_s <- value[i]
  para_s_log <- log(para_s)
  para_c <- 0.833*para_s
  para_c_log <- log(para_c)
  
  sa1 <- (para_s/ps)*((pc-ps)/(para_c-para_s))
  sa2 <- (pc_log-ps_log)/(para_c_log-para_s_log)
  
  SA1 <- c(SA1, sa1)
  SA2 <- c(SA2, sa2)
}

SA1 <- as.data.frame(SA1)
colnames(SA1) <- parameter
SA2 <- as.data.frame(SA2)
colnames(SA2) <- parameter

data <- rbind(SA1, SA2)
