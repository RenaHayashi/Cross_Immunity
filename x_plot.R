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
x_caliculate <- x_caliculate[1:1001,1:4]

line_size = 1.5

g<- ggplot(x_caliculate, aes(x=t))+
  theme_bw()+
  labs(x = "Time",y = "x(t), y(t)") +
  geom_line(aes(y=x),color="#09b8db", size=line_size)+
  geom_line(aes(y=y),color="#ff5050", size=line_size)+
  geom_line(aes(y=w),color="#ffd208", size=line_size)
  # scale_y_log10()+
  #coord_fixed(ratio=2)

ggsave(file = "x_plot.png", plot = g)

# lambda = 5*10^4
# c = 1
# b = 2.5*10^-4
# h = 5*10^-5
# delta = 5
# a = 10
# d = 5
# 
# A<- b*b*d
# B <- b*d*delta+c*h*a
# C <- lambda*h*a
# route <-B^2+4*A*C
# route2 <- route^0.5
# x_star <- (-B+route2) / (2*A)
