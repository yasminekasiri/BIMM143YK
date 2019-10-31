#' ---
#' title: "Class 05 Data Exploration"
#' author: "Yasmine Kasiri"
#' output: github_document
#' ---



# Class5 Data Visualization
x <- rnorm(1000)
summary(x)

boxplot(x)

hist(x)


# section 2 scatter plots

# lets read our input file first


baby <- read.table("bimm143_05_rstats/weight_chart.txt",
                   header = TRUE)
baby

# section 2B Barplots

mouse <- read.csv("bimm143_05_rstats/feature_counts.txt",
                  sep = "\t", header = TRUE)
mouse

# section 2C Histograms

hi <- c(rnorm(1000), rnorm(1000)+4)
hi

#section 3A
hello <- read.csv("bimm143_05_rstats/male_female_counts.txt",
                  sep = "\t", header = TRUE)