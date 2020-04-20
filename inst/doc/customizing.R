## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  message = TRUE,
  warning = TRUE,
  collapse = TRUE,
  comment = "#>"
)

## ----echo=TRUE, fig.height=4.5, fig.width=6-----------------------------------
library(concurve)
set.seed(1031)
GroupA <- rnorm(500)
GroupB <- rnorm(500)
RandomData <- data.frame(GroupA, GroupB)
intervalsdf <- curve_mean(GroupA, GroupB,
  data = RandomData, method = "default"
)
(function1 <- ggcurve(data = intervalsdf[[1]], type = "c", nullvalue = TRUE))

## -----------------------------------------------------------------------------
library(ggplot2)
function1 +
  labs(
    title = "Random Title",
    subtitle = "Random Subtitle",
    x = "x-axis",
    y = "y-axis",
    caption = "Custom Caption"
  )

## -----------------------------------------------------------------------------
library(cowplot)
logo_file <- "https://res.cloudinary.com/less-likely/image/upload/v1575441662/Site/Logo2.jpg"

function1 <- function1 +
  theme_cowplot()

function2 <- ggdraw(function1) +
  draw_image(logo_file, x = 1, y = 1, hjust = 2, vjust = 1.75, width = 0.13, height = 0.2)

function2

## -----------------------------------------------------------------------------
save_plot("function2.pdf", function2)

