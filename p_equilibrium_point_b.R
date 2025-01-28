###############################
# 1. Load package
###############################
library( ggplot2 )

###############################
# 2. differential
###############################
differential <- read.csv("p_equilibrium_point_b.csv", header = F)
differential <- as.data.frame(differential)
names(differential) <- c("bm", "p")

line_size = 1.5
g1 <- ggplot(differential, aes(x=bm))+
  theme_bw()+
  labs(x = "bm",y = "p") +
  geom_line(aes(y=p),color="#13AA99", size=line_size)+
  ylim(0,1)+
  xlim(0,0.0025)

ggsave(file = "p_equilibrium_point_b.png", plot = g1)

