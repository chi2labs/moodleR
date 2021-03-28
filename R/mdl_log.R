#' Access Moodle's Logs
#'
#' Returns a reference to the log-table.
#'
#' @param con A database connection object
#' @importFrom dplyr tbl
#' @importFrom dplyr select
#' @return A dbplyr reference object.
#' @export
mdl_log <- function(con = mdl_get_connection()) {
  ret <- tbl(con, "standard_log")
  class(ret) <- c(class(ret), "mdl_log")
  ret
}
