sink(file="Glucose_analysis_21.txt",append=FALSE,split=FALSE)

x<-read.table("21C_Glu_Clean.txt",header=T)

modCanS<-lm(x$Glu.CanS ~ x$Glu.Plate)

print(summary(modCanS))

modPro<-lm(x$Glu.Pro ~ x$Glu.Plate)

print(summary(modPro))

Glu_FFD_F_21<-subset(x,x$Pop=="FFD"&x$Sex=="F")
Glu_FFD_M_21<-subset(x,x$Pop=="FFD"&x$Sex=="M")
Glu_PC_F_21<-subset(x,x$Pop=="PC"&x$Sex=="F")
Glu_PC_M_21<-subset(x,x$Pop=="PC"&x$Sex=="M")

print(shapiro.test(Glu_FFD_F_21$Glu.CanS))

print(shapiro.test(Glu_FFD_M_21$Glu.CanS))

print(shapiro.test(Glu_PC_F_21$Glu.CanS))

print(shapiro.test(Glu_PC_M_21$Glu.CanS))

print(shapiro.test(Glu_FFD_F_21$Glu.Pro))

print(shapiro.test(Glu_FFD_M_21$Glu.Pro))

print(shapiro.test(Glu_PC_F_21$Glu.Pro))

print(shapiro.test(Glu_PC_M_21$Glu.Pro))

print(summary(Glu_FFD_F_21))

print(summary(Glu_FFD_M_21))

print(summary(Glu_PC_F_21))

print(summary(Glu_PC_M_21))


##FFD
print(paste("Glu_FFD_F_21_CanS"))
print(mean(Glu_FFD_F_21$Glu.CanS,na.rm=TRUE))

print(paste("Glu_FFD_F_21_Pro"))
print(mean(Glu_FFD_F_21$Glu.Pro,na.rm=TRUE))

print(paste("Glu_FFD_M_21_CanS"))
print(mean(Glu_FFD_M_21$Glu.CanS,na.rm=TRUE))

print(paste("Glu_FFD_M_21_Pro"))
print(mean(Glu_FFD_M_21$Glu.Pro,na.rm=TRUE))


###PC
print(paste("Glu_PC_F_21_CanS"))
print(mean(Glu_PC_F_21$Glu.CanS,na.rm=TRUE))

print(paste("Glu_PC_F_21_Pro"))
print(mean(Glu_PC_F_21$Glu.Pro,na.rm=TRUE))

print(paste("Glu_PC_M_21_CanS"))
print(mean(Glu_PC_M_21$Glu.CanS,na.rm=TRUE))

print(paste("Glu_PC_M_21_Pro"))
print(mean(Glu_PC_M_21$Glu.Pro,na.rm=TRUE))


print(wilcox.test(Glu_PC_F_21$Glu.CanS,Glu_PC_M_21$Glu.CanS))
print(wilcox.test(Glu_PC_F_21$Glu.CanS,Glu_PC_M_21$Glu.CanS)$p.value)

print(wilcox.test(Glu_FFD_F_21$Glu.CanS,Glu_FFD_M_21$Glu.CanS))
print(wilcox.test(Glu_FFD_F_21$Glu.CanS,Glu_FFD_M_21$Glu.CanS)$p.value)

print(wilcox.test(Glu_PC_M_21$Glu.CanS,Glu_FFD_M_21$Glu.CanS))
print(wilcox.test(Glu_PC_M_21$Glu.CanS,Glu_FFD_M_21$Glu.CanS)$p.value)

print(wilcox.test(Glu_PC_F_21$Glu.CanS,Glu_FFD_F_21$Glu.CanS))
print(wilcox.test(Glu_PC_F_21$Glu.CanS,Glu_FFD_F_21$Glu.CanS)$p.value)


print(wilcox.test(Glu_PC_F_21$Glu.Pro,Glu_PC_M_21$Glu.Pro))
print(wilcox.test(Glu_PC_F_21$Glu.Pro,Glu_PC_M_21$Glu.Pro)$p.value)

print(wilcox.test(Glu_FFD_F_21$Glu.Pro,Glu_FFD_M_21$Glu.Pro))
print(wilcox.test(Glu_FFD_F_21$Glu.Pro,Glu_FFD_M_21$Glu.Pro)$p.value)

print(wilcox.test(Glu_PC_M_21$Glu.Pro,Glu_FFD_M_21$Glu.Pro))
print(wilcox.test(Glu_PC_M_21$Glu.Pro,Glu_FFD_M_21$Glu.Pro)$p.value)

print(wilcox.test(Glu_PC_F_21$Glu.Pro,Glu_FFD_F_21$Glu.Pro))
print(wilcox.test(Glu_PC_F_21$Glu.Pro,Glu_FFD_F_21$Glu.Pro)$p.value)


