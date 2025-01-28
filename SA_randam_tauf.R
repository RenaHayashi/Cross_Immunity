###############################
# 1. Load package
###############################
library( ggplot2 )
library(openxlsx)
###############################
# 2. Custmize data
###############################
chara <- c("p0", "taup", "pbar", "taux", "xbar", "tauf", "ftauf", "FM")
parameter <- c("lamda", "c", "b", "h", "delta", "a", "d","bb","hh")
value <- c(5*10^4, 1, 2.5*10^(-4), 5*10^(-5), 5, 10, 5, 1.2, 0.4)
length_para <- length(parameter)

xdata_all <- read.csv("SA_ramdom_x.csv", header = F)
colnames(xdata) <- c("t", "x", "y", "w")
pdata_all <- read.csv("SA_ramdom_p.csv", header = F)
colnames(pdata) <- c("t", "p")

length_data <- 1001

data <- data.frame()
data1 <- data.frame()
data2 <- data.frame()
data3 <- data.frame()

for (j in 0:99) {
  # j=0
  st <- 10010*j+1
  fin<- 10010*j+1001
  xdata <- xdata_all[st:fin,]
  pdata <- pdata_all[st:fin,]
  pdata <- pdata[order(pdata$V1),]
  stan <- cbind(xdata, pdata)
  colnames(stan)<-c("t", "x", "y", "w", "t", "p")
  for (k in 1:length_data) {
    # k=1
    stan[k,7] <- value[3]*stan[k,2]*stan[k,3]*stan[k,6]
  }
  stan <- stan[1:601,]
  max_stan <- max(stan[,7])
  num_max_stan <- which(stan[,7]==max_stan)
  if(length(num_max_stan) > 1){
    num_max_stan <-NaN
    num_min_stan <-NaN
  }else{
    mini_stan <-as.data.frame(stan[num_max_stan:601,7])
    
    min_stan <- min(mini_stan[,1])
    num_min_stan <- which(stan[,7]==min_stan)
    if(length(num_min_stan) > 1){
      num_min_stan <-NaN
    }
  }
  
  fm = 0
  if(is.nan(num_min_stan)==TRUE | is.nan(num_max_stan) == TRUE){
    fm <- 0
  }else{
    for (l in 1:num_min_stan) {
      bar <- stan[l,7]*0.01
      fm <- fm + bar
    }
  }
  
  ps1 <- max_stan
  ps1_log <- log(ps1)
  ps2 <- stan[num_max_stan,1]
  ps2_log <- log(ps2)
  ps3 <- fm
  ps3_log <- log(ps3)
  
  
  tauSA1 <- list()
  tauSA2 <- list()
  SA1 <- list()
  SA2 <- list()
  fmSA1 <- list()
  fmSA2 <- list()
  
  for (i in 1:length_para){
    # i=1
    st <- 10010*j+1000*i+i+1
    fin<- 10010*j+1000*(i+1)+i+1
    xdata <- xdata_all[st:fin,]
    pdata <- pdata_all[st:fin,]
    pdata <- pdata[order(pdata$V1),]
    change <- cbind(xdata, pdata)
    colnames(change)<-c("t", "x", "y", "w", "t", "p")
    
    for (k in 1:length_data) {
      if(i==3){
        change[k,7] <- value[3]*0.833*change[k,2]*change[k,3]*change[k,6]
      }else{
        change[k,7] <- value[3]*change[k,2]*change[k,3]*change[k,6]
      }
    }
    
    change <- change[1:601,]
    max_change <- max(change[,7])
    num_max_change <- which(change[,7]==max_change)
    if(length(num_max_change) > 1){
      num_max_change <-NaN
      num_min_change <-NaN
    }else{
      mini_change <-as.data.frame(change[num_max_change:601,7])
      
      min_change <- min(mini_change[,1])
      num_min_change <- which(change[,7]==min_change)
      if(length(num_min_change) > 1){
        num_min_change <-NaN
      }
    }
    
    
    fm = 0
    if(is.nan(num_min_change)==TRUE | is.nan(num_max_change) == TRUE){
      fm <- 0
    }else{
      for (l in 1:num_min_change) {
        bar <- change[l,7]*0.01
        fm <- fm + bar
      }
    }
    
    pc1 <- max_change
    pc1_log <- log(pc1)
    pc2 <- change[num_max_change,1]
    pc2_log <- log(pc2)
    pc3 <- fm
    pc3_log <- log(pc3)
    
    para_s <- value[i]
    para_s_log <- log(para_s)
    para_c <- 0.833*para_s
    para_c_log <- log(para_c)
    
    tausa1 <- (para_s/ps1)*((pc1-ps1)/(para_c-para_s))
    tausa2 <- (pc1_log-ps1_log)/(para_c_log-para_s_log)
    sa1 <- (para_s/ps2)*((pc2-ps2)/(para_c-para_s))
    sa2 <- (pc2_log-ps2_log)/(para_c_log-para_s_log)
    fmsa1 <- (para_s/ps3)*((pc3-ps3)/(para_c-para_s))
    fmsa2 <- (pc3_log-ps3_log)/(para_c_log-para_s_log)
    
    tauSA1 <- c(tauSA1,tausa1)
    tauSA2 <- c(tauSA2,tausa2)
    SA1 <- c(SA1,sa1)
    SA2 <- c(SA2,sa2)
    fmSA1 <- c(fmSA1,fmsa1)
    fmSA2 <- c(fmSA2,fmsa2)
  }
  
  tauSA1 <- as.data.frame(tauSA1)
  colnames(tauSA1) <- parameter
  # tauSA2 <- as.data.frame(tauSA2)
  # colnames(tauSA2) <- parameter
  SA1 <- as.data.frame(SA1)
  colnames(SA1) <- parameter
  # SA2 <- as.data.frame(SA2)
  # colnames(SA2) <- parameter
  fmSA1 <- as.data.frame(fmSA1)
  colnames(fmSA1) <- parameter
  # fmSA2 <- as.data.frame(fmSA2)
  # colnames(fmSA2) <- parameter
  
  data1 <- rbind(data1,tauSA1)
  # data <- rbind(data,tauSA2)
  data2 <- rbind(data2,SA1)
  # data <- rbind(data,SA2)
  data3 <- rbind(data3,fmSA1)
  # data <- rbind(data,fmSA2)
}
write.xlsx(data1, "SA_randam_tauf.xlsx")
write.xlsx(data2, "SA_randam_f(tauf).xlsx")
write.xlsx(data3, "SA_randam_FM.xlsx")
