#' Get Grades
#'
#' Returns a reference to the (cached) grades table, with the most relevant columns selected.
#'
#' @param con a database connection object
#' @importFrom dplyr tbl
#' @importFrom dplyr select
#' @return A dbplyr reference object.
#' @export
mdl_grades <- function(
  con = mdl_get_connection()
) {
  ret <- tbl(con, "grades") %>%
  rename(userid = participantId) #TODO: temporary mapping
  class(ret) <- c(class(ret), "mdl_grades")
  ret
}
