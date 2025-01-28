###############################
# 1. Load package
###############################
library( ggplot2 )

###############################
# 2. Load data
###############################
x_caliculate <- read.csv("x.csv", header = F)
names(x_caliculate) <- c("t", "x", "y", "w")
x_caliculate <- as.data.frame(x_caliculate)
x_caliculate <- x_caliculate[1:101,1:4]

x_AC <- read.csv("x_AC.csv", header = F)
names(x_AC) <- c("tt", "xx", "yy", "ww")
x_AC <- as.data.frame(x_AC)
x_AC <- x_AC[1:101,1:4]

x_cal_AC <- cbind(x_caliculate, x_AC)
line_size = 1.5

g<- ggplot(x_cal_AC, aes(x=t))+
  theme_bw()+
  labs(x = "Time",y = "x(t), y(t)") +
  geom_line(aes(y=x),color="#0071bc", size=line_size)+
  geom_line(aes(y=y),color="#ff5050", size=line_size)+
  geom_line(aes(y=w),color="#ffd208", size=line_size)+
  geom_line(aes(y=xx),color="#00426e", size=line_size)+
  geom_line(aes(y=yy),color="#943131", size=line_size)+
  geom_line(aes(y=ww),color="#695604", size=line_size)+
  ylim(c(0, 60000))

ggsave(file = "x_AC_plot.png", plot = g)
