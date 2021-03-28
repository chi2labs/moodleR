#' Get Courses
#'
#' Returns a reference to the (cached) course table, with the most relevant columns selected.
#'
#' For convenience a join with the category table is made, and "category_name" added
#'
#' @param con a database connection object
#' @importFrom dplyr tbl
#' @importFrom dplyr select
#' @return A dbplyr reference object.
#' @export
mdl_courses <- function(
  con = mdl_get_connection()
) {
  ret <- tbl(con, "courses") %>%
    mutate(id = courseid)
  class(ret) <- c(class(ret), "mdl_courses")
  ret
}
