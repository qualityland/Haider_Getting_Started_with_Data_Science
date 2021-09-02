# load teachingratings.rda

library(lattice)
lattice.options(default.theme = standard.theme(color = FALSE))
trellis.device(color = FALSE)

 # ?lattice
# data()
data(Titanic, package="datasets")
Titanic <- as.data.frame(Titanic)



## Fig 1
png(file="05fig01.png",   units="px",     width=700,     height=406, res=96 )
barchart(Class ~ Freq | Sex + Age, data = as.data.frame(Titanic), 
         groups = Survived, stack = TRUE, layout = c(4, 1), 
         auto.key = list(title = "Survived", columns = 2), 
         par.settings = standard.theme(color = F),
         scales = list(x = "free"))
dev.off() 


dev.off() 


## Fig 2
load("C:/Users/Murtaza/Google Drive/AEBE/Chapters/Graphics/codes_data/Beauty/TeachingRatings.rda")
trellis.device(color = FALSE)
png(file="05fig02.png",   units="px",     width=700,     height=406, res=96 )
xyplot(eval ~ beauty, data = TeachingRatings)
dev.off() 

## Fig 3

png(file="05fig03.png",   units="px",     width=700,     height=406, res=96 )
xyplot(eval ~ beauty, data = TeachingRatings,
       xlab = "normalized beauty score",
       ylab= "teaching evaluation score")
dev.off()

## Fig 4
png(file="05fig04.png",   units="px",     width=700,     height=406, res=96 )
xyplot(eval ~ beauty, data = TeachingRatings,
       type = c("p", "g", "smooth"),
       xlab = "normalized beauty score",
       ylab= "teaching evaluation score")
dev.off()

## Fig 5
png(file="05fig05.png",   units="px",     width=700,     height=406, res=96 )
xyplot(eval ~ beauty, data = TeachingRatings,
       type = c("p", "g", "smooth"), pch=16, lwd=2, col.symbol = "dark grey",
       xlab = "normalized beauty score",
       ylab= "teaching evaluation score")
dev.off()

## Fig 6
png(file="05fig06.png",   units="px",     width=700,     height=406, res=96 )
xyplot(eval ~ age, data = TeachingRatings,
       type = c("p", "g", "smooth"), pch=16, lwd=2, col.symbol = "dark grey",
       xlab = "age in years",
       ylab= "teaching evaluation score")
dev.off()


## Fig 7-12 Bar hart

png(file="05fig07.png",   units="px",     width=700,     height=406, res=96 )
plot(TeachingRatings$minority)
dev.off()

png(file="05fig08.png",   units="px",     width=700,     height=406, res=96 )
plot(TeachingRatings$minority,ylim=c(0,500))
dev.off()

png(file="05fig09.png",   units="px",     width=700,     height=406, res=96 )
plot(TeachingRatings$minority,ylim=c(0,500), 
     xlab="minority status", ylab="number of courses")
dev.off()

png(file="05fig10.png",   units="px",     width=700,     height=406, res=96 )
plot(TeachingRatings$gender,horiz=TRUE, xlim=c(0,300),
     ylab="gender", xlab="number of courses")
dev.off()


xtab<-table(x$tenure,x$gender)
png(file="05fig11.png",   units="px",     width=700,     height=406, res=96 )
barplot(xtab, ylim=c(0,300),   legend=rownames(xtab),
        xlab= "gender", ylab= "number of courses")
dev.off()

x<-TeachingRatings
png(file="05fig12a.png",   units="px",     width=700,     height=406, res=96 )
plot(x$gender, x$tenure, ylab="tenure status",  main="Share of courses taught",
     xlab="gender")
dev.off()

## Histogram Fig. 13 to 15

png(file="05fig13.png",   units="px",     width=700,     height=406, res=96 )
histogram(x$beauty)
dev.off()


png(file="05fig14.png",   units="px",     width=700,     height=406, res=96 )
histogram(x$beauty, nint=15,
          xlab="nomalized beauty score", col=c("dark grey"))
dev.off()

png(file="05fig15.png",   units="px",     width=700,     height=406, res=96 )
histogram(x$beauty, nint=15, aspect=2, 
          xlab="nomalized beauty score", col=c("dark grey"))
dev.off()


## Dotplot Fig. 16 and 18
data(barley)

png(file="05fig16a.png",   units="px",     width=700,     height=1000, res=96 )
dotplot(variety ~ yield|year*site, 
        scales=list(y = list(cex=.7)), xlab = "Barley yeild (bushels/acre)", data=barley)
dev.off()


png(file="05fig17a.png",   units="px",     width=700,     height=406, res=96 )
dotplot(variety ~ yield |site,
        panel=panel.superpose, groups=factor(year), 
        xlab = "Barley yeild (bushels/acre)",
        cex=1, auto.key=T, scales=list(y = list(cex=.7)), 
        data=barley)
dev.off()

png(file="05fig18a.png",   units="px",     width=700,     height=700, res=96 )
dotplot(site ~ yield |variety,
        panel=panel.superpose, groups=factor(year),
        xlab = "Barley yeild (bushels/acre)",
        cex=1, auto.key=T, scales=list(y = list(cex=.7)), layout=c(2,5,1),
        data=barley)
dev.off()

