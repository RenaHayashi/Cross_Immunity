###############################
# 1. Load package
###############################
library( ggplot2 )

###############################
# 2. differential
###############################
data <- read.csv("p0_psca0.csv", header = T)
data <- as.data.frame(data)
names(data) <- c("p0", "psca0")

xdata<-as.data.frame(0.1*c(0:10))
ydata<- as.data.frame(0.1*c(0:10))
data2 <- cbind(xdata,ydata)
names(data2) <- c("x", "y")

point_size = 2.5
g1 <- ggplot()+
  theme_bw()+
  labs(x = "psca0",y = "p0") +
  geom_point(data = data, aes(x=psca0, y=p0),color="#000000", size=point_size)+
  geom_line(data = data2, aes(x,y), linetype="dashed")+
  xlim(0.5,1)+
  ylim(0.5,1)

ggsave(file = "Fig8.png", plot = g1)
