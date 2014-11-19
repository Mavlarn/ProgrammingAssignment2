
## Cache Matrix object, include cached matrix inversion.

makeCacheMatrix <- function(x = matrix()) {
  ## store cached inversion in 'inv'
  inv <- NULL
  
  ## reset values
  set <- function(y) {
    x <<- y
    inv <<- NULL
  }
  get <- function() x
  setInv <- function(newInv) inv <<- newInv
  getInv <- function() inv
  list(set = set, get = get, setInv = setInv, getInv = getInv)
}


## resolve function for cached matrix.

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  inv <- x$getInv()
  if (!is.null(inv)) {
    message("getting cached data")
    return(inv)
  }
  data <- x$get()
  inv <- solve(data)
  x$setInv(inv)
  inv
}
