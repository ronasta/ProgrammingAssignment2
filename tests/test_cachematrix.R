## test_cachematrix.R
##
## unit test for cachematrix.R functions makeCacheMatrix() and cacheSolve()
##

source("../cachematrix.R")

context("makeCacheMatrix")

test_that("functionality of makeCacheMatrix", {
    R <- matrix(runif(4),2,2)         # random 2x2 matrix
    cR <- makeCacheMatrix(R)
    # returned list of 4 closures: set, get, setinv, getinv ?
    expect_equal(typeof(cR),        "list")
    expect_equal(length(cR),        4)
    expect_equal(names(cR),         c("set","get","setinv","getinv"))
    expect_equal(typeof(cR$set),    "closure")   
    expect_equal(typeof(cR$get),    "closure")
    expect_equal(typeof(cR$setinv), "closure")
    expect_equal(typeof(cR$getinv), "closure")
    # stored matrix correctly, cached value is NULL ?
    expect_equal(cR$get(),          R)
    expect_equal(cR$getinv(),       NULL)
    # store correctly another matrix ?
    S <- matrix(runif(4),2,2)         # random 2x2 matrix
    cR$set(S)
    expect_equal(cR$get(),          S)
})

context("cacheSolve")

test_that("functionality of cacheSolve", {
    R <- matrix(runif(4),2,2)        # random 2x2 matrix
    cR <- makeCacheMatrix(R)
    expect_message(cacheSolve(cR),  "stored data into cache")
    expect_message(cacheSolve(cR),  "getting cached data")
    cR$set(diag(3))
    expect_message(cacheSolve(cR),  "stored data into cache")
    expect_identical(cR$getinv(),   diag(3))
    cR$set(diag(c(2,4,5),3,3))
    expect_identical(cacheSolve(cR), diag(c(0.5,0.25,0.2)))
})

test_that("tests that produce an error", {
    # can not check for specific error messages as
    # my system returns messages in Portuguese...
    R <- matrix(runif(6),3,2)       # not square random 3x2 matrix
    expect_error(cacheSolve(cR))
    R <- matrix(1,2,2)              # 2x2 matrix, all ones
    expect_error(cacheSolve(cR))
})

