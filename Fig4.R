###############################
# 1. Load package
###############################
library( ggplot2 )
library( gridExtra )

###############################
# 2. differential
###############################
parameter <- c("lamda", "c", "b", "h", "delta", "a", "d","bb","hh")
length_para <- length(parameter)
fig <- c()

for (i in 1:length_para) {
  # i=1
  data <- read.csv(paste("p_differential_",parameter[i],".csv", sep=""), header = F)
  data <- as.data.frame(data)
  d1 <- data[1:10001,1:2]
  d2 <- data[10002:20002,2]
  d3 <- data[20003:30003,2]
  d4 <- data[30004:40004,2]
  d5 <- data[40005:50005,2]
  
  
  data <- data.frame(d1, d2)
  data <- data.frame(data, d3)
  data <- data.frame(data, d4)
  data <- data.frame(data, d5)
  colnames(data)<- c("t","d1","d2","d3","d4","d5")
  data <- data[order(data$t),]
  data <- data[1:751,1:6]
  
  line_size = 1
  g1 <- ggplot(data, aes(x=t))+
    theme_bw()+
    labs(x = "",y = "") +
    geom_line(aes(y=d1),color="#00215d", size=line_size)+
    geom_line(aes(y=d2),color="#0071bc", size=line_size)+
    geom_line(aes(y=d3),color="#b5b5b8", size=line_size)+
    geom_line(aes(y=d4),color="#ff8f86", size=line_size)+
    geom_line(aes(y=d5),color="#ff5050", size=line_size)+
    xlim(0,6)+
    ylim(0,0.75)
  
  fig[[i]] <- g1
  ggsave(file = paste("p_differential_",parameter[i],".png", sep=""), plot = g1)
  
}

g2 <- grid.arrange(fig[[1]], fig[[2]], fig[[3]], 
                   fig[[4]], fig[[5]], fig[[6]],
                   fig[[7]], fig[[8]], fig[[9]],
                   nrow = 3)
ggsave(file = "Fig4.png", plot = g2)

