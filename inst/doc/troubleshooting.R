## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  message = TRUE,
  warning = TRUE,
  collapse = TRUE,
  comment = "#>"
)
library(concurve)

## ----eval=FALSE---------------------------------------------------------------
#  install.packages("concurve", dep = TRUE)

## ----eval=FALSE---------------------------------------------------------------
#  library(devtools)
#  install_github("zadrafi/concurve")

## -----------------------------------------------------------------------------
library(concurve)
set.seed(1031)
GroupA <- rnorm(500)
GroupB <- rnorm(500)
RandomData <- data.frame(GroupA, GroupB)
object <- curve_mean(GroupA, GroupB,
  data = RandomData, method = "default"
)

## -----------------------------------------------------------------------------
head(object[[1]], 5)

## -----------------------------------------------------------------------------
head(object[[2]], 5)

## -----------------------------------------------------------------------------
head(object[[3]], 5)

## ----eval=FALSE---------------------------------------------------------------
#  library(parallel)
#  options(mc.cores = detectCores())

## -----------------------------------------------------------------------------
library(bench)
func1 <- bench::mark(df1 <- curve_rev(point = 1.61, LL = 0.997, UL = 2.59, 
                                      measure = "ratio", steps = 100), memory = FALSE)

func2 <- bench::mark(df1 <- curve_rev(point = 1.61, LL = 0.997, UL = 2.59, 
                                      measure = "ratio", steps = 10000), memory = FALSE)

func1
func2

## ----session_info, include=TRUE, echo=FALSE-----------------------------------
sessionInfo()

