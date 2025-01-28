###############################
# 1. Load package
###############################
library( ggplot2 )

###############################
# 2. Load data
###############################
b = 2.5*10^(-4)
xdata <- read.csv("x.csv", header = F)
xdata <- as.data.frame(xdata)
xdata <- xdata[1:1001,1:4]
colnames(xdata) <- c("t", "x", "y", "w")

# line_size = 1.5
# 
# g<- ggplot(xdata, aes(x=t))+
#   theme_bw()+
#   labs(x = "Time",y = "x(t), y(t)") +
#   geom_line(aes(y=x),color="#0071bc", size=line_size)+
#   geom_line(aes(y=y),color="#ff5050", size=line_size)+
#   geom_line(aes(y=w),color="#b5b5b5", size=line_size)
#   # scale_y_log10()+
#   #coord_fixed(ratio=2)
# 
# ggsave(file = "x_h0_plot.png", plot = g)

pdata <- read.csv("p_differential.csv", header = F)
pdata <- as.data.frame(pdata)
colnames(pdata) <- c("t", "p")
pdata <- pdata[order(pdata$t),]
pdata <- pdata[1:1001,1:2]

for (i in 1:1001) {
  x <- xdata[i,2]
  y <- xdata[i,3]
  p <- pdata[i,2]
  pdata[i,3] <- b*x*y*p
}

g<- ggplot(pdata, aes(x=t))+
  theme_bw()+
  labs(x = "Time",y = "bxyp") +
  geom_line(aes(y=V3),color="#0071bc", size=line_size)
# scale_y_log10()+
#coord_fixed(ratio=2)

ggsave(file = "bxyp_plot.png", plot = g)
