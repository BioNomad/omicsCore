# Importing Data

When importing data we use a few common functions:

* ```read.csv()``` - to read in .csv files or files separated by commas/```,```
* ```read.table()``` - to read files separated by delimiters other than commas - like spaces/``` ```, tabs/```/t```, semicolons/```;```, etc.
* ```openxlsx::read.xlsx()``` - to read excel files

You'll note that ```read.xlsx()``` has the prefix ```openxlsx::```. This is because the ```read. xlsx()``` function is not avaiable with base R. To get this function you will need to install a new package. To do so you'll enter this general formula into the console:

```
install.packages("packageToInstall")
```

So to install the ```openxlsx``` package all you'll need to do is write out ```install.packages("openxlsx")```. Installing packages aside, let's dive into how to use each function described above.

## read.csv()

When importing .csv files you'll need to specify the path to where you're file is located. So if your .csv file is in your documents folder 
