###############################
# 1. Load package
###############################
library( ggplot2 )

###############################
# 2. Plot
###############################
data <- read.csv("p_FM_h.csv", header = T)
data <- as.data.frame(data)

g1 <- ggplot(data, aes(x=h))+
  theme_bw()+
  labs(x = "h",y = "FM") +
  geom_line(aes(y=FM),color="#13AA99", size=1)

ggsave(file = "p_FM_h.png", plot = g1)