## Box Plot Fig. 19
png(file="05fig19.png",   units="px",     width=700,     height=406, res=96 )
plot(TeachingRatings$minority, TeachingRatings$eval,
     xlab="minority status", ylab="teaching evaluation score")
dev.off()


## Mosaic Fig 20
png(file="05fig20a.png",   units="px",     width=700,     height=406, res=96 )
mosaicplot( ~ TeachingRatings$tenure +TeachingRatings$gender,
            main="Tenure status and gender differences in the number of courses taught",
            xlab="tenure status", ylab="gender", cex=1)
dev.off()


## Summary status Fig. 21 - 22
png(file="05fig21a.png",   units="px",     width=700,     height=406, res=96 )
barplot(tapply(x$allstudents, x$gender,mean), ylim =c(0,70),
        ylab="No. of students enrolled", xlab = "instructor's gender")
dev.off()

xtab<-tapply(x$age, list(x$gender,x$tenure), mean)
png(file="05fig22.png",   units="px",     width=700,     height=406, res=96 )
barplot(xtab, legend=rownames(xtab), 
        beside=T, ylim=c(0,65),
        xlab="tenure status", ylab="average age")
dev.off()

png(file="05fig23.png",   units="px",     width=700,     height=406, res=96 )
plot(x$gender, x$age,
     xlab="gender", ylab="instructor's age")
dev.off()


###############  CONDITIONAL PLOTS

png(file="05fig24.png",   units="px",     width=700,     height=406, res=96 )
histogram(~ x$eval | x$gender, nint=15,
          xlab="teaching evaluation score", 
          col=c("dark grey"))
dev.off()

png(file="05fig25.png",   units="px",     width=700,     height=406, res=96 )
histogram(~ x$eval | x$gender * x$tenure, nint=15,
          xlab="teaching evaluation score", col=c("dark grey"))
dev.off()


#### Data manipulation
table(x$tenure)
x$tenure2 <- factor(x$tenure, 
                    levels = c("no", "yes"),
                    labels =c("non-tenured", "tenured"))
table(x$tenure2)
#####

png(file="05fig26.png",   units="px",     width=700,     height=406, res=96 )
histogram(~ x$eval | x$gender * x$tenure2, nint=15,
          xlab="teaching evaluation score",
          col=c("dark grey"))
dev.off()

## Titanic
## Fig. 27
## with proper labels for the x axis

png(file="05fig27.png",   units="px",     width=700,     height=406, res=96 )
barchart(Class ~ Freq | Sex + Age, data = as.data.frame(Titanic), 
         groups = Survived, stack = TRUE, layout = c(4, 1), 
         auto.key = list(title = "Survived", columns = 2), 
         par.settings = standard.theme(color = FALSE),
         xlab="Passengers",
         scales = list(x = "free"))
dev.off()

## Fig. 28

fig.2<-barchart(Class ~ Freq | Sex + Age, data = as.data.frame(Titanic), 
                groups = Survived, stack = TRUE, layout = c(4, 1), 
                auto.key = list(title = "Survived", columns = 2), 
                par.settings = standard.theme(color = FALSE),
                xlab="Passengers",
                scales = list(x = "free"))

png(file="05fig28.png",   units="px",     width=700,     height=406, res=96 )
update(fig.2, 
       panel = function(..., border) {
         panel.barchart(..., border = "transparent")
       })
dev.off()

## Fig 29

tab1 <- table(x$gender, x$tenure2, x$division); tab1
tab2 <- as.data.frame.table(tab1); tab2

png(file="05fig29.png",   units="px",     width=700,     height=406, res=96 )
barchart (Var1 ~ Freq | Var2 + Var3, data=tab2, col=c("dark grey"),
          xlab="number of courses")
dev.off()

## Fig 30
png(file="05fig30.png",   units="px",     width=700,     height=406, res=96 )
xyplot(eval ~ beauty|gender, data = TeachingRatings,
       type = c("p", "g", "smooth"), pch=16, lwd=2, col.symbol = "dark grey",
       xlab = "normalized beauty score",
       ylab= "teaching evaluation score")
dev.off()


## Fig 31
png(file="05fig31.png",   units="px",     width=700,     height=406, res=96 )
xyplot(eval ~ beauty|gender+tenure2, data = x,
       type = c("p", "g", "smooth"), pch=16, lwd=2, col.symbol = "dark grey",
       xlab = "normalized beauty score",
       ylab= "teaching evaluation score")
dev.off()

#######################################

barchart(tab2, stack = FALSE, horizontal = FALSE)
barchart(tab2, stack=F)

##############################

xtab <- tapply(x$beauty, list(x$gender, x$tenure), mean); xtab
xtab <- tapply(x$beauty, list(x$gender), mean); xtab

xtab2 <- as.data.frame.table(xtab);xtab2
barchart(Var1 ~ Freq | Var2, xtab2, cex=1)

as.data.frame.table(xtab)

png(file="05figXX.png",   units="px",     width=700,     height=406, res=96 )

dev.off()

###############

## 2 by 2
barchart(Class ~ Freq | Sex + Age, data = as.data.frame(Titanic), 
         groups = Survived, stack = TRUE, layout = c(2, 2),
         par.settings = standard.theme(color = FALSE),
         auto.key = list(title = "Survived", columns = 2))

