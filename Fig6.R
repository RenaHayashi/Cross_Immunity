###############################
# 1. Load package
###############################
library( ggplot2 )

###############################
# 2. Plot
###############################
data <- read.csv("p_FM_h.csv", header = T)
data <- as.data.frame(data)
length_data <- nrow(data)

data2 <- data[1,]

for (i in 2:length_data) {
  amari <- i%%10
  if(amari == 1){
    data2 <- rbind(data2,data[i,])
  }
}

g1 <- ggplot(data2, aes(x=h))+
  theme_bw()+
  labs(x = "h",y = "FM") +
  geom_point(aes(y=FM),color="#000000", size=2.5)

ggsave(file = "Fig6.png", plot = g1)

