library(tseries)
data()
load(airmiles)
x<-data(GNP)
GNP

library(Rcmdr)

library(tseries)
data(USeconomic, package="tseries")
USeconomic <- as.data.frame(USeconomic)
names(USeconomic) <- make.names(names(USeconomic))

names(GNP)
names(USeconomic)
attach(USeconomic)
acf(cbind(USeconomic$log.M1, USeconomic$log.GNP), type="p")

acf(cbind(USeconomic$log.M1, USeconomic$log.GNP))

par(mfrow=c(1,2))
acf(USeconomic$log.M1)
acf( USeconomic$log.GNP)
----
  

library(foreign)
library(tseries)


starts <-   read.dta("J:/Research/All_else_being_equal/Chapters/Ch_12/Data/to_starts_v12.dta", convert.dates=TRUE, convert.factors=TRUE, missing.type=TRUE,   convert.underscore=TRUE, warn.missing.labels=TRUE)
names(starts)




```{r}
data1 <- ts(starts[,1:68], start = c(1987,3), frequency = 12)
data2<-as.data.frame(data1)
```
names(data2)

```{r}
acf(data2$to.st.to,na.action=na.pass)
pacf(data2$to.st.to,na.action=na.pass)
```

```{r}
library(forecast)
fit <- auto.arima(data2[,23])
summary(fit)
plot(forecast(fit,h=20))

```

```{r}
summary(arima(data2[,2], order= c(2,1,0)))
tsdiag(fit)
```

Dickey Fuller Test
```{r}
adf.test(na.omit(data2[,2]))
adf.test(na.omit(diff(data2[,2])))
```

```{r}
fdi<-na.omit(data2[,1:2])
auto.arima(fdi[,2], xreg=fdi[,1])
```


```{r, eval=FALSE}
mod1<-arima(fdi[,2], order = c(0,1,1), xreg=fdi[,1])
summary(mod1)
forecast(mod1,h=2)
```


