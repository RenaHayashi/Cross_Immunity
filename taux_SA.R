###############################
# 1. Load package
###############################
library( ggplot2 )

###############################
# 2. Custmize data
###############################
parameter <- c("lamda", "c", "b", "h", "delta", "a", "d")
value <- c(5*10^4, 1, 2.5*10^(-4), 5*10^(-5), 5, 10, 5, 1.2, 0.4)
length_para <- length(parameter)

SA1 <- list()
SA2 <- list()

x_stan<- read.csv("x.csv", header = F)
x_stan <- as.data.frame(x_stan)
x_stan <- x_stan[1:1001,1:4]
colnames(x_stan) <- c("t", "x", "y", "w")
length_x_stan <- nrow(x_stan)

ps0 <- x_stan[1,2]
pstau <- 0.8*ps0
for (i in 1:length_x_stan) {
  x_stan[i,5]<- abs(x_stan[i,2]-pstau)
}
ps_min <- min(x_stan[,5])
tau_ps <- x_stan[x_stan$V5 == ps_min,]
ps <- tau_ps[1, 1]
ps_log <- log(ps)

for (j in 1:length_para) {
  # j=1
  x_chan <- read.csv(paste("x_",parameter[j],".csv", sep=""), header = F)
  x_chan <- as.data.frame(x_chan)
  h1 <- x_chan[1:10001,1:2]
  h2 <- x_chan[10002:20002,2]
  h3 <- x_chan[20003:30003,2]
  h4 <- x_chan[30004:40004,2]
  h5 <- x_chan[40005:50005,2]
  x_chan <- data.frame(h1, h2)
  x_chan <- data.frame(x_chan, h3)
  x_chan <- data.frame(x_chan, h4)
  x_chan <- data.frame(x_chan, h5)
  x_chan <- x_chan[1:1001,1:6]
  colnames(x_chan) <- c("t", "0.833", "0.909", "1", "1.1", "1.2")
  length_x_chan <- nrow(x_chan)

  pc0 <- x_chan[1,2]
  pctau <- 0.8*pc0
  for (k in 1:length_x_chan) {
    x_chan[k,7]<- abs(x_chan[k,2]-pctau)
  }
  pc_min <- min(x_chan[,7])
  tau_pc <- x_chan[x_chan$V7 == pc_min,]
  pc <- tau_pc[1, 1]
  pc_log <- log(pc)
  
  para_s <- value[j]
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
