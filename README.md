(the original README.md was renamed to README_ORIG.md)

## DatSci-02 R Programming: Assignment 2

I added unit testing using `testthat` (see below)

### files

|file                       |description
|:--------------------------|:------------------------------------------
|*cachematrix.R*            |*the functions to be graded*        
|cachemean.R                |the example from the assignment
|tests/test_cachematrix.R   |unit tests for cachematrix.R
|README_ORIG.md             |assignment
|README.md                  |(this file)

### unit tests (using *testthat*)

to run the tests:
`test_dir("tests")`

this should produce the following output (as all tests pass):

```R
> test_dir("tests")
makeCacheMatrix : ..........
cacheSolve : .......
```
I encountered the following problem which I haven't resolved yet:

my R / Rstudio is installed in Portuguese, and so procuce Portuguese error messages. 
If I checked for these messages in `expect_error(...)`, the tests would not generally run...

**references:**
* [Example of unit testing R code with testthat](http://www.johndcook.com/blog/2013/06/12/example-of-unit-testing-r-code-with-testthat/ "by John D. Cook in his blog")
* [testthat: Get Started with Testing (pdf)](http://journal.r-project.org/archive/2011-1/RJournal_2011-1_Wickham.pdf "in R-Journal by Hadley Wickham, author of testthat")
* `help(package=testthat)`


