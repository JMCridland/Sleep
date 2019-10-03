sink(file="Anova_master_analysis_new.txt",append=FALSE,split=FALSE)

x<-read.table("Master_table_new",header=T)

print(summary(x))

library(car)

####Sleep

m<-lm(x$Sleep_ALL_percent ~ x$Temp + x$Sex + x$Pop + x$LD50_mean  + x$GluCanS + x$TGANorm)

print(summary(m))

print(Anova(m))

m<-lm(x$Sleep_Day_percent ~ x$Temp + x$Sex + x$Pop + x$LD50_mean  + x$GluCanS + x$TGANorm)

print(summary(m))

print(Anova(m))

m<-lm(x$Sleep_Night_percent ~ x$Temp + x$Sex + x$Pop + x$LD50_mean  + x$GluCanS + x$TGANorm)

print(summary(m))

print(Anova(m))


m<-lm(x$Starve_ALL_percent ~ x$Temp + x$Sex + x$Pop + x$LD50_mean  + x$GluCanS + x$TGANorm)

print(summary(m))

print(Anova(m))

m<-lm(x$Starve_Day_percent ~ x$Temp + x$Sex + x$Pop + x$LD50_mean  + x$GluCanS + x$TGANorm)

print(summary(m))

print(Anova(m))

m<-lm(x$Starve_Night_percent ~ x$Temp + x$Sex + x$Pop + x$LD50_mean  + x$GluCanS + x$TGANorm)

print(summary(m))

print(Anova(m))

##### Movement
m<-lm(x$Sleep_ALL_meanMove ~ x$Temp + x$Sex + x$Pop + x$LD50_mean  + x$GluCanS + x$TGANorm)

print(summary(m))

print(Anova(m))

m<-lm(x$Sleep_Day_meanMove ~ x$Temp + x$Sex + x$Pop + x$LD50_mean  + x$GluCanS + x$TGANorm)

print(summary(m))

print(Anova(m))

m<-lm(x$Sleep_Night_meanMove ~ x$Temp + x$Sex + x$Pop + x$LD50_mean  + x$GluCanS + x$TGANorm)

print(summary(m))

print(Anova(m))

m<-lm(x$Starve_ALL_meanMove ~ x$Temp + x$Sex + x$Pop + x$LD50_mean  + x$GluCanS + x$TGANorm)

print(summary(m))

print(Anova(m))

m<-lm(x$Starve_Day_meanMove ~ x$Temp + x$Sex + x$Pop + x$LD50_mean  + x$GluCanS + x$TGANorm)

print(summary(m))

print(Anova(m))

m<-lm(x$Starve_Night_meanMove ~ x$Temp + x$Sex + x$Pop + x$LD50_mean  + x$GluCanS + x$TGANorm)

print(summary(m))

print(Anova(m))

F<-subset(x,x$Sex=="F")
M<-subset(x,x$Sex=="M")

FFD<-subset(x,x$Pop=="FFD")
PC<-subset(x,x$Pop=="PC")

#####################

####Sleep

####Female

m<-lm(F$Sleep_ALL_percent ~ F$Temp + F$Pop + F$LD50_mean + F$GluCanS + F$TGANorm)

print(summary(m))

print(Anova(m))

m<-lm(F$Sleep_Day_percent ~ F$Temp + F$Pop + F$LD50_mean + F$GluCanS + F$TGANorm)

print(summary(m))

print(Anova(m))

m<-lm(F$Sleep_Night_percent ~ F$Temp + F$Pop + F$LD50_mean + F$GluCanS + F$TGANorm)

print(summary(m))

print(Anova(m))


m<-lm(F$Starve_ALL_percent ~ F$Temp + F$Pop + F$LD50_mean + F$GluCanS + F$TGANorm)

print(summary(m))

print(Anova(m))

m<-lm(F$Starve_Day_percent ~ F$Temp + F$Pop + F$LD50_mean + F$GluCanS + F$TGANorm)

print(summary(m))

print(Anova(m))

