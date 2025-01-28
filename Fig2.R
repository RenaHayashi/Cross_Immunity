###############################
# 1. Load package
###############################
library( ggplot2 )

###############################
# 2. differential
###############################
differential <- read.csv("p_differential.csv", header = F)
differential <- as.data.frame(differential)
names(differential) <- c("t", "p")
differential <- differential[49001:50001, 1:2] 

differential2 <- read.csv("p_differential_hsize.csv", header = F)
differential2 <- as.data.frame(differential2)
names(differential2) <- c("t", "ph")
differential2 <- differential2[49001:50001, 1:2] 

data <- cbind(differential, differential2[,2])
names(data) <- c("t", "pp", "ph")

line_size = 1.5
g1 <- ggplot(data, aes(x=t))+
  theme_bw()+
  labs(x = "t",y = "p(t)") +
  geom_line(aes(y=pp),color="#0b6157", size=line_size)+
  geom_line(aes(y=ph),color="#13AA99", size=line_size)+
  ylim(0,1)

ggsave(file = "Fig2.png", plot = g1)
