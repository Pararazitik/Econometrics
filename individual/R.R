library(lmtest)
library(zoo)

setwd('C:/Users/Parazitik/PycharmProjects/R')
data <- read.table('Telitsyn.txt',  header=TRUE)

y <- data$y
x1 <- data$x1
x2 <- data$x2
x3 <- data$x3

m <- lm(y ~ x1, data = data)
sm <- summary(m);sm
A <- (sum(abs(sm$residuals/y))/length(y))*100;A

gq <- gqtest(m, order.by= ~y, fraction=0, data=data);gq

bp <- bptest(m, data=data);bp

dw <- dwtest(m);dw

bg <- bgtest(m, order = 1);bg
bgF <- bgtest(m, order = 1, type = "F");bgF

m<-lm(y ~ x1 + x2 + x3, data = data);m
sm<-summary(m);sm
A1 <- (sum(abs(sm$residuals/y))/length(y))*100

print(sm$sigma)
print(sm$r.squared)
print(sm$fstatistic)
print(A1)

sm <- summary(m);sm
e <- sm$residuals;e

gq <- gqtest(m, order.by= ~y, fraction=0, data=data);gq

bp <- bptest(m, data=data);bp

dw <- dwtest(m);dw

bg <- bgtest(m, order = 1);bg
bgF <- bgtest(m, order = 1, type = "F");bgF

plot(data$x1, e^2)
plot(data$x2, e^2)
plot(data$x3, e^2)
