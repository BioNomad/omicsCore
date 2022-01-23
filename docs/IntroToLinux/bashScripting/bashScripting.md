# Bash Scripting

## Creating a Base Script

So now that we know the basics of command line we can perform powerful operations with a script. To get started let's create a simple script to tell us where we are. First you'll create a file, say ```test.sh```.

 > NOTE: Bash scripts will end in ```.sh```
 
 ![](images/script1.PNG)

Here we see the first line is ```#!/bin/bash``` and this is essentially telling our computer this is a script to run and not some text file. Then we write the commands our script will perform. We also note that there is a sentence starting with ```#```. This is called a comment and it won't be read by your computer as a command. These are just used to make our code clearer.

## Permission to Run the Script

Now we cannot run the script outright. That is because Linux automatically restricts permissions of new scripts. To get permission we us a command called ```chmod```. We can run ```chmod 775 test.sh``` to make this script available to everyone to read, write, and execute - Or we can use ```chmod 700 test.sh``` so that only you can read, write, and execute. Here we will let everyone modify/run it:

 ![](images/script2.PNG)

## Using Variables

So we have a script! Let's make it more complicated with variables. Variables allow us to avoid repetition and can be easily switched out when needed.

![](images/script3.PNG)

Here we define a variable ```sayinghi``` and use it before ```pwd``` so that when we run the script:

![](images/script4.PNG)

Cool right? The onlything to note is you CANNOT use spaces and you reference that variable with a ```$```.

## Specify Variables Outside of the Script

Now what if you wanted to specify the variable out of the script? You can use a place holder like so:

![](images/script5.PNG)

![](images/script6.PNG)

So instead of specifying our phrase in the script we used ```$1``` as a placeholder, then specified it when we went to go run our script. ```$1``` stands for the first argument, and this would work for as many variables as you want!

> NOTE: Command line arguments are numbered ```$1, $2, $3, etc.```

## Using Loops

What if you wanted to iterate through something so you wouldn't have to write the command over and over again? You can do that using loops!

![](images/script7.PNG)

![](images/script8.PNG)

Here we loop through a list and print each item individually with the header ```This is the Letter```.

## Special Characters

Unix also has special characters for us to use:

```|``` allows you to combine commands, like only printing the first three lines from the output of ```cat```:

![](imames/pipe.PNG)

```>``` allows you to overwrite the contents of a file, so here we can add the contents of ```file2``` to ```file3```:

![](images/carrot.PNG)

```>>``` allows you to append the contents of a file, so let's add the last 3 lines of ```file2``` to ```file3```:

![](append.PNG)

## Using a While Loop

Let's talk about another useful special character - ```<```. This allows you to move some argument back into a command. Take for intance this while loop:

![](images/while.PNG)

![](images/while2.PNG)

So here we read a file and echo each line. However, how do we know which file we are reading? We do that with ```<``` and specify that we are reading whatever file we put as the first agrument


## References

1. [Shebang (Unix)](https://en.wikipedia.org/wiki/Shebang_(Unix))


[Back To Introduction to Linux](../IntroToLinux.md)

[Back To The Main Page](../../index.md)
