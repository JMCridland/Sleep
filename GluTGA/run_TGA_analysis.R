sink(file="TGA_analysis_21.txt",append=FALSE,split=FALSE)

x<-read.table("21C_TGA_Clean.txt",header=T)

modCanS<-lm(x$TGA.CanS ~ x$TGA.Plate)

print(summary(modCanS))

modPro<-lm(x$TGA.Prot ~ x$TGA.Plate)

print(summary(modPro))

TGA_FFD_F_21<-subset(x,x$Pop=="FFD"&x$Sex=="F")
TGA_FFD_M_21<-subset(x,x$Pop=="FFD"&x$Sex=="M")
TGA_PC_F_21<-subset(x,x$Pop=="PC"&x$Sex=="F")
TGA_PC_M_21<-subset(x,x$Pop=="PC"&x$Sex=="M")

print(shapiro.test(TGA_FFD_F_21$TGA.CanS))

print(shapiro.test(TGA_FFD_M_21$TGA.CanS))

print(shapiro.test(TGA_PC_F_21$TGA.CanS))

print(shapiro.test(TGA_PC_M_21$TGA.CanS))

print(shapiro.test(TGA_FFD_F_21$TGA.Prot))

print(shapiro.test(TGA_FFD_M_21$TGA.Prot))

print(shapiro.test(TGA_PC_F_21$TGA.Prot))

print(shapiro.test(TGA_PC_M_21$TGA.Prot))

print(summary(TGA_FFD_F_21))

print(summary(TGA_FFD_M_21))

print(summary(TGA_PC_F_21))

print(summary(TGA_PC_M_21))



##FFD
print(paste("TGA_FFD_F_21_CanS"))
print(mean(TGA_FFD_F_21$TGA.CanS,na.rm=TRUE))

print(paste("TGA_FFD_F_21_Pro"))
print(mean(TGA_FFD_F_21$TGA.Prot,na.rm=TRUE))

print(paste("TGA_FFD_M_21_CanS"))
print(mean(TGA_FFD_M_21$TGA.CanS,na.rm=TRUE))

print(paste("TGA_FFD_M_21_Pro"))
print(mean(TGA_FFD_M_21$TGA.Prot,na.rm=TRUE))


###PC
print(paste("TGA_PC_F_21_CanS"))
print(mean(TGA_PC_F_21$TGA.CanS,na.rm=TRUE))

print(paste("TGA_PC_F_21_Pro"))
print(mean(TGA_PC_F_21$TGA.Prot,na.rm=TRUE))

print(paste("TGA_PC_M_21_CanS"))
print(mean(TGA_PC_M_21$TGA.CanS,na.rm=TRUE))

print(paste("TGA_PC_M_21_Pro"))
print(mean(TGA_PC_M_21$TGA.Prot,na.rm=TRUE))


print(wilcox.test(TGA_PC_F_21$TGA.CanS,TGA_PC_M_21$TGA.CanS))
print(wilcox.test(TGA_PC_F_21$TGA.CanS,TGA_PC_M_21$TGA.CanS)$p.value)

print(wilcox.test(TGA_FFD_F_21$TGA.CanS,TGA_FFD_M_21$TGA.CanS))
print(wilcox.test(TGA_FFD_F_21$TGA.CanS,TGA_FFD_M_21$TGA.CanS)$p.value)

print(wilcox.test(TGA_PC_M_21$TGA.CanS,TGA_FFD_M_21$TGA.CanS))
print(wilcox.test(TGA_PC_M_21$TGA.CanS,TGA_FFD_M_21$TGA.CanS)$p.value)

print(wilcox.test(TGA_PC_F_21$TGA.CanS,TGA_FFD_F_21$TGA.CanS))
print(wilcox.test(TGA_PC_F_21$TGA.CanS,TGA_FFD_F_21$TGA.CanS)$p.value)


print(wilcox.test(TGA_PC_F_21$TGA.Prot,TGA_PC_M_21$TGA.Prot))
print(wilcox.test(TGA_PC_F_21$TGA.Prot,TGA_PC_M_21$TGA.Prot)$p.value)

print(wilcox.test(TGA_FFD_F_21$TGA.Prot,TGA_FFD_M_21$TGA.Prot))
print(wilcox.test(TGA_FFD_F_21$TGA.Prot,TGA_FFD_M_21$TGA.Prot)$p.value)

print(wilcox.test(TGA_PC_M_21$TGA.Prot,TGA_FFD_M_21$TGA.Prot))
print(wilcox.test(TGA_PC_M_21$TGA.Prot,TGA_FFD_M_21$TGA.Prot)$p.value)

print(wilcox.test(TGA_PC_F_21$TGA.Prot,TGA_FFD_F_21$TGA.Prot))
print(wilcox.test(TGA_PC_F_21$TGA.Prot,TGA_FFD_F_21$TGA.Prot)$p.value)


sink()


sink(file="TGA_analysis_25.txt",append=FALSE,split=FALSE)

x<-read.table("25C_TGA_Clean.txt",header=T)

modPro<-lm(x$TGA.Prot ~ x$TGA.Plate)

print(summary(modPro))

TGA_FFD_F_25<-subset(x,x$Pop=="FFD"&x$Sex=="F")
TGA_FFD_M_25<-subset(x,x$Pop=="FFD"&x$Sex=="M")
TGA_PC_F_25<-subset(x,x$Pop=="PC"&x$Sex=="F")
TGA_PC_M_25<-subset(x,x$Pop=="PC"&x$Sex=="M")


print(shapiro.test(TGA_FFD_F_25$TGA.Protein))

print(shapiro.test(TGA_FFD_M_25$TGA.Protein))

print(shapiro.test(TGA_PC_F_25$TGA.Protein))

print(shapiro.test(TGA_PC_M_25$TGA.Protein))

print(summary(TGA_FFD_F_25))

print(summary(TGA_FFD_M_25))

print(summary(TGA_PC_F_25))

print(summary(TGA_PC_M_25))



##FFD
print(paste("TGA_FFD_F_25_Pro"))
print(mean(TGA_FFD_F_25$TGA.Prot,na.rm=TRUE))

print(paste("TGA_FFD_M_25_Pro"))
print(mean(TGA_FFD_M_25$TGA.Prot,na.rm=TRUE))


###PC

print(paste("TGA_PC_F_25_Pro"))
print(mean(TGA_PC_F_25$TGA.Protein,na.rm=TRUE))

print(paste("TGA_PC_M_25_Pro"))
print(mean(TGA_PC_M_25$TGA.Protein,na.rm=TRUE))


print(wilcox.test(TGA_PC_F_25$TGA.Protein,TGA_PC_M_25$TGA.Protein))
print(wilcox.test(TGA_PC_F_25$TGA.Protein,TGA_PC_M_25$TGA.Protein)$p.value)

print(wilcox.test(TGA_FFD_F_25$TGA.Protein,TGA_FFD_M_25$TGA.Protein))
print(wilcox.test(TGA_FFD_F_25$TGA.Protein,TGA_FFD_M_25$TGA.Protein)$p.value)

print(wilcox.test(TGA_PC_M_25$TGA.Protein,TGA_FFD_M_25$TGA.Protein))
print(wilcox.test(TGA_PC_M_25$TGA.Protein,TGA_FFD_M_25$TGA.Protein)$p.value)

print(wilcox.test(TGA_PC_F_25$TGA.Protein,TGA_FFD_F_25$TGA.Protein))
print(wilcox.test(TGA_PC_F_25$TGA.Protein,TGA_FFD_F_25$TGA.Protein)$p.value)


sink()
