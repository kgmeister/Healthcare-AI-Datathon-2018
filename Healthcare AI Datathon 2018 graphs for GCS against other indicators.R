library(ggplot2)
library(gridExtra)

AgevsGCSwRace <- ggplot(df, aes(x=GCS, y=Age)) + #GCS = continous scale
  geom_point(aes(fill = Race), alpha=0.5) + 
  scale_x_continuous(limits = c(3, 15)) +
  xlab = ("GCS (Outcome)") +
  ylab = ("Age") +
  ggtitle("Age Vs GCS (Outcome) - Race") +
  theme_bw() 

AgevsGCSwGender <- ggplot(df, aes(x=GCS, y=Age)) + #GCS = continuous scale
  geom_point(aes(fill = Gender), alpha=0.5) + 
  scale_x_continuous(limits = c(3, 15)) +
  xlab = ("GCS (Outcome)") +
  ylab = ("Age") +
  ggtitle("Age Vs GCS (Outcome) - Gender") +
  theme_bw() 

grid.arrange(AgevsGCSwGender, AgevsGCSwRace, ncol=2)

DxvsGCS <- ggplot(df, aes(x=Dx, y=GCS)) +  #GCS = categorical
  geom_point(aes(fill = Class), 
             alpha=0.5, 
             binaxis = "y",         
             binwidth = 0.1,      
             stackdir = "center") + 
  xlab = ("Diagnosis") +
  ylab = ("GCS") +
  ggtitle("GCS (Outcome) Vs Diagnosis") +
  stat_summary(fun.y = median, fun.ymin = median, fun.ymax = median,
               geom = "crossbar", width = 0.5) +
  theme_bw()