#' Format with Orders of Magnitude
#'
#' Formats 1234 as 1.23 K for easier reading. This is a temporary function, awaiting a pull-request and CRAN publication of https://github.com/r-lib/prettyunits
#'
#' @param numbers
#' @importFrom prettyunits pretty_bytes
#' @return formatted charecter vector
#' @export
pretty_num <- function(numbers, style = c("default","nopad","6")){
  pretty_bytes(numbers, style) %>%
    stringr::str_replace("B", "") %>%
    stringr::str_replace("kB", "K") %>%
    stringr::str_replace("GB", "M")
}
