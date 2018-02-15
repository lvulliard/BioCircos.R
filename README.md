# BioCircos.R
Simple htmlwidgets binding R commands to the BioCircos.js library

---

## Introduction

This package allows to implement in 'R' Circos-like visualizations of genomic data, as proposed by the BioCircos.js JavaScript library, based on the JQuery and D3 technologies.  
For a complete list of all the parameters available, please refer to the package documentation.


## Motivation

The amount of data produced nowadays in a lot of different fields assesses the relevance of reactive analyses and interactive display of the results. This especially true in biology, where the cost of sequencing data has dropped must faster than the Moore's law prediction. New ways of integrating different level of information and accelerating the interpretation are therefore needed.

The integration challenge appears to be of major importance, as it allows a deeper understanding of the biological phenomena happening, that cannot be observed in the single analyses independently.  

This package aims at offering an easy way of producing Circos-like visualizations to face distinct challenges :

* On the one hand, data integration and visualization: Circos is a popular tool to combine different biological information on a single plot.
* On the other hand, reactivity and interactivity: thanks to the *htmlwidgets* framework, the figures produced by this package are responsive to mouse events and display useful tooltips, and they can be integrated in shiny apps. Once the analyses have been performed and the shiny app coded, it is possible for the end-user to explore a massive amount of biological data without any programming or bioinformatics knowledge.

The terminology used here arises from genomics but this tool may be of interest for different situations where different positional or temporal informations must be combined.


## Installation

To install this package, you can use CRAN (the central R package repository) to get the last stable release or build the last development version directly from the GitHub repository.

### From CRAN

	install.packages('BioCircos')

### From Github

	# You need devtools for that
	if (!require('devtools')){install.packages('devtools')}
	devtools::install_github('lvulliard/BioCircos.R', build_vignettes = TRUE))


## Compatibility and troubleshooting

Since the visualizations are powered by JavaScript, they are affected by the environment in which they are displayed.  
If nothing shows up in a shiny application or an Rmarkdown document, try to update your web browser. 
See the vignettes for examples of BioCircos plots that should be correctly displayed.

### Obseved behavior

* Firefox 55, Chrome 54 and later versions work as expected.
* Firefox 46, Chrome 53 and past versions do not display the plots at all.
* Firefox 47 to 54 do not include all features, such as zooming.

## Tutorial

See the vignettes to learn how to use BioCircos visualizations.

	vignette('BioCircos')


## Original work

BioCircos.js : an Interactive Circos JavaScript Library for Biological Data Visualization on Web Applications. 

https://github.com/YaCui/Biocircos.js

http://bioinfo.ibp.ac.cn/biocircos/

http://www.ncbi.nlm.nih.gov/pubmed/26819473

Documentation: http://bioinfo.ibp.ac.cn/biocircos/document/index.html

### Modifications

The following features have been added to the original BioCircos.js library, based on version 1.1.2:

* Parameter *snp_value_maxmin_instance* set by *SNPsettings.range* when provided, to allow the use of a pre-defined range of values for the SNP track.
* Similar parameters added for the range of Histogram/Bar tracks, Line tracks, CNV tracks and Heatmap tracks (for the range to be used for color mapping).
* Parameter *opacity* added to each elements of SNP and Arc tracks.


## Contact

To report bugs, request features or for any question or remark regarding this package, please use the <a href="https://github.com/lvulliard/BioCircos.R">GitHub page</a> or contact <a href="mailto:lvulliard@cemm.at">Loan Vulliard</a>.


## Credits

The creation and implementation of the **BioCircos.js** JavaScript library is an independent work attributed to <a href="mailto:cui_ya@163.com">Ya Cui</a> and <a href="mailto:chenxiaowei@moon.ibp.ac.cn">Xiaowei Chen</a>.  
This work is described in the following scientific article: BioCircos.js: an Interactive Circos JavaScript Library for Biological Data Visualization on Web Applications. Cui, Y., et al. Bioinformatics. (2016).

This package relies on several open source projects other R packages, and is made possible thanks to **shiny** and **htmlwidgets**. 

The package **heatmaply** was used as a model for this vignette, as well as for the **htmlwidgets** configuration.

[![](https://cranlogs.r-pkg.org/badges/BioCircos)](https://cran.r-project.org/package=BioCircos)