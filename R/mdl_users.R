#' Get Moodle Users
#'
#' Returns a reference to the (cached) users table, with the most relevant columns selected.
#'
#' @param con a database connection object
#' @importFrom dplyr tbl
#' @importFrom dplyr select
#' @return A dbplyr reference object
#' @export
mdl_users <- function(
  con = mdl_get_connection()
) {
  ret <- tbl(con, "user")
  class(ret) <- c(class(ret), "mdl_users")
  ret
}
