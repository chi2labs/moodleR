#' Access Moodle's Logs
#'
#' Returns a reference to the log-table.
#'
#' @param tbl_prefix table prefix
#' @param con A database connection object
#'
#' @importFrom dplyr tbl
#' @importFrom dplyr select
#' @return A dbplyr reference object.
#' @export
mdl_log <- function(
  con = mdl_get_connection(),
  tbl_prefix = "mdl_") {

  if(!attr(con, "use_cache")){ #direct connection
    ret <-
      tbl(con, glue("{tbl_prefix}logstore_standard_log"))
  } else {
    ret <- tbl(con, "standard_log")
  }

  class(ret) <- c(class(ret), "mdl_log")
  ret
}
