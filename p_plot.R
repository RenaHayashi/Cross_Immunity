###############################
# 1. Load package
###############################
library( ggplot2 )

###############################
# 2. differential
###############################
differential <- read.csv("p_differential.csv", header = F)
differential <- as.data.frame(differential)
names(differential) <- c("t", "pd")
differential <- differential[9001:10001, 1:2] 

line_size = 1.5
g1 <- ggplot(differential, aes(x=t))+
  theme_bw()+
  labs(x = "t",y = "p(t)") +
  geom_line(aes(y=pd),color="#13AA99", size=line_size)+
  ylim(0,1)

ggsave(file = "p_differential.png", plot = g1)

differential <- read.csv("p_differential_hsize.csv", header = F)
differential <- as.data.frame(differential)
names(differential) <- c("t", "pd")
differential <- differential[49001:50001, 1:2] 

line_size = 1.5
g1 <- ggplot(differential, aes(x=t))+
  theme_bw()+
  labs(x = "t",y = "p(t)") +
  geom_line(aes(y=pd),color="#13AA99", size=line_size)+
  ylim(0,1)

ggsave(file = "p_differential_hsize.png", plot = g1)
