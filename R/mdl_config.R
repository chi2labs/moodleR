#' Moodle Configuration Table
#'
#' Get the complete moodle configuration table.
#' Different from most mdl_* functions this function calls dplyr::collect()
#' before returning (as a config-table is not going to cause memory overflow).
#'
#' @param con database connection object
#' @param tbl_prefix table prefix
#'
#' @return A tibble
#' @export
mdl_config <- function(
  con = mdl_get_connection(),
  tbl_prefix = "mdl_" ) {
  if(!attr(con, "use_cache")){ #direct connection
    ret <-  tbl(con, glue("{tbl_prefix}config")) %>%
      collect()
  } else {

  ret <- tbl(con, "mdl_config") %>%
    collect()
  }
  class(ret) <- c("mdl_config", class(ret))
  ret
}
