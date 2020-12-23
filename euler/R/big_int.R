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
    return(inherits(n, 'BigInt'))
}

as.bigint <- function(n) {
    if (is.character(n)) {
        if (n == "") {
            return(BigInt$new("0"))
        } else if (substr(n, 1, 1) == "-") {
            return(BigInt$new(substr(n, 2, nchar(n)), FALSE))
        } else {
            return(BigInt$new(n))
        }
    } else if (is.numeric(n)) {
        return(BigInt$new(as.character(abs(n)), n >= 0))
    } else if (is.bigint(n)) {
        return(BigInt$new(n$str, n$positive))
    } else {
        stop(paste("Unsupported operand type for as.bigint:", class(n)))
    }
}

sum.bigint <- function(n) {
    result <- as.bigint(0)
    for (i in n) {
        result %+=% i
    }
    return(result)
}

prod.bigint <- function(n) {
    result <- as.bigint(1)
    for (i in n) {
        result %*=% i
    }
    return(result)
}

"length.BigInt" <- function(x) {
    return(x$length())
}

"[.BigInt" <- function(x, ...) {
    return(x$getitem(...))
}

"abs.BigInt" <- function(x) {
    return(x$abs())
}

"==.BigInt" <- function(x, y) {
    return(x$eq(y))
}

"!=.BigInt" <- function(x, y) {
    return(x$ne(y))
}

"<.BigInt" <- function(x, y) {
    return(x$lt(y))
}

">.BigInt" <- function(x, y) {
    return(x$gt(y))
}

"<=.BigInt" <- function(x, y) {
    return(x$le(y))
}

">=.BigInt" <- function(x, y) {
    return(x$ge(y))
}

"+.BigInt" <- function(x, y) {
    return(x$add(y))
}

"-.BigInt" <- function(x, y) {
    if (missing(y)) {
        return(x$neg())
    } else {
        return(x$sub(y))
    }
}

"*.BigInt" <- function(x, y) {
    return(x$mul(y))
}

"%/%.BigInt" <- function(x, y) {
    return(x$floordiv(y))
}

"%%.BigInt" <- function(x, y) {
    return(x$mod(y))
}

"^.BigInt" <- function(x, y) {
    return(x$pow(y))
}

"%+=%" <- function(x, y) {
    UseMethod("%+=%")
}

"%+=%.BigInt" <- function(x, y) {
    x$iadd(y)
}

"%-=%" <- function(x, y) {
    UseMethod("%-=%")
}

"%-=%.BigInt" <- function(x, y) {
    x$isub(y)
}

"%*=%" <- function(x, y) {
    UseMethod("%*=%")
}

"%*=%.BigInt" <- function(x, y) {
    x$imul(y)
}

"%//=%" <- function(x, y) {
    UseMethod("%//=%")
}

"%//=%.BigInt" <- function(x, y) {
    x$ifloordiv(y)
}

"%=%" <- function(x, y) {
    UseMethod("%=%")
}

"%=%.BigInt" <- function(x, y) {
    x$imod(y)
}

"%^=%" <- function(x, y) {
    UseMethod("%^=%")
}

"%^=%.BigInt" <- function(x, y) {
    x$ipow(y)
}

pow <- function(x, y, modulo = NULL) {
    UseMethod("pow")
}

pow.BigInt <- function(x, y, modulo=NULL) {
    return(x$pow(y, modulo))
}

