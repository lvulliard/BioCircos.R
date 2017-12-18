---
title: "Generating circular multi-track plots"
output: rmarkdown::html_vignette:
  toc: true
  toc_depth: 2
vignette: >
  %\VignetteIndexEntry{Generating circular multi-track plots}
  %\VignetteEngine{knitr::rmarkdown}
  \usepackage[utf8]{inputenc}
---

# BioCircos: Generating circular multi-track plots

## Introduction

This package allows to implement in 'R' Circos-like vizualizations of genomic data, as proposed by the BioCircos.js JavaScript library, based on the JQuery and D3 technologies.  
We will demonstrate here how to generate easily such plots and what are the main parameters to customize them. Each example can be run independently of the others.  
For a complete list of all the parameters available, please refer to the package documentation.


## Motivation

## Installation

To install this package, you can use CRAN (the central R package repository) to get the last stable release or build the last development version directly from the GitHub repository.

### From CRAN


```r
install.packages('BioCircos')
```

### From Github


```r
# You need devtools for that
if (!require('devtools')){install.packages('devtools')}

devtools::install_github('lvulliard/BioCircos.R', build_vignettes = TRUE))
```


## Generating Circos-like visualizations

### Principle

To produce a BioCircos visualization, you need to call the *BioCircos* method, that accepts a *tracklist* containing the different *tracks* to be displayed, the genome to be displayed and plotting parameters.  
By default, an empty *tracklist* is used, and the genome is automatically set to use the chromosome sizes of the reference genome hg19 (GRCh37).




