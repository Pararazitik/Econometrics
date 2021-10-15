import pandas as pd
import statsmodels.formula.api as sm
import statsmodels.stats as smd
import statsmodels.stats.api as sms
from statsmodels.compat import lzip


data = pd.read_csv('Telitsyn.txt', sep='\s+', decimal=",").astype('float')

model = sm.ols(formula='y ~ x1+x2+x3', data = data)

result = model.fit()

sum = result.summary()
print(sum)

residuals = result.resid

dw = smd.stattools.durbin_watson(residuals)
print(dw)

print(smd.diagnostic.acorr_breusch_godfrey(result))

name=['Chisq statistic','p-value', 'F statistic','p-value(F)']
bg=sms.acorr_breusch_godfrey(result,nlags=1)
print(lzip(name,bg))

name=['F statistic','p-value']
gq=sms.het_goldfeldquandt(residuals,result.model.exog)
print(lzip(name,gq))

gq=sms.het_goldfeldquandt(residuals,result.model.exog)
print(gq)

name=['BP','p-value']
bp=sms.het_breuschpagan(residuals,result.model.exog)
print(lzip(name,bp))

name=['WT','p-value']
wt=sms.het_white(residuals,result.model.exog)
print(lzip(name,wt))

print(smd.sandwich_covariance.cov_hc3(result))

print(result.cov_HC3)

print(smd.sandwich_covariance.cov_hac(result))
