# Getting and Cleaning Data Course Project

This repository contains a solution to the peer-graded programming assignment of the Coursera course *Getting and Cleaning Data*.

The repo includes the following files:
- `README.md`: this file, describing the repository,
- `CodeBook.md`: describing the data, variables, applied transformations, and the generated results,
- `run_analysis.R`: the R script, that downloads and processes data from the UCI data repository,
  generating `out/har-tidy.txt` and `out/har-summary.txt`
- `transform_column_names.R`: a helper functions used to improve the raw column names (used by `run_analysis.R`)