BigInt <- R6Class(classname = "BigInt",
                  public = list(
                      str = "0",
                      positive = TRUE,
                      initialize = function(str, positive=TRUE) {
                          self$str <- str
                          self$positive <- positive
                      },
                      print = function (...) {
                          cat(paste0(ifelse(self$positive, "", "-"), self$str), "\n")
                          invisible(self)
                      },
                      copy = function() {
                          return(as.bigint(paste0(ifelse(self$positive, "", "-"), self$str)))
                      },
                      length = function() {
                          return(nchar(self$str))
                      },
                      getitem = function(n) {
                          return(substr(self$str, n[1], n[length(n)]))
                      },
                      neg = function() {
                          if (self$positive) {
                              return(as.bigint(paste0("-", self$str)))
                          } else {
                              return(as.bigint(self$str))
                          }
                      },
                      abs = function() {
                          return(as.bigint(self$str))
                      },
                      isub = function(other) {
                          result <- self - other
                          self$str <- result$str
                          self$positive <- result$positive
                      },
                      iadd = function(other) {
                          result <- self + other
                          self$str <- result$str
                          self$positive <- result$positive
                      },
                      imul = function(other) {
                          result <- self * other
                          self$str <- result$str
                          self$positive <- result$positive
                      },
                      ifloordiv = function(other) {
                          result <- self %/% other
                          self$str <- result$str
                          self$positive <- result$positive
                      },
                      imod = function(other) {
                          result <- self %% other
                          self$str <- result$str
                          self$positive <- result$positive
                      },
                      ipow = function(other, modulo) {
                          result <- self$pow(other, modulo)
                          self$str <- result$str
                          self$positive <- result$positive
                      },
                      eq = function(other) {
                          other <- as.bigint(other)
                          return(self$str == other$str & self$positive == other$positive)
                      },
                      ne = function(other) {
                          return(!(self == other))
                      },
                      le = function(other) {
                          return(self == other | self < other)
                      },
                      ge = function(other) {
                          return(self == other | self > other)
                      },
                      gt = function(other) {
                          return(!self$le(other))
                      },
                      lt = function(other) {
                          other <- as.bigint(other)
                          if (self$positive == other$positive) {
                              if (length(self) == length(other)) {
                                  if (self$str == other$str) {
                                      return(FALSE)
                                  } else {
                                      for (i in seq_len(length(self))) {
                                          if (self[i] == other[i]) {
                                              next
                                          } else {
                                              return(!xor((self[i] < other[i]), self$positive))
                                          }
                                      }
                                  }
                              } else {
                                  return(!xor(length(self) < length(other), self$positive))
                              }
                          } else {
                              return(!self$positive)
                          }
                      },
                      add = function(other) {
                          other <- as.bigint(other)
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
                                  return(as.bigint(result))
                              } else {
                                  return(as.bigint(paste0("-", result)))
                              }
                          } else {
                              if (self$positive) {
                                  return(self - -other)
                              } else {
                                  return(other - -self)
                              }
                          }
                      },
                      sub = function(other) {
                          other <- as.bigint(other)
                          if (self$positive == other$positive) {
                              if (self$str == other$str) {
                                  return(as.bigint(0))
                              }
                              if (self$positive) {
                                  if (self > other) {
                                      positive <- TRUE
                                      x <- self$str
                                      y <- other$str
                                  } else {
                                      positive <- FALSE
                                      x <- other$str
                                      y <- self$str
                                  }
                              } else {
                                  if (self > other) {
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
                                  return(as.bigint(result))
                              } else {
                                  return(as.bigint(paste0("-", result)))
                              }
                          } else {
                              if (self$positive) {
                                  return(self + -other)
                              } else {
                                  return(-(-self + other))
                              }
                          }
                      },
                      mul = function(other) {
                          other <- as.bigint(other)
                          mul <- function(e, f) {
                              if (max(length(e), length(f)) < 5) {
                                  if (e$positive == f$positive) {
                                      return(as.bigint(as.integer(e$str) * as.integer(f$str)))
                                  } else {
                                      return(as.bigint(paste0("-", as.integer(e$str) * as.integer(f$str))))
                                  }
                              }
                              g <- intToUtf8(rev(utf8ToInt(e$str)))
                              h <- intToUtf8(rev(utf8ToInt(f$str)))
                              result <- as.bigint(0)
                              for (i in seq_len(nchar(g))) {
                                  carry <- 0
                                  sub_result <- strrep("0", i - 1)
                                  for (j in seq_len(nchar(h))) {
                                      carry <- carry + as.numeric(substr(g, i, i)) * as.numeric(substr(h, j, j))
                                      sub_result <- paste0(carry %% 10, sub_result)
                                      carry <- carry %/% 10
                                  }
                                  result %+=% trimws(paste0(carry, sub_result), "left", "0")
                              }
                              result$positive <- e$positive == f$positive
                              return(result)
                          }
                          x_len <- length(self)
                          y_len <- length(other)
                          if ((max(x_len, y_len) < 5) | (min(x_len, y_len) == 1)) {
                              return(mul(self, other))
                          }
                          n <- max(x_len, y_len)
                          m <- n %/% 2
                          a_ <- as.bigint(self[1:(x_len - m)])
                          b_ <- as.bigint(self[(x_len - m + 1):x_len])
                          c_ <- as.bigint(other[1:(y_len - m)])
                          d_ <- as.bigint(other[(y_len - m + 1):y_len])
                          ac <- a_ * c_
                          bd <- b_ * d_
                          ab_cd <- (a_ + b_) * (c_ + d_)
                          r <- as.bigint(pad(ac$str, 2 * m))
                          s <- as.bigint(pad((ab_cd - ac - bd)$str, m))
                          res <- r + s + bd
                          res$positive <- self$positive == other$positive
                          return(res)
                      },
                      floordiv = function(other) {
                          other <- as.bigint(other)
                          if (abs(self) < abs(other)) {
                              result <- as.bigint(0)
                          } else {
                              value <- other$copy()
                              multipliers <- list("1" = value$copy())
                              i <- as.bigint(1)
                              while (abs(self) > abs(value)) {
                                  value %*=% 2
                                  i %*=% 2
                                  multipliers[[i$str]] <- value$copy()
                              }
                              value <- multipliers[["1"]]$copy()
                              result <- as.bigint(1)
                              for (i in rev(names(multipliers))) {
                                  if (value + multipliers[[i]] <= abs(self)) {
                                      result %+=% i
                                      value %+=% multipliers[[i]]
                                  }
                              }
                          }
                          if (self$positive == other$positive) {
                              return(result)
                          } else {
                              return(-(result + 1))
                          }
                      },
                      mod = function(other) {
                          other <- as.bigint(other)
                          if (self$str == other$str) {
                              return(as.bigint(0))
                          } else if (abs(self) > abs(other)) {
                              return(self - self %/% other * other)
                          } else if (self$positive == other$positive) {
                              return(self$copy())
                          } else {
                              return(self + other)
                          }
                      },
                      pow = function(other, modulo=NULL) {
                          value <- self$copy()
                          other <- as.bigint(other)
                          result <- as.bigint(1)
                          if (is.null(modulo)) {
                              while (other > 0) {
                                  if (other %% 2 == 1) {
                                      result %*=% value
                                  }
                                  value %*=% value
                                  other %//=% 2
                              }
                          } else {
                              while (other > 0) {
                                  if (other %% 2 == 1) {
                                      result %*=% value
                                      result %=% modulo
                                  }
                                  value %*=% value
                                  value %=% modulo
                                  other %//=% 2
                              }
                          }
                          return(result)
                      }
                  )
)
