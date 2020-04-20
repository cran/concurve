## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  message = TRUE,
  warning = TRUE,
  collapse = TRUE,
  comment = "#>"
)

## ----echo=TRUE, fig.height=4.5, fig.width=6-----------------------------------
library(metafor)
library(concurve)
library(ggplot2)
dat.hine1989

## ----echo=TRUE, fig.height=4.5, fig.width=6-----------------------------------
dat <- escalc(measure = "RD", n1i = n1i, n2i = n2i, ai = ai, ci = ci, data = dat.hine1989)
dat

## ----echo=TRUE, fig.height=4.5, fig.width=6-----------------------------------
dat$yi <- dat$yi * 100
dat$vi <- dat$vi * 100^2

## ----echo=TRUE, fig.height=4.5, fig.width=6-----------------------------------
fe <- rma(yi, vi, data = dat, method = "FE")

## ----echo=TRUE, fig.height=4.5, fig.width=6-----------------------------------
fecurve <- curve_meta(fe)

## ----echo=TRUE, fig.height=4.5, fig.width=6-----------------------------------
ggcurve(fecurve[[1]], nullvalue = TRUE)

## ----echo=TRUE, fig.height=4.5, fig.width=6-----------------------------------
re <- rma(yi, vi, data = dat, method = "REML")

## ----echo=TRUE, fig.height=4.5, fig.width=6-----------------------------------
recurve <- curve_meta(re)

## ----echo=TRUE, fig.height=4.5, fig.width=6-----------------------------------
ggcurve(recurve[[1]], nullvalue = TRUE)

## ----echo=TRUE, fig.height=4.5, fig.width=6-----------------------------------
curve_compare(fecurve[[1]], recurve[[1]], plot = TRUE)

## ----echo=TRUE, fig.height=4.5, fig.width=6-----------------------------------

### copy data from Berkey et al. (1998) into 'dat'
dat <- dat.berkey1998

### construct list of the variance-covariance matrices of the observed outcomes for the studies
V <- lapply(split(dat[, c("v1i", "v2i")], dat$trial), as.matrix)

### construct block diagonal matrix
V <- bldiag(V)

### fit multivariate model
res <- rma.mv(yi, V, mods = ~ outcome - 1, random = ~ outcome | trial, struct = "UN", data = dat)

### results based on sandwich method
(a <- robust(res, cluster = dat$trial))

l <- concurve::curve_meta(res, method = "uni", robust = TRUE, cluster = dat$trial, adjust = TRUE, steps = 1000)

ggcurve(data = l[[1]], type = "c") +
  theme_minimal()

