

# load NY.rda"



library(lattice)
## use the following option in xyplot
par.settings = standard.theme(color = FALSE),

# General commands
lattice.options(default.theme = standard.theme(color = FALSE))
trellis.device(color = FALSE)
palette("default")
palette(c("gray", "black"))  ## The best option perhaps?

NY$f.m.hhinc <- factor(NY$f.m.hhinc, labels=c('low inc','med inc','high inc'))

## Fig 32 Density map

##Scatter Plot using CAR

dev.off()

palette(gray(0:3 / 3))
## Fig 33, don't forget the grey pallette command
library(car)
png(file="05fig33.png",   units="px",     width=700,     height=906, res=150 )
scatterplot(m.commtime~p.transit | f.m.hhinc, reg.line=lm, smooth=TRUE,
            xlab="percent of transit commutes", ylab="median commute time",
            spread=TRUE, boxplots='xy', span=0.5, by.groups=TRUE,  data=NY)
dev.off() 

## Table of distance and ranges
tab1<-tapply(NY$d.cbd, NY$f.d.cbd,mean); tab1
tab2<-tapply(NY$d.cbd, NY$f.d.cbd,range); as.data.frame(tab2)
tab3<-cbind(tab1,as.data.frame(tab2))
colnames(tab3) <- c("mean distance", "range")
print(tab3, digits=2)


## Fig 34
## Best layout and arrangement
dev.off()


key.variety <- list(space = "top", text = list(levels(NY$f.m.hhinc)), border=TRUE,
                    columns=4, points = list(pch = 16, col = c(gray(0:3/3))))

trellis.device(color = FALSE)
png(file="05fig34.png",   units="px",     width=750,     height=856, res=126 )
xyplot(m.commtime ~ p.transit | f.d.cbd, outer=TRUE, layout=c(2, 3), 
       groups=f.m.hhinc, type="p", pch=16, col.symbol = c(gray(0:3 / 3)),
       key = key.variety, par.settings = standard.theme(color = FALSE),
       scales=list(x=list(relation='free'), y=list(relation='free')), 
       xlab="percent of transit commutes", ylab= "median commute time (min)", data=NY)
dev.off()

## Fig 35
png(file="05fig35.png",   units="px",     width=800,     height=406, res=96 )
plot(NY$f.d.cbd, NY$m.commtime,
     xlab="distance from downtown Manhattan", ylab="median commute time (min)")
dev.off()


## Fig 36
png(file="05fig36.png",   units="px",     width=500,     height=706, res=96 )
barplot(tapply(NY$m.commtime, NY$f.m.hhinc,mean,na.rm=T), ylim=c(0,45), 
        ylab= "median commute time (min)", xlab="household income categories")
dev.off()

## Fig 37
png(file="05fig37.png",   units="px",     width=500,     height=806, res=96 )
barplot(tapply(NY$m.commtime, list(NY$f.m.hhinc, NY$f.d.cbd),mean,na.rm=T), 
        horiz=T, beside=T, xlim=c(0,55), legend=T,
        ylab= "distance from downtown Manhattan", xlab="median commute time (min)")
dev.off()

## Fig 38
png(file="05fig38.png",   units="px",     width=700,     height=406, res=96 )
xyplot(p.transit ~ ct.dens|f.m.hhinc, data = NY,
       type = c("p", "g", "smooth"), pch=16, lwd=2, col.symbol = "dark grey",
       xlab = "census tract density (person/ sq. km.)", xlim=c(0,20000),
       ylab= "percent of transit commutes")

dev.off()

## Fig 39
png(file="05fig39.png",   units="px",     width=700,     height=406, res=96 )
xyplot(m.commtime ~ ct.dens|f.m.hhinc, data = NY,
       type = c("p", "g", "smooth"), pch=16, lwd=2, col.symbol = "dark grey",
       xlab = "census tract density (person/ sq. km.)", xlim=c(0,20000),
       ylab= "median commute time (min)")

dev.off()

## Fig 40 Blacks
png(file="05fig40.png",   units="px",     width=700,     height=406, res=96 )
xyplot(m.commtime ~ p.black|f.m.hhinc, data = NY,
       type = c("p", "g", "smooth"), pch=16, lwd=2, col.symbol = "dark grey",
       xlab = "African Americans (%)", ylab= "median commute time (min)")

