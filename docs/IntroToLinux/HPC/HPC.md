# HPC

## Introduction to Workload Management
Now that we have covered Linux commands and how to put them in a script we can talk about how to manage running scripts. Some jobs could take a few minutes and some could take a few days depending on resources. It is at this point that we usually leverage High Performance Computing (HPC) clusters. Typically, you'll get to a cluster either through the HPC website, where they will have a way for you to open a linux environment online or through an ssh command that looks like this:

```ssh yourHpcCluster```

## Login Node

Now that you have made it to the HPC cluster, you will be at a login node. And you can think of a login node like a waiting room. **DO NOT** run any scripts here. For that you will need to leave the login node and get to a compute node. You can either get an interactive session on a compute node or run a batch script from the login node to run scripts. We will talk about interactive sessions first.

## Interactive Session

Now there are a few workload managers out there, in this tutorial we will demonstrate Slurm - a popular choice for HPC users. SLURM comes with commands we can use to manage our workload. The Slurm command to get to an interactive session is ```srun```, here is an example:

```srun -p batch -t 1-2:30:00 -n 1 --mem=2Gb --pty bash```

Let's break it down:

```srun``` our command to start an interactive session

```-p batch``` is telling us to use a compute node in the batch partition

```-t 1-2:30:00``` is the time we will use that node so here we are using it for 1 day, 2 hours, 30 minutes and 0 seconds

```-n 1``` is saying we will only need 1 compute node

```--mem=2Gb``` is saying we will only need 2GB of memory

```--pty bash``` is saying we would like a bash environment

To go back to the login node, just use ```exit```

## Checking Avaialble Nodes

## Writing a Batch Script

## Checking on Your Job

## Checking on Finished Jobs

## Details of Your Jobs

## Cancel Your Job


[Back To Introduction to Linux](../IntroToLinux.md)

[Back To The Main Page](../../index.md)
