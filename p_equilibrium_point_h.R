###############################
# 1. Load package
###############################
library( ggplot2 )

###############################
# 2. differential
###############################
differential <- read.csv("p_equilibrium_point_h.csv", header = F)
differential <- as.data.frame(differential)
names(differential) <- c("hm", "p")

line_size = 1.5
g1 <- ggplot(differential, aes(x=hm))+
  theme_bw()+
  labs(x = "hm",y = "p") +
  geom_line(aes(y=p),color="#13AA99", size=line_size)+
  ylim(0,0.1)+
  xlim(0,0.00008)

ggsave(file = "p_equilibrium_point_h.png", plot = g1)

