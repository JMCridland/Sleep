sink(file="TGA25_analysis.txt",append=FALSE,split=FALSE)

x<-read.table("25C_TGA_Clean.txt",header=T)

summary(x)


FFD_M<-subset(x,x$Pop=="FFD"&x$Sex=="M")
FFD_F<-subset(x,x$Pop=="FFD"&x$Sex=="F")
PC_M<-subset(x,x$Pop=="PC"&x$Sex=="M")
PC_F<-subset(x,x$Pop=="PC"&x$Sex=="F")

print(shapiro.test(FFD_M$TGA.Protein))

print(shapiro.test(FFD_F$TGA.Protein))

print(shapiro.test(PC_M$TGA.Protein))

print(shapiro.test(PC_F$TGA.Protein))

w<-wilcox.test(FFD_M$TGA.Protein,PC_M$TGA.Protein)
print(w)

w<-wilcox.test(FFD_F$TGA.Protein,PC_F$TGA.Protein)
print(w)

w<-wilcox.test(FFD_M$TGA.Protein,FFD_F$TGA.Protein)
print(w)

w<-wilcox.test(PC_M$TGA.Protein,PC_F$TGA.Protein)
print(w)

sink()


sink(file="TGA21_analysis.txt",append=FALSE,split=FALSE)

y<-read.table("21C_TGA_Clean.txt",header=T)


FFD_M<-subset(y,y$Pop=="FFD"&y$Sex=="M")
FFD_F<-subset(y,y$Pop=="FFD"&y$Sex=="F")
PC_M<-subset(y,y$Pop=="PC"&y$Sex=="M")
PC_F<-subset(y,y$Pop=="PC"&y$Sex=="F")

print(shapiro.test(FFD_M$TGA.Prot))

print(shapiro.test(FFD_F$TGA.Prot))

print(shapiro.test(PC_M$TGA.Prot))

print(shapiro.test(PC_F$TGA.Prot))

print(shapiro.test(FFD_M$TGA.CanS))

print(shapiro.test(FFD_F$TGA.CanS))

print(shapiro.test(PC_M$TGA.CanS))

print(shapiro.test(PC_F$TGA.CanS))


w<-wilcox.test(FFD_M$TGA.Prot,PC_M$TGA.Prot)
print(w)

w<-wilcox.test(FFD_F$TGA.Prot,PC_F$TGA.Prot)
print(w)

w<-wilcox.test(FFD_M$TGA.Prot,FFD_F$TGA.Prot)
print(w)

w<-wilcox.test(PC_M$TGA.Prot,PC_F$TGA.Prot)
print(w)


w<-wilcox.test(FFD_M$TGA.CanS,PC_M$TGA.CanS)
print(w)

w<-wilcox.test(FFD_F$TGA.CanS,PC_F$TGA.CanS)
print(w)

w<-wilcox.test(FFD_M$TGA.CanS,FFD_F$TGA.CanS)
print(w)

w<-wilcox.test(PC_M$TGA.CanS,PC_F$TGA.CanS)
print(w)

sink()




sink(file="Glu21_analysis.txt",append=FALSE,split=FALSE)

z<-read.table("21C_Glu_Clean.txt",header=T)


FFD_M<-subset(z,z$Pop=="FFD"&z$Sex=="M")
FFD_F<-subset(z,z$Pop=="FFD"&z$Sex=="F")
PC_M<-subset(z,z$Pop=="PC"&z$Sex=="M")
PC_F<-subset(z,z$Pop=="PC"&z$Sex=="F")

print(shapiro.test(FFD_M$Glu.Pro))

print(shapiro.test(FFD_F$Glu.Pro))

print(shapiro.test(PC_M$Glu.Pro))

print(shapiro.test(PC_F$Glu.Pro))

print(shapiro.test(FFD_M$Glu.CanS))

print(shapiro.test(FFD_F$Glu.CanS))

print(shapiro.test(PC_M$Glu.CanS))

print(shapiro.test(PC_F$Glu.CanS))


w<-wilcox.test(FFD_M$Glu.Pro,PC_M$Glu.Pro)
print(w)

w<-wilcox.test(FFD_F$Glu.Pro,PC_F$Glu.Pro)
print(w)

w<-wilcox.test(FFD_M$Glu.Pro,FFD_F$Glu.Pro)
print(w)

w<-wilcox.test(PC_M$Glu.Pro,PC_F$Glu.Pro)
print(w)


w<-wilcox.test(FFD_M$Glu.CanS,PC_M$Glu.CanS)
print(w)

w<-wilcox.test(FFD_F$Glu.CanS,PC_F$Glu.CanS)
print(w)

w<-wilcox.test(FFD_M$Glu.CanS,FFD_F$Glu.CanS)
print(w)

w<-wilcox.test(PC_M$Glu.CanS,PC_F$Glu.CanS)
print(w)

sink()


sink(file="Glu25_analysis.txt",append=FALSE,split=FALSE)

q<-read.table("25C_Glu_Clean.txt",header=T)


FFD_M<-subset(q,q$Pop=="FFD"&q$Sex=="M")
FFD_F<-subset(q,q$Pop=="FFD"&q$Sex=="F")
PC_M<-subset(q,q$Pop=="PC"&q$Sex=="M")
PC_F<-subset(q,q$Pop=="PC"&q$Sex=="F")

print(shapiro.test(FFD_M$GluNorm))

print(shapiro.test(FFD_F$GluNorm))

print(shapiro.test(PC_M$GluNorm))

print(shapiro.test(PC_F$GluNorm))

print(shapiro.test(FFD_M$Glu.CanS))

print(shapiro.test(FFD_F$Glu.CanS))

print(shapiro.test(PC_M$Glu.CanS))

print(shapiro.test(PC_F$Glu.CanS))


w<-wilcox.test(FFD_M$GluNorm,PC_M$GluNorm)
print(w)

w<-wilcox.test(FFD_F$GluNorm,PC_F$GluNorm)
print(w)

w<-wilcox.test(FFD_M$GluNorm,FFD_F$GluNorm)
print(w)

w<-wilcox.test(PC_M$GluNorm,PC_F$GluNorm)
print(w)


w<-wilcox.test(FFD_M$Glu.CanS,PC_M$Glu.CanS)
print(w)

w<-wilcox.test(FFD_F$Glu.CanS,PC_F$Glu.CanS)
print(w)

w<-wilcox.test(FFD_M$Glu.CanS,FFD_F$Glu.CanS)
print(w)

w<-wilcox.test(PC_M$Glu.CanS,PC_F$Glu.CanS)
print(w)

sink()