dev.off()

## Fig 41 Hispanics
png(file="05fig41.png",   units="px",     width=700,     height=406, res=96 )
xyplot(m.commtime ~ p.hispanic|f.m.hhinc, data = NY,
       type = c("p", "g", "smooth"), pch=16, lwd=2, col.symbol = "dark grey",
       xlab = "Hispanics (%)", ylab= "median commute time (min)")

dev.off()

## Fig 42 Asian
png(file="05fig42.png",   units="px",     width=700,     height=406, res=96 )
xyplot(m.commtime ~ p.asian|f.m.hhinc, data = NY,
       type = c("p", "g", "smooth"), pch=16, lwd=2, col.symbol = "dark grey",
       xlab = "Asians (%)", ylab= "median commute time (min)")

dev.off()

## Fig 43 Whites
png(file="05fig43.png",   units="px",     width=700,     height=406, res=96 )
xyplot(m.commtime ~ p.white|f.m.hhinc, data = NY,
       type = c("p", "g", "smooth"), pch=16, lwd=2, col.symbol = "dark grey",
       xlab = "White population (%)", ylab= "median commute time (min)")

dev.off()


## Fig 44 poverty
png(file="05fig44.png",   units="px",     width=700,     height=406, res=96 )
xyplot(m.commtime ~ p.poverty|f.m.hhinc, data = NY, xlim=c(0,60),
       type = c("p", "g", "smooth"), pch=16, lwd=2, col.symbol = "dark grey",
       xlab = "low-income households (%)", ylab= "median commute time (min)")
dev.off()

## Fig 45 single mothers
png(file="05fig45.png",   units="px",     width=700,     height=406, res=96 )
xyplot(m.commtime ~ p.singmom| f.m.hhinc, data = NY, scales = list(x = "free"),
       type = c("p", "g", "smooth"), pch=16, lwd=2, col.symbol = "dark grey",
       xlab = "single mothers (%)", ylab= "median commute time (min)")
dev.off()

## Fig 46 children
png(file="05fig46.png",   units="px",     width=700,     height=406, res=96 )
xyplot(m.commtime ~ p.children|f.m.hhinc, data = NY,
       type = c("p", "g", "smooth"), pch=16, lwd=2, col.symbol = "dark grey",
       xlab = "households with children (%)", ylab= "median commute time (min)")
dev.off()


############### LA  ###############



dev.off()
palette(gray(0:3 / 3))

## Fig 47
png(file="05fig47.png",   units="px",     width=700,     height=806, res=96 )
scatterplot(m.commtime~p.transit | f.m.hhinc, reg.line=lm, smooth=TRUE,
            xlab="percent of transit commutes", ylab="median commute time",
            spread=TRUE, boxplots='xy', span=0.5, by.groups=TRUE,  data=LA)
dev.off() 

## Best layout and arrangement
dev.off()


## Fig 48
key.variety <- list(space = "top", text = list(levels(LA$f.m.hhinc)), border=TRUE,
                    columns=4, points = list(pch = 16, col = c(gray(0:3/3))))
trellis.device(color = FALSE)

png(file="05fig48.png",   units="px",     width=750,     height=856, res=126 )
xyplot(m.commtime ~ p.transit | f.d.cbd, outer=TRUE, layout=c(2, 3), 
       groups=f.m.hhinc, type="p", pch=16, col.symbol = c(gray(0:3 / 3)),
       key = key.variety,
       scales=list(x=list(relation='free'), y=list(relation='free')), 
       xlab="percent of transit commutes", ylab= "mean commute time (min)", data=LA)
dev.off()

## Fig 49
png(file="05fig49.png",   units="px",     width=800,     height=406, res=96 )
plot(LA$f.d.cbd, LA$m.commtime,
     xlab="distance from downtown LA", ylab="median commute time (min)")
dev.off()

## Fig 50
png(file="05fig50.png",   units="px",     width=800,     height=406, res=96 )
barplot(tapply(LA$d.cbd, LA$f.d.cbd,mean), ylim =c(0, 145),
        ylab="average distance from downtown LA (km)", xlab="distance from downtown LA")
dev.off()

## Fig 51
png(file="05fig51.png",   units="px",     width=500,     height=706, res=96 )
barplot(tapply(LA$m.commtime, LA$f.m.hhinc,mean,na.rm=T), ylim=c(0,45), 
        ylab= "median commute time (min)", xlab="household income categories")
