#!/bin/bash

# Trim our read data #

# create a directory for our trimmed data
mkdir trim

#run trim galore at default settings
trim_galore --paired -o trim raw_data/*
