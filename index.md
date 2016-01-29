---
title: Exploratory analysis and variable importance for multivariate data
subtitle: Adapted from OpenCPU MarkdownApp
author: Hugo Andres Dorado
framework: revealjs
widgets: [mathjax]
---
 
## A app to explore data sets with quantitatives targets
 
The application give to the user a tool to identify the relevance of inputs features using the random forest model. Also is possible to explore the variables relations using scatter plots and box plot.
 


---
 
## Select the toyset
 
To start, is necessary choose the database.  There are three possibilities by default: 
 
 
 * corn.db.csv
 * longley.csv
 * mtcasr.csv
 
 
Immediately a database has been selected,  will appear a table with the data below. The function behind is `read.csv`. You can add your own data, only you should save your database in csv format inside to the folder app.

 

---
 
## Bivariate analysis
 
A scatter plot appear when there are two quantitative variable:
 
![plot of chunk block2](assets/fig/block2-1.png)

---
 
## Bivariate analysis
 
A box plot appear when there are one quantitative variable and a qualitative variable:
 
![plot of chunk block3](assets/fig/block3-1.png)

---
 
## Variable Importance Plot
 
You can evaluate the top of relevance variables that explain the output.

![plot of chunk block4](assets/fig/block4-1.png)
