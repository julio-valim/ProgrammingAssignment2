## The functions below caching the inverse of a matrix rather than compute it
## often for sake of avoid repeated computation

## This function creates a special "matrix" object that can cache its inverse.

makeCacheMatrix <- function(x = matrix()) {
        
        start.time <- Sys.time()
        
        j <- NULL
        set <- function(y){
                x <<- y
                j <<- NULL
        }
        get <- function() x
        setInverse <- function(inverse) j <<- inverse
        getInverse <- function() j 
        
        finalList <- list(set = set, get = get, 
                          setInverse = setInverse, 
                          getInverse = getInverse)
        
        print(paste('Time spent to generate a special matrix object: ', Sys.time()-start.time))
        
        finalList
}



## This function computes the inverse of the special "matrix" returned by makeCacheMatrix above

cacheSolve <- function(matrixCache, ...) {
        
        start.time <- Sys.time()
        
        j <- matrixCache$getInverse()
        if(!is.null(j)) j
        aux <- matrixCache$get()
        j <- solve(aux,...)
        matrixCache$setInverse(j)
        
        print(paste('Time to compute my inversed matrix: ', Sys.time() - start.time))
        print('*--- My inversed matrix: ---*')
        j
}



## Execution Test

# Generate a random integer matrix
myMatrix <- matrix(sample.int(9, 25, TRUE), 5, 5)
myMatrix

# Generate cache for the special matrix
myMatrixCache <- makeCacheMatrix(myMatrix)

# Compute inversed matrix chached
cacheSolve(myMatrixCache)