dev.off()

## Fig 52
png(file="05fig52.png",   units="px",     width=500,     height=806, res=96 )
barplot(tapply(LA$m.commtime, list(LA$f.m.hhinc, LA$f.d.cbd),mean,na.rm=T), 
        horiz=T, beside=T, xlim=c(0,55), legend=T,
        ylab= "distance from downtown LA", xlab="median commute time (min)")
dev.off()

## Fig 53
png(file="05fig53.png",   units="px",     width=700,     height=406, res=96 )
xyplot(p.transit ~ ct.dens|f.m.hhinc, data = LA, scales = list(x = "free", y= "free"),
       type = c("p", "g", "smooth"), pch=16, lwd=2, col.symbol = "dark grey",
       xlab = "census tract density (person/ sq. km.)", xlim=c(0,20000),
       ylab= "percent of transit commutes")
dev.off()

## Fig 54
png(file="05fig54.png",   units="px",     width=700,     height=406, res=96 )
xyplot(m.commtime ~ ct.dens|f.m.hhinc, data = LA, scales = list(x = "free", y= "free"),
       type = c("p", "g", "smooth"), pch=16, lwd=2, col.symbol = "dark grey",
       xlab = "census tract density (person/ sq. km.)", xlim=c(0,20000),
       ylab= "median commute time (min)")
dev.off()

## Fig 55 Blacks
png(file="05fig55.png",   units="px",     width=700,     height=406, res=96 )
xyplot(m.commtime ~ p.black|f.m.hhinc, data = LA, scales = list(x = "free", y= "free"),
       type = c("p", "g", "smooth"), pch=16, lwd=2, col.symbol = "dark grey",
       xlab = "African Americans (%)", ylab= "median commute time (min)")
dev.off()

## Fig 56 Hispanics
png(file="05fig56.png",   units="px",     width=700,     height=406, res=96 )
xyplot(m.commtime ~ p.hispanic|f.m.hhinc, data = LA, scales = list(x = "free", y= "free"),
       type = c("p", "g", "smooth"), pch=16, lwd=2, col.symbol = "dark grey",
       xlab = "Hispanics (%)", ylab= "median commute time (min)")
dev.off()

## Fig 57 Asian
png(file="05fig57.png",   units="px",     width=700,     height=406, res=96 )
xyplot(m.commtime ~ p.asian|f.m.hhinc, data = LA, scales = list(x = "free", y= "free"),
       type = c("p", "g", "smooth"), pch=16, lwd=2, col.symbol = "dark grey",
       xlab = "Asians (%)", ylab= "median commute time (min)")
dev.off()

## Fig 58 Whites
png(file="05fig58.png",   units="px",     width=700,     height=406, res=96 )
xyplot(m.commtime ~ p.white|f.m.hhinc, data = LA,
       type = c("p", "g", "smooth"), pch=16, lwd=2, col.symbol = "dark grey",
       xlab = "White population (%)", ylab= "median commute time (min)")
dev.off()


## Fig 59 poverty
png(file="05fig59.png",   units="px",     width=700,     height=406, res=96 )
xyplot(m.commtime ~ p.poverty|f.m.hhinc, data = LA, scales = list(x = "free", y= "free"),
       type = c("p", "g", "smooth"), pch=16, lwd=2, col.symbol = "dark grey",
       xlab = "low-income households (%)", ylab= "median commute time (min)")
dev.off()

## Fig 60 single mothers
png(file="05fig60.png",   units="px",     width=700,     height=406, res=96 )
xyplot(m.commtime ~ p.singmom| f.m.hhinc, data = LA, scales = list(x = "free", y= "free"),
       type = c("p", "g", "smooth"), pch=16, lwd=2, col.symbol = "dark grey",
       xlab = "single mothers (%)", ylab= "median commute time (min)")
dev.off()

## Fig 61 children
png(file="05fig61.png",   units="px",     width=700,     height=406, res=96 )
xyplot(m.commtime ~ p.children|f.m.hhinc, data = LA, scales = list(x = "free", y= "free"),
       type = c("p", "g", "smooth"), pch=16, lwd=2, col.symbol = "dark grey",
       xlab = "households with children (%)", ylab= "median commute time (min)")
dev.off()