m<-lm(F$Starve_Night_percent ~ F$Temp + F$Pop + F$LD50_mean + F$GluCanS + F$TGANorm)

print(summary(m))

print(Anova(m))

##### Movement
m<-lm(F$Sleep_ALL_meanMove ~ F$Temp + F$Pop + F$LD50_mean + F$GluCanS + F$TGANorm)

print(summary(m))

print(Anova(m))

m<-lm(F$Sleep_Day_meanMove ~ F$Temp + F$Pop + F$LD50_mean + F$GluCanS + F$TGANorm)

print(summary(m))

print(Anova(m))

m<-lm(F$Sleep_Night_meanMove ~ F$Temp + F$Pop + F$LD50_mean + F$GluCanS + F$TGANorm)

print(summary(m))

print(Anova(m))

m<-lm(F$Starve_ALL_meanMove ~ F$Temp + F$Pop + F$LD50_mean + F$GluCanS + F$TGANorm)

print(summary(m))

print(Anova(m))

m<-lm(F$Starve_Day_meanMove ~ F$Temp + F$Pop + F$LD50_mean + F$GluCanS + F$TGANorm)

print(summary(m))

print(Anova(m))

m<-lm(F$Starve_Night_meanMove ~ F$Temp + F$Pop + F$LD50_mean + F$GluCanS + F$TGANorm)

print(summary(m))

print(Anova(m))

#########################

###Male

####Sleep

m<-lm(M$Sleep_ALL_percent ~ M$Temp + M$Pop + M$LD50_mean + M$GluCanS + M$TGANorm)

print(summary(m))

print(Anova(m))

m<-lm(M$Sleep_Day_percent ~ M$Temp + M$Pop + M$LD50_mean + M$GluCanS + M$TGANorm)

print(summary(m))

print(Anova(m))

m<-lm(M$Sleep_Night_percent ~ M$Temp + M$Pop + M$LD50_mean + M$GluCanS + M$TGANorm)

print(summary(m))

print(Anova(m))


m<-lm(M$Starve_ALL_percent ~ M$Temp + M$Pop + M$LD50_mean + M$GluCanS + M$TGANorm)

print(summary(m))

print(Anova(m))

m<-lm(M$Starve_Day_percent ~ M$Temp + M$Pop + M$LD50_mean + M$GluCanS + M$TGANorm)

print(summary(m))

print(Anova(m))

m<-lm(M$Starve_Night_percent ~ M$Temp + M$Pop + M$LD50_mean + M$GluCanS + M$TGANorm)

print(summary(m))

print(Anova(m))

##### Movement
m<-lm(M$Sleep_ALL_meanMove ~ M$Temp + M$Pop + M$LD50_mean + M$GluCanS + M$TGANorm)

print(summary(m))

print(Anova(m))

m<-lm(M$Sleep_Day_meanMove ~ M$Temp + M$Pop + M$LD50_mean + M$GluCanS + M$TGANorm)

print(summary(m))

print(Anova(m))

m<-lm(M$Sleep_Night_meanMove ~ M$Temp + M$Pop + M$LD50_mean + M$GluCanS + M$TGANorm)

print(summary(m))

print(Anova(m))

m<-lm(M$Starve_ALL_meanMove ~ M$Temp + M$Pop + M$LD50_mean +  M$GluCanS + M$TGANorm)

print(summary(m))

print(Anova(m))

m<-lm(M$Starve_Day_meanMove ~ M$Temp + M$Pop + M$LD50_mean + M$GluCanS + M$TGANorm)

print(summary(m))

print(Anova(m))

m<-lm(M$Starve_Night_meanMove ~ M$Temp + M$Pop + M$LD50_mean + M$GluCanS + M$TGANorm)

print(summary(m))

print(Anova(m))



##############################Now do LD50



m<-lm(x$LD50_mean ~ x$Sex + x$Pop + x$Temp + x$Sleep_ALL_percent + x$Starve_ALL_percent + x$PerChange + x$Sleep_ALL_meanMove + x$Starve_ALL_meanMove + x$GluCanS + x$TGANorm)

