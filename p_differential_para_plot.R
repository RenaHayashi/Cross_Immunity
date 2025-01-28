###############################
# 1. Load package
###############################
library( ggplot2 )

###############################
# 2. differential
###############################
parameter <- c("lamda", "c", "b", "h", "delta", "a", "d","bb","hh")
length_para <- length(parameter)

for (i in 1:length_para) {
  # i=1
  differential <- read.csv(paste("p_differential_",parameter[i],".csv", sep=""), header = F)
  differential <- as.data.frame(differential)
  h5 <- differential[1:10001,1:2]
  h10 <- differential[10002:20002,2]
  h15 <- differential[20003:30003,2]
  
  
  differential <- data.frame(h5, h10)
  differential <- data.frame(differential, h15)
  colnames(differential)<- c("t","h5","h10","h15")
  differential <- differential[order(differential$t),]
  differential <- differential[1:751,1:4]
  
  line_size = 1.5
  g1 <- ggplot(differential, aes(x=t))+
    theme_bw()+
    labs(x = "t",y = "p(t)") +
    geom_line(aes(y=h5),color="#ccc6cc", size=line_size)+
    geom_line(aes(y=h10),color="#b495cc", size=line_size)+
    geom_line(aes(y=h15),color="#0071bc", size=line_size)+
    xlim(0,6)+
    ylim(0,0.75)
  
  ggsave(file = paste("p_differential_",parameter[i],".png", sep=""), plot = g1)
  
}

