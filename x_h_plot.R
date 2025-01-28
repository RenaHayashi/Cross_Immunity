###############################
# 1. Load package
###############################
library( ggplot2 )

###############################
# 2. Load data
###############################
x_caliculate <- read.csv("x_h.csv", header = F)
# names(x_caliculate) <- c("t", "x", "y", "w")
# x_caliculate <- as.data.frame(x_caliculate)
# x_caliculate <- x_caliculate[1:1001,1:4]
# 
# line_size = 1.5
# 
# g<- ggplot(x_caliculate, aes(x=t))+
#   theme_bw()+
#   labs(x = "Time",y = "x(t), y(t)") +
#   geom_line(aes(y=x),color="#0071bc", size=line_size)+
#   geom_line(aes(y=y),color="#ff5050", size=line_size)+
#   geom_line(aes(y=w),color="#b5b5b5", size=line_size)
#   # scale_y_log10()+
#   #coord_fixed(ratio=2)
# 
# ggsave(file = "x_plot.png", plot = g)

