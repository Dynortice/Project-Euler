library(R6)
options(scipen = 20)
source("euler/R/math.R")

#' Add n zeros before or after string
#'
#' @param s: String
#' @param n: Number of zeros to add
#' @param right: Whether add 0 to right or left side
#' @returns Origin string with n leading or trailing zeros
#' @examples
#' pad("123", 2)
#' pad("123", 2, FALSE)
pad <- function (s, n, right = TRUE) {
    if (right) {
        return(paste0(s, strrep("0", n)))
    } else {
        return(paste0(strrep("0", n), s))
    }
}

#' Takes two strings and if these lengths not equal returns shorten string with leading or trailing zeros
#'
#' @param a: First string
#' @param b: Second string
#' @param right: Whether add 0 to right or left side
#' @returns Vector of 2 strings with equal lengths
#' @examples
#' align_strings("123", "123456")
#' align_strings("123456", "123", FALSE)
align_strings <- function (a, b, right = TRUE) {
    if (nchar(a) > nchar(b)) {
        b <- pad(b, nchar(a) - nchar(b), right)
    } else if (nchar(b) > nchar(a)) {
        a <- pad(a, nchar(b) - nchar(a), right)
    }
    return(c(a, b))
}

  mul_s <- function(a, b) {
      if (length(a) + length(b) < 16) {
          if (a$positive == b$positive) {
              return(as.bigint(as.numeric(a$str) * as.numeric(b$str)))
          } else {
              return(as.bigint(paste0("-", as.numeric(a$str) * as.numeric(b$str))))
          }
      }
      g <- intToUtf8(rev(utf8ToInt(a$str))); h <- intToUtf8(rev(utf8ToInt(b$str)))
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
      result$positive <- a$positive == b$positive
      return(result)
  }

is.bigint <- function(n) inherits(n, 'BigInt')

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
    for (i in n) result %+=% i
    return(result)
}

prod.bigint <- function(n) {
    result <- as.bigint(1)
    for (i in n) result %*=% i
    return(result)
}

"as.character.BigInt" <- function(x) if (x$positive) x$str else paste0("0", x$str)

#' Get number of digits
#'
#' @param x: BigInt
#' @returns Number of digits in number
#' @examples
#' lenght(as.bigint(123))
"length.BigInt" <- function(x) x$length()

#' Get n-th digit of number
#'
#' @param x: BigInt
#' @param ...: Integer vector
#' @returns n-th digit of number
#' @examples
#' as.bigint(123)[2]
#' as.bigint(123456)[3:5]
"[.BigInt" <- function(x, ...) x$getitem(...)

"abs.BigInt" <- function(x) x$abs()

"==.BigInt" <- function(x, y) x$eq(y)

"!=.BigInt" <- function(x, y) x$ne(y)

"<.BigInt" <- function(x, y) x$lt(y)

">.BigInt" <- function(x, y) x$gt(y)

"<=.BigInt" <- function(x, y) x$le(y)

">=.BigInt" <- function(x, y) x$ge(y)

"+.BigInt" <- function(x, y) x$add(y)

"-.BigInt" <- function(x, y) if (missing(y)) x$neg() else x$sub(y)

"*.BigInt" <- function(x, y) x$mul(y)

"%/%.BigInt" <- function(x, y) x$floordiv(y)

"%%.BigInt" <- function(x, y) x$mod(y)

"^.BigInt" <- function(x, y) x$pow(y)

"%+=%" <- function(x, y) UseMethod("%+=%")

"%+=%.BigInt" <- function(x, y) x$iadd(y)

"%-=%" <- function(x, y) UseMethod("%-=%")

"%-=%.BigInt" <- function(x, y) x$isub(y)

"%*=%" <- function(x, y) UseMethod("%*=%")

"%*=%.BigInt" <- function(x, y) x$imul(y)

"%//=%" <- function(x, y) UseMethod("%//=%")

"%//=%.BigInt" <- function(x, y) x$ifloordiv(y)

"%=%" <- function(x, y) UseMethod("%=%")

"%=%.BigInt" <- function(x, y) x$imod(y)

"%^=%" <- function(x, y) UseMethod("%^=%")

"%^=%.BigInt" <- function(x, y) x$ipow(y)

pow <- function(x, y, modulo = NULL) UseMethod("pow")

