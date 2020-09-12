library(R6)

pad <- function (a, n, right = TRUE) {
    if (right) {
        return(paste0(a, strrep("0", n)))
    } else {
        return(paste0(strrep("0", n), a))
    }
}

zero_pad <- function (a, b, right = TRUE) {
    if (nchar(a) > nchar(b)) {
        b <- pad(b, nchar(a) - nchar(b), right)
    } else if (nchar(b) > nchar(a)) {
        a <- pad(a, nchar(b) - nchar(a), right)
    }
    return(c(a, b))
}

BigInt <- R6Class(classname = "BigInt",
                  public = list(
                      str = "0",
                      digits = 0L,
                      positive = TRUE,
                      initialize = function(n) {
                          if (n == "") {
                              self$str <- "0"
                              self$digits <- 0L
                              self$positive <- TRUE
                          } else {
                              digits <- strsplit(n, NULL)[[1]]
                              if ("-" == digits[1]) {
                                  self$str <- substr(n, 2, nchar(n))
                                  self$digits <- as.integer(digits[-1])
                                  self$positive <- FALSE
                              } else {
                                  self$str <- n
                                  self$digits <- as.integer(digits)
                                  self$positive <- TRUE
                              }
                          }
                      },
                      len = function() {
                          return(length(self$digits))
                      },
                      getitem = function(n) {
                          return(self$digits[n])
                      },
                      neg = function() {
                          if (self$positive) {
                              return(BigInt$new(paste0("-", self$str)))
                          } else {
                              return(BigInt$new(paste(self$digits, collapse = "")))
                          }
                      },
                      isub = function(other) {
                          result <- self$sub(other)
                          self$str <- result$str
                          self$digits <- result$digits
                          self$positive <- result$positive
                      },
                      iadd = function(other) {
                          result <- self$add(other)
                          self$str <- result$str
                          self$digits <- result$digits
                          self$positive <- result$positive
                      },
                      imul = function(other) {
                          result <- self$mul(other)
                          self$str <- result$str
                          self$digits <- result$digits
                          self$positive <- result$positive
                      },
                      eq = function(other) {
                          return(self$str == other$str)
                      },
                      ne = function(other) {
                          return(self$str != other$str)
                      },
                      le = function(other) {
                          return(self$eq(other) | self$lt(other))
                      },
                      ge = function(other) {
                          return(self$eq(other) | self$gt(other))
                      },
                      gt = function(other) {
                          return(!self$le(other))
                      },
                      lt = function(other) {
                          if (self$positive == other$positive) {
                              if (self$len() == other$len()) {
                                  if (self$str == other$str) {
                                      return(FALSE)
                                  } else {
                                      for (i in seq_along(self$digits)) {
                                          if (self$getitem(i) == other$getitem(i)) {
                                              next
                                          } else {
                                              return((self$getitem(i) < other$getitem(i)) & self$positive)
                                          }
                                      }
                                  }
                              } else {
                                  return(!xor(self$len() < other$len(), self$positive))
                              }
                          } else {
                              return(!self$positive)
                          }
                      },
                      add = function(other) {
                          if (self$positive == other$positive) {
                              xy <- zero_pad(self$str, other$str, FALSE)
                              x <- xy[1]
                              y <- xy[2]
                              result <- ""
                              carry <- 0
                              len <- nchar(x)
                              for (i in 1:ceiling(len / 14)) {
                                  carry <- carry + as.numeric(substr(x, 1 + len - 14 * i, len - 14 * (i - 1))) + as.numeric(substr(y, 1 + len - 14 * i, len - 14 * (i - 1)))
                                  result <- paste0(strrep("0", 14 - min(nchar(carry), 14)), substr(carry, nchar(carry) - 13, nchar(carry)), result)
                                  carry <- carry %/% 10 ^ 14
                              }
                              if (carry != 0) {
                                  result <- c(carry, result)
                              } else {
                                  result <- trimws(result, "left", "0")
                              }
                              if (self$positive) {
                                  return(BigInt$new(result))
                              } else {
                                  return(BigInt$new(paste0("-", result)))
                              }
                          } else {
                              if (self$positive) {
                                  return(self$sub(other$neg()))
                              } else {
                                  return(other$sub(self$neg()))
                              }
                          }
                      },
                      sub = function(other) {
                          if (self$positive != other$positive) {
                              if (self$positive) {
                                  return(self$add(other$neg()))
                              } else {
                                  return(self$neg()$add(other)$neg())
                              }
                          } else {
                              if (self$eq(other)){
                                  return(BigInt("0"))
                              } else {
                                  if (self$positive) {
                                      if (self$gt(other)) {
                                          positive <- TRUE
                                          x <- self$str
                                          y <- other$str
                                      } else {
                                          positive <- FALSE
                                          x <- other$str
                                          y <- self$str
                                      }
                                  } else {
                                      if (self$gt(other)) {
                                          positive <- TRUE
                                          x <- other$str
                                          y <- self$str
                                      } else {
                                          positive <- FALSE
                                          x <- self$str
                                          y <- other$str
                                      }
                                  }
                                  xy <- zero_pad(rev(x), rev(y), FALSE)
                                  x <- xy[1]
                                  y <- xy[2]
                                  result <- ""
                                  carry <- 0
                                  len <- nchar(x)
                                  for (i in 1:ceiling(len / 14)) {
                                      carry <- carry + as.numeric(substr(x, 1 + len - 14 * i, len - 14 * (i - 1))) - as.numeric(substr(y, 1 + len - 14 * i, len - 14 * (i - 1)))
                                      if (carry < 0) {
                                          result <- paste0(strrep("0", 14 - nchar(10 ^ 14 + carry)), 10 ^ 14 + carry, result)
                                          carry <- -1
                                      } else {
                                          result <- paste0(strrep("0", 14 - nchar(carry)), carry, result)
                                          carry <- 0
                                      }
                                  }
                                  result <- trimws(result, "left", "0")
                                  if (positive) {
                                      return(BigInt$new(result))
                                  } else {
                                      return(BigInt$new(result)$neg())
                                  }
                              }
                          }
                      },
                      mul = function(other) {
                          mul <- function(e, f) {
                              if (max(e$len(), f$len()) < 10) {
                                  return(BigInt$new(as.character(prod(as.integer(c(e$str, f$str))))))
                              }
                              g <- rev(e$gigits)
                              h <- rev(f$digits)
                              result <- BigInt("0")
                              for (i in seq_along(g)) {
                                  carry <- 0
                                  sub_result <- strrep("0", i - 1)
                                  for (j in seq_along(h)) {
                                      carry <- carry + g[i] * h[j]
                                      sub_result <- paste0(carry %% 10, sub_result)
                                      carry <- carry %/% 10
                                  }
                                  result <- result$add(BigInt(trimws(paste0(carry, sub_result), "left", "0")))
                              }
                              return(result)
                          }
                          x_len <- self$len()
                          y_len <- other$len()
                          if (max(x_len, y_len) < 10 | min(x_len, y_len) == 1) {
                              return(mul(self, other))
                          }
                          x <- self$str
                          y <- other$str
                          n <- max(x_len, y_len)
                          m <- n %/% 2
                          a_ <- BigInt$new(substr(x, 1, max(x_len - m, 0)))
                          b_ <- BigInt$new(substr(x, x_len - m + 1, x_len))
                          c_ <- BigInt$new(substr(y, 1, max(y_len - m, 0)))
                          d_ <- BigInt$new(substr(y, y_len - m + 1, y_len))
                          ac <- a_$mul(c_)
                          bd <- b_$mul(d_)
                          ab_cd <- a_$add(b_)$mul(c_$add(d_))
                          r <- BigInt$new(pad(ac$str, 2 * m))
                          s <- BigInt$new(pad(ab_cd$sub(ac)$sub(bd)$str, m))
                          return(r$add(s)$add(bd))
                      }
                  )
)
