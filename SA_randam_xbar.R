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

for (j in 0:99) {
  # j=1
  st <- 10010*j+1
  fin<- 10010*j+1001
  stan <- xdata_all[st:fin,]
  stan <- stan[order(stan$V1),]
  ps <- stan[1001,2]
  ps_log <- log(ps)
  
  SA1 <- list()
  SA2 <- list()
  
  for (i in 1:length_para){
    # i=5
    st <- 10010*j+1000*i+i+1
    fin<- 10010*j+1000*(i+1)+i+1
    change <-xdata_all[st:fin,]
    change <- change[order(change$V1),]
    
    pc <- change[1001,2]
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
  # SA2 <- as.data.frame(SA2)
  # colnames(SA2) <- parameter
  # 
  data <- rbind(data,SA1)
  # data <- rbind(data,SA2)
}
write.xlsx(data, "SA_randam_xbar.xlsx")