pow.BigInt <- function(x, y, modulo=NULL) x$pow(y, modulo)

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
                      copy = function() as.bigint(paste0(ifelse(self$positive, "", "-"), self$str)),
                      length = function() nchar(self$str),
                      getitem = function(n) substr(self$str, n[1], n[length(n)]),
                      neg = function() if (self$positive) as.bigint(paste0("-", self$str)) else as.bigint(self$str),
                      abs = function() as.bigint(self$str),
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
                          return(self$str == other$str && self$positive == other$positive)
                      },
                      ne = function(other) !(self == other),
                      le = function(other) self == other || self < other,
                      ge = function(other) self == other || self > other,
                      gt = function(other) !self$le(other),
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
                              xy <- align_strings(self$str, other$str, FALSE)
                              x <- xy[1]; y <- xy[2]
                              result <- ""
                              carry <- 0
                              len <- nchar(x)
                              for (i in seq_len(ceiling(len / 15))) {
                                  carry <- carry + as.numeric(substr(x, len - 15 * i + 1, len - 15 * (i - 1))) + as.numeric(substr(y, len - 15 * i + 1, len - 15 * (i - 1)))
                                  result <- paste0(strrep("0", fast_max(15 - nchar(carry), 0)), substr(carry, nchar(carry) - 14, nchar(carry)), result)
                                  carry <- carry %/% 10 ^ 15
                              }
                              if (carry == 0) result <- trimws(result, "left", "0") else result <- paste0(carry, result)
                              if (self$positive) return(as.bigint(result)) else return(as.bigint(paste0("-", result)))
                          } else {
                              if (self$positive) return(self - -other) else return(other - -self)
                          }
                      },
                      sub = function(other) {
                          other <- as.bigint(other)
                          if (self$positive == other$positive) {
                              if (self$str == other$str) return(as.bigint(0))
                              if (self$positive) {
                                  if (self > other) {
                                      positive <- TRUE
                                      x <- self$str; y <- other$str
                                  } else {
                                      positive <- FALSE
                                      x <- other$str; y <- self$str
                                  }
                              } else {
                                  if (self > other) {
                                      positive <- TRUE
                                      x <- other$str; y <- self$str
                                  } else {
                                      positive <- FALSE
                                      x <- self$str; y <- other$str
                                  }
                              }
                              xy <- align_strings(x, y, FALSE)
                              x <- xy[1]; y <- xy[2]
                              result <- ""
                              carry <- 0
                              len <- nchar(x)
                              for (i in seq_len(ceiling(len / 15))) {
                                  carry <- carry + as.numeric(substr(x, len - 15 * i + 1, len - 15 * (i - 1))) - as.numeric(substr(y, len - 15 * i + 1, len - 15 * (i - 1)))
                                  if (carry < 0) {
                                      result <- paste0(strrep("0", fast_max(15 - nchar(carry + 10 ^ 15), 0)), carry + 10 ^ 15, result)
                                      carry <- -1
                                  } else {
                                      result <- paste0(strrep("0", fast_max(15 - nchar(carry), 0)), carry, result)
                                      carry <- 0
                                  }
                              }
                              result <- trimws(result, "left", "0")
                              if (positive) return(as.bigint(result)) else return(as.bigint(paste0("-", result)))
                          } else {
                              if (self$positive) return(self + -other) else return(-(-self + other))
                          }
                      },
                      mul = function(other) {
                          other <- as.bigint(other)
                          x_len <- length(self); y_len <- length(other)
                          if (x_len + y_len < 16 || x_len == 1 || y_len == 1) return(mul_s(self, other))
                          n <- fast_max(x_len, y_len)
                          m <- n %/% 2
                          a <- as.bigint(self[1:(x_len - m)]); b <- as.bigint(self[(x_len - m + 1):x_len])
                          c <- as.bigint(other[1:(y_len - m)]); d <- as.bigint(other[(y_len - m + 1):y_len])
                          ac <- a * c; bd <- b * d; ab_cd <- (a + b) * (c + d)
                          r <- as.bigint(pad(ac$str, 2 * m)); s <- as.bigint(pad((ab_cd - ac - bd)$str, m))
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
                          if (self$positive == other$positive) return(result) else return(-(result + 1))
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
                                  if (other %% 2 == 1) result %*=% value
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
