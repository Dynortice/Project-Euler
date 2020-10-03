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

is.bigint <- function(n) {
    return(class(n)[1] == "BigInt")
}

BigInt <- R6Class(classname = "BigInt",
                  public = list(
                      str = "0",
                      positive = TRUE,
                      initialize = function(n) {
                          if (n == "") {
                              self$str <- "0"
                              self$positive <- TRUE
                          } else {
                              if (grepl("-", n)) {
                                  self$str <- substr(n, 2, nchar(n))
                                  self$positive <- FALSE
                              } else {
                                  self$str <- n
                                  self$positive <- TRUE
                              }
                          }
                      },
                      print = function (...) {
                          cat(self$str, "\n")
                          invisible(self)
                      },
                      copy = function() {
                          return(BigInt$new(paste0(ifelse(self$positive, "", "-"), self$str)))
                      },
                      len = function() {
                          return(nchar(self$str))
                      },
                      getitem = function(n, m) {
                          if (missing(m)) {
                              return(substr(self$str, n, n))
                          } else {
                              return(substr(self$str, n, m))
                          }
                      },
                      neg = function() {
                          if (self$positive) {
                              return(BigInt$new(paste0("-", self$str)))
                          } else {
                              return(BigInt$new(self$str))
                          }
                      },
                      isub = function(other) {
                          result <- self$sub(other)
                          self$str <- result$str
                          self$positive <- result$positive
                      },
                      iadd = function(other) {
                          result <- self$add(other)
                          self$str <- result$str
                          self$positive <- result$positive
                      },
                      imul = function(other) {
                          result <- self$mul(other)
                          self$str <- result$str
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
                                      for (i in seq_len(nchar(self$str))) {
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
                          if (is.bigint(other)) {
                              if (self$positive == other$positive) {
                                  xy <- zero_pad(self$str, other$str, FALSE)
                                  x <- xy[1]
                                  y <- xy[2]
                                  result <- ""
                                  carry <- 0
                                  len <- nchar(x)
                                  for (i in seq_len(ceiling(len / 4))) {
                                      carry <- carry + as.integer(substr(x, len - 4 * i + 1, len - 4 * (i - 1))) + as.integer(substr(y, len - 4 * i + 1, len - 4 * (i - 1)))
                                      result <- paste0(strrep("0", max(4 - nchar(carry), 0)), substr(carry, nchar(carry) - 3, nchar(carry)), result)
                                      carry <- carry %/% 10 ^ 4
                                  }
                                  if (carry == 0) {
                                      result <- trimws(result, "left", "0")
                                  } else {
                                      result <- paste0(carry, result)
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
                          } else if (is.numeric(other)) {
                              return(self$add(BigInt$new(as.character(other))))
                          }
                      },
                      sub = function(other) {
                          if (is.bigint(other)) {
                              if (self$positive == other$positive) {
                                  if (self$str == other$str) {
                                      return(BigInt$new("0"))
                                  }
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
                                  xy <- zero_pad(x, y, FALSE)
                                  x <- xy[1]
                                  y <- xy[2]
                                  result <- ""
                                  carry <- 0
                                  len <- nchar(x)
                                  for (i in seq_len(ceiling(len / 4))) {
                                      carry <- carry + as.integer(substr(x, len - 4 * i + 1, len - 4 * (i - 1))) - as.integer(substr(y, len - 4 * i + 1, len - 4 * (i - 1)))
                                      if (carry < 0) {
                                          result <- paste0(strrep("0", max(4 - nchar(carry + 10 ^ 4), 0)), carry + 10 ^ 4, result)
                                          carry <- -1
                                      } else {
                                          result <- paste0(strrep("0", max(4 - nchar(carry), 0)), carry, result)
                                          carry <- 0
                                      }
                                  }
                                  result <- trimws(result, "left", "0")
                                  if (positive) {
                                      return(BigInt$new(result))
                                  } else {
                                      return(BigInt$new(paste0("-", result)))
                                  }
                              } else {
                                  if (self$positive) {
                                      return(self$add(other$neg()))
                                  } else {
                                      return(self$neg()$add(other)$neg())
                                  }
                              }
                          } else if (is.numeric(other)) {
                              return(self$sub(BigInt$new(as.character(other))))
                          }
                      },
                      mul = function(other) {
                          if (is.bigint(other)) {
                              mul <- function(e, f) {
                                  if (max(e$len(), f$len()) < 5) {
                                      if (e$positive == f$positive) {
                                          return(BigInt$new(as.character(as.integer(e$str) * as.integer(f$str))))
                                      } else {
                                          return(BigInt$new(paste0("-", as.integer(e$str) * as.integer(f$str))))
                                      }
                                  }
                                  g <- intToUtf8(rev(utf8ToInt(e$str)))
                                  h <- intToUtf8(rev(utf8ToInt(f$str)))
                                  result <- BigInt$new("0")
                                  for (i in seq_len(nchar(g))) {
                                      carry <- 0
                                      sub_result <- strrep("0", i - 1)
                                      for (j in seq_len(nchar(h))) {
                                          carry <- carry + as.numeric(substr(g, i, i)) * as.numeric(substr(h, j, j))
                                          sub_result <- paste0(carry %% 10, sub_result)
                                          carry <- carry %/% 10
                                      }
                                      result$iadd(BigInt$new(trimws(paste0(carry, sub_result), "left", "0")))
                                  }
                                  result$positive <- e$positive == f$positive
                                  return(result)
                              }
                              x_len <- self$len()
                              y_len <- other$len()
                              if ((max(x_len, y_len) < 5) | (min(x_len, y_len) == 1)) {
                                  return(mul(self, other))
                              }
                              n <- max(x_len, y_len)
                              m <- n %/% 2
                              a_ <- BigInt$new(self$getitem(1, x_len - m))
                              b_ <- BigInt$new(self$getitem(x_len - m + 1, x_len))
                              c_ <- BigInt$new(other$getitem(1, y_len - m))
                              d_ <- BigInt$new(other$getitem(y_len - m + 1, y_len))
                              ac <- a_$mul(c_)
                              bd <- b_$mul(d_)
                              ab_cd <- a_$add(b_)$mul(c_$add(d_))
                              r <- BigInt$new(pad(ac$str, 2 * m))
                              s <- BigInt$new(pad(ab_cd$sub(ac)$sub(bd)$str, m))
                              res <- r$add(s)$add(bd)
                              res$positive <- self$positive == other$positive
                              return(res)
                          } else if (is.numeric(other)) {
                              return(self$mul(BigInt$new(as.character(other))))
                          }
                      },
                      pow = function(other, powermod_10) {
                          value <- self$copy()
                          result <- BigInt$new("1")
                          if (missing(powermod_10)) {
                              while (other > 0) {
                                  if (other %% 2 == 1) {
                                      result$imul(value)
                                  }
                                  value$imul(value)
                                  other <- other %/% 2
                              }
                          } else {
                              while (other > 0) {
                                  if (other %% 2 == 1) {
                                      result$imul(value)
                                      result <- BigInt$new(substr(result$str, max(nchar(result$str) - powermod_10 + 1, 1), nchar(result$str)))
                                  }
                                  value$imul(value)
                                  value <- BigInt$new(substr(value$str, max(nchar(value$str) - powermod_10 + 1, 1), nchar(value$str)))
                                  other <- other %/% 2
                              }
                          }
                          return(result)
                      }
                  )
)