sink()



sink(file="Glucose_analysis_25.txt",append=FALSE,split=FALSE)

x<-read.table("25C_Glu_Clean.txt",header=T)

modCanS<-lm(x$Glu.CanS ~ x$Glu.Plate)

print(summary(modCanS))

modPro<-lm(x$GluNorm ~ x$Glu.Plate)

print(summary(modPro))

Glu_FFD_F_25<-subset(x,x$Pop=="FFD"&x$Sex=="F")
Glu_FFD_M_25<-subset(x,x$Pop=="FFD"&x$Sex=="M")
Glu_PC_F_25<-subset(x,x$Pop=="PC"&x$Sex=="F")
Glu_PC_M_25<-subset(x,x$Pop=="PC"&x$Sex=="M")

print(shapiro.test(Glu_FFD_F_25$Glu.CanS))

print(shapiro.test(Glu_FFD_M_25$Glu.CanS))

print(shapiro.test(Glu_PC_F_25$Glu.CanS))

print(shapiro.test(Glu_PC_M_25$Glu.CanS))

print(shapiro.test(Glu_FFD_F_25$GluNorm))

print(shapiro.test(Glu_FFD_M_25$GluNorm))

print(shapiro.test(Glu_PC_F_25$GluNorm))

print(shapiro.test(Glu_PC_M_25$GluNorm))

print(summary(Glu_FFD_F_25))

print(summary(Glu_FFD_M_25))

print(summary(Glu_PC_F_25))

print(summary(Glu_PC_M_25))


##FFD
print(paste("Glu_FFD_F_25_CanS"))
print(mean(Glu_FFD_F_25$Glu.CanS,na.rm=TRUE))

print(paste("Glu_FFD_F_25_Pro"))
print(mean(Glu_FFD_F_25$GluNorm,na.rm=TRUE))

print(paste("Glu_FFD_M_25_CanS"))
print(mean(Glu_FFD_M_25$Glu.CanS,na.rm=TRUE))

print(paste("Glu_FFD_M_25_Pro"))
print(mean(Glu_FFD_M_25$GluNorm,na.rm=TRUE))


###PC
print(paste("Glu_PC_F_25_CanS"))
print(mean(Glu_PC_F_25$Glu.CanS,na.rm=TRUE))

print(paste("Glu_PC_F_25_Pro"))
print(mean(Glu_PC_F_25$GluNorm,na.rm=TRUE))

print(paste("Glu_PC_M_25_CanS"))
print(mean(Glu_PC_M_25$Glu.CanS,na.rm=TRUE))

print(paste("Glu_PC_M_25_Pro"))
print(mean(Glu_PC_M_25$GluNorm,na.rm=TRUE))


print(wilcox.test(Glu_PC_F_25$Glu.CanS,Glu_PC_M_25$Glu.CanS))
print(wilcox.test(Glu_PC_F_25$Glu.CanS,Glu_PC_M_25$Glu.CanS)$p.value)

print(wilcox.test(Glu_FFD_F_25$Glu.CanS,Glu_FFD_M_25$Glu.CanS))
print(wilcox.test(Glu_FFD_F_25$Glu.CanS,Glu_FFD_M_25$Glu.CanS)$p.value)

print(wilcox.test(Glu_PC_M_25$Glu.CanS,Glu_FFD_M_25$Glu.CanS))
print(wilcox.test(Glu_PC_M_25$Glu.CanS,Glu_FFD_M_25$Glu.CanS)$p.value)

print(wilcox.test(Glu_PC_F_25$Glu.CanS,Glu_FFD_F_25$Glu.CanS))
print(wilcox.test(Glu_PC_F_25$Glu.CanS,Glu_FFD_F_25$Glu.CanS)$p.value)


print(wilcox.test(Glu_PC_F_25$GluNorm,Glu_PC_M_25$GluNorm))
print(wilcox.test(Glu_PC_F_25$GluNorm,Glu_PC_M_25$GluNorm)$p.value)

print(wilcox.test(Glu_FFD_F_25$GluNorm,Glu_FFD_M_25$GluNorm))
print(wilcox.test(Glu_FFD_F_25$GluNorm,Glu_FFD_M_25$GluNorm)$p.value)

print(wilcox.test(Glu_PC_M_25$GluNorm,Glu_FFD_M_25$GluNorm))
print(wilcox.test(Glu_PC_M_25$GluNorm,Glu_FFD_M_25$GluNorm)$p.value)

print(wilcox.test(Glu_PC_F_25$GluNorm,Glu_FFD_F_25$GluNorm))
print(wilcox.test(Glu_PC_F_25$GluNorm,Glu_FFD_F_25$GluNorm)$p.value)


sink()