print(summary(m))

print(Anova(m))

m<-lm(M$LD50_mean ~ M$Pop + M$Temp + M$Sleep_ALL_percent + M$Starve_ALL_percent + M$PerChange + M$Sleep_ALL_meanMove + M$Starve_ALL_meanMove + M$GluCanS + M$TGANorm)

print(summary(m))

print(Anova(m))

m<-lm(F$LD50_mean ~ F$Pop + F$Temp + F$Sleep_ALL_percent + F$Starve_ALL_percent + F$PerChange + F$Sleep_ALL_meanMove + F$Starve_ALL_meanMove + F$GluCanS + F$TGANorm)

print(summary(m))

print(Anova(m))


##Add population separated

m<-lm(FFD$LD50_mean ~ FFD$Sex + FFD$Temp + FFD$Sleep_ALL_percent + FFD$Starve_ALL_percent + FFD$PerChange + FFD$Sleep_ALL_meanMove + FFD$Starve_ALL_meanMove + FFD$GluCanS + FFD$TGANorm)

print(summary(m))

print(Anova(m))

m<-lm(PC$LD50_mean ~ PC$Sex + PC$Temp + PC$Sleep_ALL_percent + PC$Starve_ALL_percent + PC$PerChange + PC$Sleep_ALL_meanMove + PC$Starve_ALL_meanMove + PC$GluCanS + PC$TGANorm)

print(summary(m))

print(Anova(m))


sink()



sink(file="Ttests_master_analysis_new.txt",append=FALSE,split=FALSE)

###ALL t-tests

FFD_Female_21<-subset(x,x$Sex=="F"&x$Pop=="FFD"&x$Temp==21)
FFD_Female_25<-subset(x,x$Sex=="F"&x$Pop=="FFD"&x$Temp==25)
PC_Female_21<-subset(x,x$Sex=="F"&x$Pop=="PC"&x$Temp==21)
PC_Female_25<-subset(x,x$Sex=="F"&x$Pop=="PC"&x$Temp==25)

FFD_Male_21<-subset(x,x$Sex=="M"&x$Pop=="FFD"&x$Temp==21)
FFD_Male_25<-subset(x,x$Sex=="M"&x$Pop=="FFD"&x$Temp==25)
PC_Male_21<-subset(x,x$Sex=="M"&x$Pop=="PC"&x$Temp==21)
PC_Male_25<-subset(x,x$Sex=="M"&x$Pop=="PC"&x$Temp==25)

##T tests sleep

print(t.test(FFD_Male_21$Sleep_ALL_percent,FFD_Male_25$Sleep_ALL_percent))

print(t.test(FFD_Female_21$Sleep_ALL_percent,FFD_Female_25$Sleep_ALL_percent))


print(t.test(FFD_Female_21$Sleep_ALL_percent,FFD_Male_21$Sleep_ALL_percent))

print(t.test(FFD_Female_25$Sleep_ALL_percent,FFD_Male_25$Sleep_ALL_percent))


print(t.test(FFD_Male_21$Starve_ALL_percent,FFD_Male_25$Starve_ALL_percent))

print(t.test(FFD_Female_21$Starve_ALL_percent,FFD_Female_25$Starve_ALL_percent))


print(t.test(FFD_Female_21$Starve_ALL_percent,FFD_Male_21$Starve_ALL_percent))

print(t.test(FFD_Female_25$Starve_ALL_percent,FFD_Male_25$Starve_ALL_percent))

####Day

print(t.test(FFD_Male_21$Sleep_Day_percent,FFD_Male_25$Sleep_Day_percent))

print(t.test(FFD_Female_21$Sleep_Day_percent,FFD_Female_25$Sleep_Day_percent))


print(t.test(FFD_Female_21$Sleep_Day_percent,FFD_Male_21$Sleep_Day_percent))

print(t.test(FFD_Female_25$Sleep_Day_percent,FFD_Male_25$Sleep_Day_percent))


