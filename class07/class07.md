---
title: "Class 7 R Functions and packages"
author: "Yasmine Kasiri"
date: "10/22/2019"
output: github_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## R Functions revisted

source my functions from the last day

```{r}
source("http://tinyurl.com/rescale-R")
```

```{r}
rescale(c(1, 10, 5, 6))
```

## A new function called both_na

Write a function where there are NA elements in two input vectors

First make simple input where i know the answer
```{r}
# Lets define an example x and y
x <- c( 1, 2, NA, 3, NA)
y <- c(NA, 3, NA, 3, 4)
```

Looked online and found **is.na** function
```{r}
is.na(x)
```

And the **which()** function to tell me where true values are
```{r}
which( is.na(y))
```

```{r}
is.na(x) & is.na(y)
```

#body of my funciton
Taking the sum of the TRUE FALSE vector will tell me how many TRUE elements I have. This is my working snippet
```{r}
sum( is.na(x) & is.na(y))
```

```{r}
sum(c(TRUE, TRUE, FALSE, TRUE))
```

Now turn it into a function
```{r}
both_na <- function(x, y) {
  sum( is.na(x) & is.na(y))
}
```

```{r}
both_na(x, y)
```

```{r}
x <- c(NA, NA, NA)
y1 <- c( 1, NA, NA)
y2 <- c( 1, NA, NA, NA)
```

```{r}
both_na(x, y2)
```

```{r}
x2 <- c(NA, NA)
both_na(x2,y2)
```

```{r}
x <- c(1, NA, NA)
y3 <- c( 1, NA, NA, NA, NA, NA, NA)
both_na(x,y3)
```

```{r}
length(x)
length(y3)
```

Add a check for when inputs x and y are not the same
```{r}
both_na2 <- function(x, y) {
  if(length(x) !=length(y)) {
    stop("inputs x and y should be the same length")
  }
  sum(is.na(x) & is.na(y))
}
```

```{r}
both_na2(x, y3)
```

```{r}
# student 1
m <- c(100, 100, 100, 100, 100, 100, 100, 90)
# student 2
n <- c(100, NA, 90, 90, 90, 90, 97, 80)
```

```{r}
grade <- function(x) {
  if( any(is.na(x)))
    warning("Student is missing a homeowrk")
    mean(x[-which.min(x)], na.rm = TRUE)
  }
```

```{r}
grade(n)
```

```{r}
url <- "https://tinyurl.com/gradeinput"
hw <- read.csv(url, row.names = 1)
```

```{r}
apply(hw, 1, grade)
```

```{r}
install.packages("blogdown")
```

```{r}
blogdown::new_site()
```

