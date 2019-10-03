x<-read.table("Starve_means.txt",header=T)

sink(file="Starve_means_analysis.txt",append=FALSE,split=FALSE)

print(summary(x))

mod<-lm(x$MeanLD50 ~ x$Sex + x$Pop + x$Temp)

print(summary(mod))

print(anova(mod))

sink()