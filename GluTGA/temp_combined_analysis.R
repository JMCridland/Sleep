sink(file="Temp_analysis.txt",append=FALSE,split=FALSE)

x<-read.table("Combined_Glucose",header=T)
y<-read.table("Combined_TGA",header=T)
summary(x)
summary(y)

Glu_FFD_F_21<-subset(x,x$Pop=="FFD"&x$Sex=="F"&x$Temp==21)
Glu_FFD_F_25<-subset(x,x$Pop=="FFD"&x$Sex=="F"&x$Temp==25)
Glu_FFD_M_21<-subset(x,x$Pop=="FFD"&x$Sex=="M"&x$Temp==21)
Glu_FFD_M_25<-subset(x,x$Pop=="FFD"&x$Sex=="M"&x$Temp==25)
Glu_PC_F_21<-subset(x,x$Pop=="PC"&x$Sex=="F"&x$Temp==21)
Glu_PC_F_25<-subset(x,x$Pop=="PC"&x$Sex=="F"&x$Temp==25)
Glu_PC_M_21<-subset(x,x$Pop=="PC"&x$Sex=="M"&x$Temp==21)
Glu_PC_M_25<-subset(x,x$Pop=="PC"&x$Sex=="M"&x$Temp==25)
TGA_FFD_F_21<-subset(y,y$Pop=="FFD"&y$Sex=="F"&y$Temp==21)
TGA_FFD_F_25<-subset(y,y$Pop=="FFD"&y$Sex=="F"&y$Temp==25)
TGA_FFD_M_21<-subset(y,y$Pop=="FFD"&y$Sex=="M"&y$Temp==21)
TGA_FFD_M_25<-subset(y,y$Pop=="FFD"&y$Sex=="M"&y$Temp==25)
TGA_PC_F_21<-subset(y,y$Pop=="PC"&y$Sex=="F"&y$Temp==21)
TGA_PC_F_25<-subset(y,y$Pop=="PC"&y$Sex=="F"&y$Temp==25)
TGA_PC_M_21<-subset(y,y$Pop=="PC"&y$Sex=="M"&y$Temp==21)
TGA_PC_M_25<-subset(y,y$Pop=="PC"&y$Sex=="M"&y$Temp==25)

w<-wilcox.test(Glu_FFD_F_21$GluCanS,Glu_FFD_F_25$GluCanS)
print(w)

w<-wilcox.test(Glu_FFD_M_21$GluCanS,Glu_FFD_M_25$GluCanS)
print(w)

w<-wilcox.test(Glu_PC_F_21$GluCanS,Glu_PC_F_25$GluCanS)
print(w)

w<-wilcox.test(Glu_PC_M_21$GluCanS,Glu_PC_M_25$GluCanS)
print(w)

w<-wilcox.test(Glu_PC_M_21$GluCanS,Glu_FFD_M_21$GluCanS)
print(w)

w<-wilcox.test(Glu_PC_F_21$GluCanS,Glu_FFD_F_21$GluCanS)
print(w)

w<-wilcox.test(Glu_PC_M_25$GluCanS,Glu_FFD_M_25$GluCanS)
print(w)

w<-wilcox.test(Glu_PC_F_25$GluCanS,Glu_FFD_F_25$GluCanS)
print(w)



#w<-wilcox.test(TGA_FFD_F_21$TGACanS,TGA_FFD_F_25$TGACanS)
#print(w)

#w<-wilcox.test(TGA_FFD_M_21$TGACanS,TGA_FFD_M_25$TGACanS)
#print(w)

#w<-wilcox.test(TGA_PC_F_21$TGACanS,TGA_PC_F_25$TGACanS)
#print(w)

#w<-wilcox.test(TGA_PC_M_21$TGACanS,TGA_PC_M_25$TGACanS)
#print(w)

w<-wilcox.test(TGA_PC_M_21$TGACanS,TGA_FFD_M_21$TGACanS)
print(w)

w<-wilcox.test(TGA_PC_F_21$TGACanS,TGA_FFD_F_21$TGACanS)
print(w)

#w<-wilcox.test(TGA_PC_M_25$TGACanS,TGA_FFD_M_25$TGACanS)
#print(w)

#w<-wilcox.test(TGA_PC_F_25$TGACanS,TGA_FFD_F_25$TGACanS)
#print(w)


##################

w<-wilcox.test(Glu_FFD_F_21$GluPro,Glu_FFD_F_25$GluPro)
print(w)

w<-wilcox.test(Glu_FFD_M_21$GluPro,Glu_FFD_M_25$GluPro)
print(w)

w<-wilcox.test(Glu_PC_F_21$GluPro,Glu_PC_F_25$GluPro)
print(w)

w<-wilcox.test(Glu_PC_M_21$GluPro,Glu_PC_M_25$GluPro)
print(w)

w<-wilcox.test(Glu_PC_M_21$GluPro,Glu_FFD_M_21$GluPro)
print(w)

w<-wilcox.test(Glu_PC_F_21$GluPro,Glu_FFD_F_21$GluPro)
print(w)

w<-wilcox.test(Glu_PC_M_25$GluPro,Glu_FFD_M_25$GluPro)
print(w)

w<-wilcox.test(Glu_PC_F_25$GluPro,Glu_FFD_F_25$GluPro)
print(w)



w<-wilcox.test(TGA_FFD_F_21$TGAPro,TGA_FFD_F_25$TGAPro)
print(w)

w<-wilcox.test(TGA_FFD_M_21$TGAPro,TGA_FFD_M_25$TGAPro)
print(w)

w<-wilcox.test(TGA_PC_F_21$TGAPro,TGA_PC_F_25$TGAPro)
print(w)

w<-wilcox.test(TGA_PC_M_21$TGAPro,TGA_PC_M_25$TGAPro)
print(w)

w<-wilcox.test(TGA_PC_M_21$TGAPro,TGA_FFD_M_21$TGAPro)
print(w)

w<-wilcox.test(TGA_PC_F_21$TGAPro,TGA_FFD_F_21$TGAPro)
print(w)

w<-wilcox.test(TGA_PC_M_25$TGAPro,TGA_FFD_M_25$TGAPro)
print(w)

w<-wilcox.test(TGA_PC_F_25$TGAPro,TGA_FFD_F_25$TGAPro)
print(w)


sink()


