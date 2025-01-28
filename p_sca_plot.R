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
differential <- differential[order(differential$t),]
approximate <- read.csv("p_sca.csv", header = F)
approximate <- as.data.frame(approximate)
data <- cbind(differential, approximate[,4])
names(data) <- c("t", "pd", "psca")
data <- data[1:1001,]

line_size = 1.5
g1 <- ggplot(data, aes(x=t))+
  theme_bw()+
  labs(x = "t",y = "p(t)") +
  geom_line(aes(y=pd),color="#13AA99", size=line_size)+
  geom_line(aes(y=psca),color="#f25a86", size=line_size)+
  ylim(0,1)

ggsave(file = "p_sca.png", plot = g1)