print(t.test(FFD_Male_21$Starve_Day_percent,FFD_Male_25$Starve_Day_percent))

print(t.test(FFD_Female_21$Starve_Day_percent,FFD_Female_25$Starve_Day_percent))


print(t.test(FFD_Female_21$Starve_Day_percent,FFD_Male_21$Starve_Day_percent))

print(t.test(FFD_Female_25$Starve_Day_percent,FFD_Male_25$Starve_Day_percent))

####Night

print(t.test(FFD_Male_21$Sleep_Night_percent,FFD_Male_25$Sleep_Night_percent))

print(t.test(FFD_Female_21$Sleep_Night_percent,FFD_Female_25$Sleep_Night_percent))


print(t.test(FFD_Female_21$Sleep_Night_percent,FFD_Male_21$Sleep_Night_percent))

print(t.test(FFD_Female_25$Sleep_Night_percent,FFD_Male_25$Sleep_Night_percent))


print(t.test(FFD_Male_21$Starve_Night_percent,FFD_Male_25$Starve_Night_percent))

print(t.test(FFD_Female_21$Starve_Night_percent,FFD_Female_25$Starve_Night_percent))


print(t.test(FFD_Female_21$Starve_Night_percent,FFD_Male_21$Starve_Night_percent))

print(t.test(FFD_Female_25$Starve_Night_percent,FFD_Male_25$Starve_Night_percent))


###############Move

print(t.test(FFD_Male_21$Sleep_ALL_meanMove,FFD_Male_25$Sleep_ALL_meanMove))

print(t.test(FFD_Female_21$Sleep_ALL_meanMove,FFD_Female_25$Sleep_ALL_meanMove))


print(t.test(FFD_Female_21$Sleep_ALL_meanMove,FFD_Male_21$Sleep_ALL_meanMove))

print(t.test(FFD_Female_25$Sleep_ALL_meanMove,FFD_Male_25$Sleep_ALL_meanMove))


print(t.test(FFD_Male_21$Starve_ALL_meanMove,FFD_Male_25$Starve_ALL_meanMove))

print(t.test(FFD_Female_21$Starve_ALL_meanMove,FFD_Female_25$Starve_ALL_meanMove))


print(t.test(FFD_Female_21$Starve_ALL_meanMove,FFD_Male_21$Starve_ALL_meanMove))

print(t.test(FFD_Female_25$Starve_ALL_meanMove,FFD_Male_25$Starve_ALL_meanMove))

####Day

print(t.test(FFD_Male_21$Sleep_Day_meanMove,FFD_Male_25$Sleep_Day_meanMove))

print(t.test(FFD_Female_21$Sleep_Day_meanMove,FFD_Female_25$Sleep_Day_meanMove))


print(t.test(FFD_Female_21$Sleep_Day_meanMove,FFD_Male_21$Sleep_Day_meanMove))

print(t.test(FFD_Female_25$Sleep_Day_meanMove,FFD_Male_25$Sleep_Day_meanMove))


print(t.test(FFD_Male_21$Starve_Day_meanMove,FFD_Male_25$Starve_Day_meanMove))

print(t.test(FFD_Female_21$Starve_Day_meanMove,FFD_Female_25$Starve_Day_meanMove))


print(t.test(FFD_Female_21$Starve_Day_meanMove,FFD_Male_21$Starve_Day_meanMove))

print(t.test(FFD_Female_25$Starve_Day_meanMove,FFD_Male_25$Starve_Day_meanMove))

####Night

print(t.test(FFD_Male_21$Sleep_Night_meanMove,FFD_Male_25$Sleep_Night_meanMove))

print(t.test(FFD_Female_21$Sleep_Night_meanMove,FFD_Female_25$Sleep_Night_meanMove))


print(t.test(FFD_Female_21$Sleep_Night_meanMove,FFD_Male_21$Sleep_Night_meanMove))

print(t.test(FFD_Female_25$Sleep_Night_meanMove,FFD_Male_25$Sleep_Night_meanMove))


