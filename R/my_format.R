#' Formatting function
#'
#' Internal use. Attempts a package wide stardard way of formatting different kind of data.
#' @param x
#'
#' @return formatted character string
#' @noRd
my_format <- function(x) {
  # Small integer
  if (is.integer(x)) {
    if(x<1000)
      return(x)
  }

  # Numeric
  if (is.numeric(x)) {
    x <- scales::label_number_si(accuracy = ifelse(x<=1,.001,.1))(x)
  }
  # Dates
  x
}
