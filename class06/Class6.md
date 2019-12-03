---
title: "Class6 R Functions"
author: "Yasmine Kasiri"
date: "10/17/2019"
output: github_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# This is H1
This is my work from class 6 in **BIMM143**

```{r}
# this is to demo a code chunk
plot(1:10)
```


## Practice reading files again

Here I practice reading 3 different files...

```{r}
read.table("test1.txt", sep =",", header=TRUE)
```

```{r}
read.table("test2.txt", sep = "$", header = TRUE)
```

```{r}
read.table("test3.txt")
```

```{r}
add <- function(x, y=1) {
# Sum the input x and y
x + y
}
```

```{r}
add(1)
add(5,5)
add( c(1,2,3,4))
```

A new function to rescale data
```{r}
rescale <- function(x) {
 rng <-range(x)
 (x - rng[1]) / (rng[2] - rng[1])
}
```

```{r}
rescale(1:10)
```

```{r}
rescale( c(1,2,NA,3,10) )
```

```{r}
x <- c(1,2,NA,3,10)
rng <- range(x, na.rm=TRUE)
rng
```

```{r}
rescale2 <- function(x) {
 rng <-range(x, na.rm=TRUE)
 (x - rng[1]) / (rng[2] - rng[1])
}
```

```{r}
rescale2( c(1,2,NA,3,10))
```

```{r}
rescale3 <- function(x, na.rm=TRUE, plot=FALSE) {
 rng <-range(x, na.rm=na.rm)
 print("Hello")
 answer <- (x - rng[1]) / (rng[2] - rng[1])
 return(answer)
 print("is it me you are looking for?")
 if(plot) {
 plot(answer, typ="b", lwd=4)
 }
 print("I can see it in ...")
 return(answer)
}
```

```{r}
rescale3(1:10, plot = TRUE)
```

# Section 2 Hands On Sheet

Install the **bio3d** package for sequence and structure analysis

#install.packages(“bio3d”)

```{r}
library(bio3d)
s1 <- read.pdb("4AKE") # kinase with drug
s2 <- read.pdb("1AKE") # kinase no drug
s3 <- read.pdb("1E4Y") # kinase with drug

s1.chainA <- trim.pdb(s1, chain="A", elety="CA")
s2.chainA <- trim.pdb(s2, chain="A", elety="CA")
s3.chainA <- trim.pdb(s1, chain="A", elety="CA")

s1.b <- s1.chainA$atom$b
s2.b <- s2.chainA$atom$b
s3.b <- s3.chainA$atom$b

plotb3(s1.b, sse=s1.chainA, typ="l", ylab="Bfactor")
plotb3(s2.b, sse=s2.chainA, typ="l", ylab="Bfactor")
plotb3(s3.b, sse=s3.chainA, typ="l", ylab="Bfactor")
```


```{r}
library(bio3d)
x <- "4AKE"
s1 <- read.pdb(x) # kinase with drug

s1.chainA <- trim.pdb(s1, chain="A", elety="CA")


s1.b <- s1.chainA$atom$b

plotb3(s1.b, sse=s1.chainA, typ="l", ylab="Bfactor")

```

# THE OFFICIAL ANSWER TO Q6 HOMEWORK ASSIGNMENT BELOW

```{r}
library(bio3d) # this pulls up the package with all the protein information
hello <- function(x) { #this is the function, which sums up all the fine-tune details of the upcoming plots. It is named hello
s1 <- read.pdb(x) # this assigns "s1" to read a prtein data bank file for whatever protein x is entered in function(x)
s1.chainA <- trim.pdb(s1, chain="A", elety="CA") # this trims the large PDB file outcome from before into a smaller file, where we argue for certain chains and other components
s1.b <- s1.chainA$atom$b #this looks for a subset of atoms in the specified chain
plotb3(s1.b, sse=s1.chainA, typ="l", ylab="Bfactor") #this plots all the arguments from the body so far in the form of a line plot with the y axis labeled B factor
}
hello("4AKE") #the function to give the output for 4AKE a protein in the databank, and so on for the other two protein examples
hello("1AKE")
hello("1E4Y")
```