print(t.test(FFD_Male_21$Starve_Night_meanMove,FFD_Male_25$Starve_Night_meanMove))

print(t.test(FFD_Female_21$Starve_Night_meanMove,FFD_Female_25$Starve_Night_meanMove))


print(t.test(FFD_Female_21$Starve_Night_meanMove,FFD_Male_21$Starve_Night_meanMove))

print(t.test(FFD_Female_25$Starve_Night_meanMove,FFD_Male_25$Starve_Night_meanMove))


#####################  PC

print(t.test(PC_Male_21$Sleep_ALL_percent,PC_Male_25$Sleep_ALL_percent))

print(t.test(PC_Female_21$Sleep_ALL_percent,PC_Female_25$Sleep_ALL_percent))


print(t.test(PC_Female_21$Sleep_ALL_percent,PC_Male_21$Sleep_ALL_percent))

print(t.test(PC_Female_25$Sleep_ALL_percent,PC_Male_25$Sleep_ALL_percent))


print(t.test(PC_Male_21$Starve_ALL_percent,PC_Male_25$Starve_ALL_percent))

print(t.test(PC_Female_21$Starve_ALL_percent,PC_Female_25$Starve_ALL_percent))


print(t.test(PC_Female_21$Starve_ALL_percent,PC_Male_21$Starve_ALL_percent))

print(t.test(PC_Female_25$Starve_ALL_percent,PC_Male_25$Starve_ALL_percent))

####Day

print(t.test(PC_Male_21$Sleep_Day_percent,PC_Male_25$Sleep_Day_percent))

print(t.test(PC_Female_21$Sleep_Day_percent,PC_Female_25$Sleep_Day_percent))


print(t.test(PC_Female_21$Sleep_Day_percent,PC_Male_21$Sleep_Day_percent))

print(t.test(PC_Female_25$Sleep_Day_percent,PC_Male_25$Sleep_Day_percent))


print(t.test(PC_Male_21$Starve_Day_percent,PC_Male_25$Starve_Day_percent))

print(t.test(PC_Female_21$Starve_Day_percent,PC_Female_25$Starve_Day_percent))


print(t.test(PC_Female_21$Starve_Day_percent,PC_Male_21$Starve_Day_percent))

print(t.test(PC_Female_25$Starve_Day_percent,PC_Male_25$Starve_Day_percent))

####Night

print(t.test(PC_Male_21$Sleep_Night_percent,PC_Male_25$Sleep_Night_percent))

print(t.test(PC_Female_21$Sleep_Night_percent,PC_Female_25$Sleep_Night_percent))


print(t.test(PC_Female_21$Sleep_Night_percent,PC_Male_21$Sleep_Night_percent))

print(t.test(PC_Female_25$Sleep_Night_percent,PC_Male_25$Sleep_Night_percent))


print(t.test(PC_Male_21$Starve_Night_percent,PC_Male_25$Starve_Night_percent))

print(t.test(PC_Female_21$Starve_Night_percent,PC_Female_25$Starve_Night_percent))


print(t.test(PC_Female_21$Starve_Night_percent,PC_Male_21$Starve_Night_percent))

print(t.test(PC_Female_25$Starve_Night_percent,PC_Male_25$Starve_Night_percent))


###############Move

print(t.test(PC_Male_21$Sleep_ALL_meanMove,PC_Male_25$Sleep_ALL_meanMove))

print(t.test(PC_Female_21$Sleep_ALL_meanMove,PC_Female_25$Sleep_ALL_meanMove))


print(t.test(PC_Female_21$Sleep_ALL_meanMove,PC_Male_21$Sleep_ALL_meanMove))

print(t.test(PC_Female_25$Sleep_ALL_meanMove,PC_Male_25$Sleep_ALL_meanMove))


print(t.test(PC_Male_21$Starve_ALL_meanMove,PC_Male_25$Starve_ALL_meanMove))

print(t.test(PC_Female_21$Starve_ALL_meanMove,PC_Female_25$Starve_ALL_meanMove))


