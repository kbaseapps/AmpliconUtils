#!/usr/bin/env Rscript

if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager", repos = "http://cran.rstudio.com/")
BiocManager::install("dada2")
