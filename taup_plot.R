###############################
# 1. Load package
###############################
library( ggplot2 )
library(RColorBrewer)
# rm( list = ls( envir = globalenv() ), envir = globalenv() )
###############################
# 2. search 
###############################
parameter <- c("lamda", "c", "b", "h", "delta", "a", "d","bb","hh")
length_para <- length(parameter)
length_p <- 150
data <- data.frame()

for (i in 1:length_para) {
  # i=1
  pdata <- read.csv(paste("p_differential_",parameter[i],".csv", sep=""), header = F)
  pdata <- as.data.frame(pdata)
  t_tau_list <- list()
  for (j in 1:3) {
    st <- 10000*(j-1)+j
    fin<- 10000*j+j
    p <- as.data.frame(pdata[st:fin,])
    p <- as.data.frame(p[order(p$V1),])
    row.names(p) <- 1:nrow(p)
    p <- p[1:length_p,]
    p0 <- as.numeric(p[1,2])
    ptau <- 0.8*p0
    for (k in 1:length_p) {
      p[k,3] <- abs(p[k,2]-ptau)
    }
    min <- min(p[,3])
    tau_data <- p[p$V3 == min,]
    t_tau <- tau_data[1, 1]
    t_tau_list <- c(t_tau_list, t_tau)
  }
  t_tau_data <- as.data.frame(t_tau_list)
  t_tau_data <- as.data.frame(t(t_tau_data))
  if(i==1){
    data <- t_tau_data
  }else{
    data <- cbind(data, t_tau_data)
  }
}
data <- cbind(data, c(1, 2, 3))
colnames(data)<-c(parameter,"label")
rownames(data)<-c("tau1", "tau2", "tau3")
line_size = 0.8
point_size = 1.5
g1 <- ggplot(data, aes(x=label, color = "Set3"))+
  theme_bw( legend.position = "left")+
  labs(x = "label",y = "tau_p") +
  geom_line(aes(y=lamda),color="#000000", size=line_size)+
  geom_line(aes(y=c),color="#083741", size=line_size)+
  geom_line(aes(y=b),color="#38616c", size=line_size)+
  geom_line(aes(y=h),color="#7db0a5", size=line_size)+
  geom_line(aes(y=delta),color="#ecd37c", size=line_size)+
  geom_line(aes(y=a),color="#ededae", size=line_size)+
  geom_line(aes(y=d),color="#ffa087", size=line_size)+
  geom_line(aes(y=bb),color="#ff6e5a", size=line_size)+
  geom_line(aes(y=hh),color="#f05a49", size=line_size)+
  geom_point(aes(y=lamda),color="#000000", size=point_size)+
  geom_point(aes(y=c),color="#083741", size=point_size)+
  geom_point(aes(y=b),color="#38616c", size=point_size)+
  geom_point(aes(y=h),color="#7db0a5", size=point_size)+
  geom_point(aes(y=delta),color="#ecd37c", size=point_size)+
  geom_point(aes(y=a),color="#ededae", size=point_size)+
  geom_point(aes(y=d),color="#ffa087", size=point_size)+
  geom_point(aes(y=bb),color="#ff6e5a", size=point_size)+
  geom_point(aes(y=hh),color="#f05a49", size=point_size)+
  ylim(0,0.5)

ggsave(file = "p_tau_plot.png", plot = g1)