print(t.test(PC_Female_21$Starve_ALL_meanMove,PC_Male_21$Starve_ALL_meanMove))

print(t.test(PC_Female_25$Starve_ALL_meanMove,PC_Male_25$Starve_ALL_meanMove))

####Day

print(t.test(PC_Male_21$Sleep_Day_meanMove,PC_Male_25$Sleep_Day_meanMove))

print(t.test(PC_Female_21$Sleep_Day_meanMove,PC_Female_25$Sleep_Day_meanMove))


print(t.test(PC_Female_21$Sleep_Day_meanMove,PC_Male_21$Sleep_Day_meanMove))

print(t.test(PC_Female_25$Sleep_Day_meanMove,PC_Male_25$Sleep_Day_meanMove))


print(t.test(PC_Male_21$Starve_Day_meanMove,PC_Male_25$Starve_Day_meanMove))

print(t.test(PC_Female_21$Starve_Day_meanMove,PC_Female_25$Starve_Day_meanMove))


print(t.test(PC_Female_21$Starve_Day_meanMove,PC_Male_21$Starve_Day_meanMove))

print(t.test(PC_Female_25$Starve_Day_meanMove,PC_Male_25$Starve_Day_meanMove))

####Night

print(t.test(PC_Male_21$Sleep_Night_meanMove,PC_Male_25$Sleep_Night_meanMove))

print(t.test(PC_Female_21$Sleep_Night_meanMove,PC_Female_25$Sleep_Night_meanMove))


print(t.test(PC_Female_21$Sleep_Night_meanMove,PC_Male_21$Sleep_Night_meanMove))

print(t.test(PC_Female_25$Sleep_Night_meanMove,PC_Male_25$Sleep_Night_meanMove))


print(t.test(PC_Male_21$Starve_Night_meanMove,PC_Male_25$Starve_Night_meanMove))

print(t.test(PC_Female_21$Starve_Night_meanMove,PC_Female_25$Starve_Night_meanMove))


print(t.test(PC_Female_21$Starve_Night_meanMove,PC_Male_21$Starve_Night_meanMove))

print(t.test(PC_Female_25$Starve_Night_meanMove,PC_Male_25$Starve_Night_meanMove))

###Now do population
###Sleep

print(t.test(FFD_Female_21$Sleep_ALL_percent,PC_Female_21$Sleep_ALL_percent))

print(t.test(FFD_Female_25$Sleep_ALL_percent,PC_Female_25$Sleep_ALL_percent))

print(t.test(FFD_Male_21$Sleep_ALL_percent,PC_Male_21$Sleep_ALL_percent))

print(t.test(FFD_Male_25$Sleep_ALL_percent,PC_Male_25$Sleep_ALL_percent))

print(t.test(FFD_Female_21$Starve_ALL_percent,PC_Female_21$Starve_ALL_percent))

print(t.test(FFD_Female_25$Starve_ALL_percent,PC_Female_25$Starve_ALL_percent))

print(t.test(FFD_Male_21$Starve_ALL_percent,PC_Male_21$Starve_ALL_percent))

print(t.test(FFD_Male_25$Starve_ALL_percent,PC_Male_25$Starve_ALL_percent))


print(t.test(FFD_Female_21$Sleep_Day_percent,PC_Female_21$Sleep_Day_percent))

print(t.test(FFD_Female_25$Sleep_Day_percent,PC_Female_25$Sleep_Day_percent))

print(t.test(FFD_Male_21$Sleep_Day_percent,PC_Male_21$Sleep_Day_percent))

print(t.test(FFD_Male_25$Sleep_Day_percent,PC_Male_25$Sleep_Day_percent))

print(t.test(FFD_Female_21$Starve_Day_percent,PC_Female_21$Starve_Day_percent))

print(t.test(FFD_Female_25$Starve_Day_percent,PC_Female_25$Starve_Day_percent))

print(t.test(FFD_Male_21$Starve_Day_percent,PC_Male_21$Starve_Day_percent))

