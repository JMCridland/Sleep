sink(file="Wing_length_means_analysis.txt",append=FALSE,split=FALSE)

x<-read.table("Wing_length_means.txt",header=T)
print(summary(x))

man<-lm(x$MeanLength ~ x$Temp + x$Pop + x$Sex + x$Food)

print(summary(man))

print(anova(man))

sink()