###############################
# 1. Load package
###############################
library( ggplot2 )

###############################
# 2. Load data
###############################
#x, y, w
xdata <- read.csv("x.csv", header = F)
names(xdata) <- c("t", "x", "y", "w")
xdata <- as.data.frame(xdata)
xdata <- xdata[1:601,1:4]

#p
pdata <- read.csv("p_differential_hsize.csv", header = F)
pdata <- as.data.frame(pdata)
names(pdata) <- c("t", "ph")
pdata <- pdata[order(pdata$t),]
pdata <- pdata[1:601,1:2]

#f
for (i in 1:601) {
  x <- xdata[i,2]
  y <- xdata[i,3]
  p <- pdata[i,2]
  pdata[i,3] <- b*x*y*p
}
names(pdata) <- c("t", "ph", "f")

line_size = 1.5

g1<- ggplot(xdata, aes(x=t))+
  theme_bw()+
  theme(aspect.ratio = 0.5)+
  labs(x = "Time",y = "x(t), y(t)") +
  geom_line(aes(y=x),color="#09b8db", size=line_size)+
  geom_line(aes(y=y),color="#ff5050", size=line_size)+
  geom_line(aes(y=w),color="#ffd208", size=line_size)
ggsave(file = "Fig5x.png", plot = g1)

g2 <- ggplot(pdata, aes(x=t))+
  theme_bw()+
  theme(aspect.ratio = 0.5)+
  labs(x = "t",y = "p(t)") +
  geom_line(aes(y=ph),color="#13AA99", size=line_size)+
  ylim(0,1)
ggsave(file = "Fig5p.png", plot = g2)

g3 <- ggplot(pdata, aes(x=t))+
  theme_bw()+
  theme(aspect.ratio = 0.5)+
  labs(x = "t",y = "f(t)") +
  geom_line(aes(y=f),color="#0071bc", size=line_size)
ggsave(file = "Fig5f.png", plot = g3)
