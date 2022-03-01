#' Get Grades
#'
#' Returns a reference to the (cached) grades table, with the most relevant columns selected.
#'
#' @param con a database connection object
#' @importFrom dplyr tbl
#' @importFrom dplyr select
#' @return A dbplyr reference object
#' @export
#' @examples
#'\dontrun{
#' # Get the course grades for courseid 52
#' course_grades <- mdl_grades() %>%
#' filter(courseid == 52, item_type == "course") %>%
#' collect()
#' # Get the other grades items:
#' grades_items_grades <- mdl_grades() %>%
#' filter(courseid == 52, item_type != "course") %>%
#' collect()
#' }
mdl_grades <- function(
  con = mdl_get_connection(),
  tbl_prefix = "mdl_"
) {

  if(!attr(con, "use_cache")){ #direct connection
    # ret <-
    #   DBI::dbGetQuery(con,
    #                   mdl_grades_query(tbl_prefix))
    ret <-
      tbl(con,sql(mdl_grades_query(tbl_prefix)))


  } else {
    ret <- tbl(con, "grades")
  }



  class(ret) <- c(class(ret), "mdl_grades")
  ret
}

