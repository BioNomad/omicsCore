# Importing Data

When importing data we use a few common functions:

* ```read.csv()``` - to read in .csv files or files separated by commas/```,```
* ```read.table()``` - to read files separated by delimiters other than commas - like spaces/```" "```, tabs/```"/t"```, semicolons/```";"```, etc.
* ```openxlsx::read.xlsx()``` - to read excel files

You'll note that ```read.xlsx()``` has the prefix ```openxlsx::```. This is because the ```read. xlsx()``` function is not avaiable with base R. To get this function you will need to install a new package. To do so you'll enter this general formula into the console:

```
install.packages("packageToInstall")
```

So to install the ```openxlsx``` package all you'll need to do is write out ```install.packages("openxlsx")```. Installing packages aside, let's dive into how to use each function described above.

## read.csv()

When importing .csv files you'll need to specify the path to where you're file is located. So if your .csv file is in ```/Documents/test.csv```, you can download it like so:

```read.csv("/Documents/test.csv")```

We can also extend this to URL's as well:

```read.csv(url("http://plugins.biogps.org/download/human_sample_annot.csv"))```

## read.table()

Like ```read.csv()```, ```read.table()``` can also import data. The latter function is very useful in that it can download files not delimted (a.k.a separated) by commas. So to open a ".tsv" file (a.k.a a file delimeted by a tab/```"/t"```):

```read.table("/Documents/test.tsv",sep="\t",stringsAsFactors=FALSE)```

You'll notice in the code above that we include the option, ```stringsAsFactors=FALSE```. If this was set to ```TRUE``` it would coerce your character columns into factor columns and this isn't always desired. So here we explicitly say ```stringsAsFactors=FALSE``` to be safe.

## read.xlsx()

While files like the ones mentioned above are popular, so are excel spreadsheets. So it is worth mentioning how to read in excel data as well. However, to do wo we will need pull in the package ```openxlsx```, which we did above by entering ```install.packages("openxlsx")```. To use this package we can do one of the following:

  * call it for every function we use: ```openxlsx::read.xlsx("/Documents/test.xlsx")```
  * load the entire library of functions:
   
       ```library(openxlsx)```
      
      ```read.xlsx("/Documents/test.xlsx")```
      
Often times we just load in the whole library, if we were writing our own package we would try and call it for every function we use for traceability reasons. Now in excel spreadsheets you may only want to pull out one page or start from a row that isn't the first. To do so you can use:

```library(openxlsx)```

```read.xlsx("/Documents/test.xlsx",sheet=2,startRow = 5,colNames = TRUE,rowNames = FALSE)```

So here we are pulling: the document "/Documents/test.xlsx", the second sheet, starting from the fifth row, specifying we do have column names, specifying we do not have row names. 

_________________________________________________________________________________________________________________________________________________________________________________

[Next Workshop: Manipulating Data](../ManipulatingData/ManipulatingData.md)

[Back To Introduction to R](../IntroToR.md)

[Back To The Main Page](../../index.md)





