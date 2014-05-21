## cachematrix.R
## caching mechanism for inverted matrices
## =======================================
## 
## the follwing two functions provide a mechanism to
## store the inverse of a given square matrix A into a cache
## and subsequently retrieve it from the cache instead
## of calculating it again:
## 
## cA <- makeCacheMatrix(A)    ## prepares the caching functions for A
## invA <- cacheSolve(cA)      ## 1st  call: calculates, caches and returns inverse of A
## invA <- cacheSolve(cA)      ## 2nd+ call: returns inverse of A from cache
##
## Restrictions:
## - 'A' has to be an INVERTIBLE SQUARE matrix
## - no input validation
## 
## Usage examples:
## 
## A <- matrix(runif(4),2)    # 2x2 random matrix
## cA <- makeCacheMatrix(A)   # prepares caching for matrix A
## invA <- cacheSolve(cA)     # calculates, caches and returns inverse of A
## invA <- cacheSolve(cA)     # returns inverse of A from cache
## 
## cB <- makeCacheMatrix()    # prepares caching for an empty matrix
## cB$set(matrix(runif(4),2)) # sets the matrix to act on
## invB <- cacheSolve(cB)     # calculates, caches and returns inverse of B
## invB <- cacheSolve(cB)     # returns inverse of B from cache
## cB$set(matrix(runif(9),3)) # sets a new matrix to act on
## invB <- cacheSolve(cB)     # calculates, caches and returns inverse of new B
## invB <- cacheSolve(cB)     # returns inverse of new B from cache
## 
        
## 
## function makeCacheMatrix(A = matrix())
## --------------------------------------
## 
## arguments:
##      A: square matrix to act on, default = empty matrix
## 
## returns a list of closures:
##      set() set a new matrix, clears the cache
##      get() get the matrix
##      setinv() stores the inverse matrix
##      getinv() get the cached inverse matrix
##               returns NULL if no inverse matrix cached
##
## closures are functions that keep track of the calling environment;
## in R use "<<-" to assign values to variables of that environment,
## which, in this case, is the data within the makeCacheMatrix function
##

makeCacheMatrix <- function(A = matrix()) {
  inv <- NULL                   # initialize
  set <- function(a) {          # setter:
    A <<- a                     # - store original matrix A
    inv <<- NULL                # - clear the cache
  }
  get <- function() A           # getter: return original matrix A
  setinv <- function(invA) inv <<- invA  # stores the inverse in cache
  getinv <- function() inv      # get the cache
  list(set = set, get = get,    # return the list of closures
       setinv = setinv,
       getinv = getinv)
}


## 
## function cacheSolve(cA, ...)
## ----------------------------
## 
## arguments:
##      cA: closures prepared by makeCacheMatrix(A)
##     ...: other arguments, passed to solve()
## 
## returns the inverse of matrix A stored in cA:
##      - from the cache, if there is a value in cA$inv
##      - otherwise: calculate the inverse of cA$A, and store it in cA$inv
##

cacheSolve <- function(cA, ...) {
  invA <- cA$getinv()           # get cached value
  if(!is.null(invA)) {          # was previously chached ?
    message("getting cached data")
    return(invA)                # return cached matrix
  }
                                # WAS NOT CACHED:
  A <- cA$get()                 # get original matrix
  invA <- solve(A, ...)         #    and inverse it
  cA$setinv(invA)               # store it into the cache
  message("stored data into cache") 
  invA                          # return inverted matrix
}