print(t.test(FFD_Male_25$Starve_Day_percent,PC_Male_25$Starve_Day_percent))



print(t.test(FFD_Female_21$Sleep_Night_percent,PC_Female_21$Sleep_Night_percent))

print(t.test(FFD_Female_25$Sleep_Night_percent,PC_Female_25$Sleep_Night_percent))

print(t.test(FFD_Male_21$Sleep_Night_percent,PC_Male_21$Sleep_Night_percent))

print(t.test(FFD_Male_25$Sleep_Night_percent,PC_Male_25$Sleep_Night_percent))

print(t.test(FFD_Female_21$Starve_Night_percent,PC_Female_21$Starve_Night_percent))

print(t.test(FFD_Female_25$Starve_Night_percent,PC_Female_25$Starve_Night_percent))

print(t.test(FFD_Male_21$Starve_Night_percent,PC_Male_21$Starve_Night_percent))

print(t.test(FFD_Male_25$Starve_Night_percent,PC_Male_25$Starve_Night_percent))

####Move



print(t.test(FFD_Female_21$Sleep_ALL_meanMove,PC_Female_21$Sleep_ALL_meanMove))

print(t.test(FFD_Female_25$Sleep_ALL_meanMove,PC_Female_25$Sleep_ALL_meanMove))

print(t.test(FFD_Male_21$Sleep_ALL_meanMove,PC_Male_21$Sleep_ALL_meanMove))

print(t.test(FFD_Male_25$Sleep_ALL_meanMove,PC_Male_25$Sleep_ALL_meanMove))

print(t.test(FFD_Female_21$Starve_ALL_meanMove,PC_Female_21$Starve_ALL_meanMove))

print(t.test(FFD_Female_25$Starve_ALL_meanMove,PC_Female_25$Starve_ALL_meanMove))

print(t.test(FFD_Male_21$Starve_ALL_meanMove,PC_Male_21$Starve_ALL_meanMove))

print(t.test(FFD_Male_25$Starve_ALL_meanMove,PC_Male_25$Starve_ALL_meanMove))


print(t.test(FFD_Female_21$Sleep_Day_meanMove,PC_Female_21$Sleep_Day_meanMove))

print(t.test(FFD_Female_25$Sleep_Day_meanMove,PC_Female_25$Sleep_Day_meanMove))

print(t.test(FFD_Male_21$Sleep_Day_meanMove,PC_Male_21$Sleep_Day_meanMove))

print(t.test(FFD_Male_25$Sleep_Day_meanMove,PC_Male_25$Sleep_Day_meanMove))

print(t.test(FFD_Female_21$Starve_Day_meanMove,PC_Female_21$Starve_Day_meanMove))

print(t.test(FFD_Female_25$Starve_Day_meanMove,PC_Female_25$Starve_Day_meanMove))

print(t.test(FFD_Male_21$Starve_Day_meanMove,PC_Male_21$Starve_Day_meanMove))

print(t.test(FFD_Male_25$Starve_Day_meanMove,PC_Male_25$Starve_Day_meanMove))



print(t.test(FFD_Female_21$Sleep_Night_meanMove,PC_Female_21$Sleep_Night_meanMove))

print(t.test(FFD_Female_25$Sleep_Night_meanMove,PC_Female_25$Sleep_Night_meanMove))

print(t.test(FFD_Male_21$Sleep_Night_meanMove,PC_Male_21$Sleep_Night_meanMove))

print(t.test(FFD_Male_25$Sleep_Night_meanMove,PC_Male_25$Sleep_Night_meanMove))

print(t.test(FFD_Female_21$Starve_Night_meanMove,PC_Female_21$Starve_Night_meanMove))

print(t.test(FFD_Female_25$Starve_Night_meanMove,PC_Female_25$Starve_Night_meanMove))

print(t.test(FFD_Male_21$Starve_Night_meanMove,PC_Male_21$Starve_Night_meanMove))

print(t.test(FFD_Male_25$Starve_Night_meanMove,PC_Male_25$Starve_Night_meanMove))

sink()