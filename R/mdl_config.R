#' Moodle Configuration Table
#'
#' Get the complete moodle configuration table.
#' Different from most mdl_* functions this function calls dplyr::collect()
#' before returning (as a config-table is not going to cause memory overflow).
#'
#' @param con database connection object
#'
#' @return A tibble
#' @export
mdl_config <- function(con = mdl_get_connection() ) {
  ret <- tbl(con, "mdl_config") %>%
    collect()
  class(ret) <- c("mdl_config", class(ret))
  ret
}
