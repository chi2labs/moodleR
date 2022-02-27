#' Get Courses
#'
#' Returns a reference to the (cached) course table, with the most relevant columns selected.
#'
#' For convenience a join with the category table is made, and "category_name" added
#'
#' @param tbl_prefix prefix for tables
#' @param con a database connection object
#'
#' @importFrom dplyr tbl
#' @importFrom dplyr select
#' @return A dbplyr reference object.
#' @export
mdl_courses <- function(
  con = mdl_get_connection(),
  tbl_prefix = "mdl_"
) {

  if(!attr(my_con,"use_cache")){ #direct connection
    my_courses <-
      tbl(con, glue("{tbl_prefix}course")) %>%
      mutate(courseid = id) %>%
      mutate(categoryid = category) %>%
      left_join(
        tbl(con, glue("{tbl_prefix}course_categories")) %>%
          select(categoryid = id, category_name = name)
      )
    return(my_courses)
  }

  ret <- tbl(con, "courses") %>%
    mutate(id = courseid)
  class(ret) <- c(class(ret), "mdl_courses")
  ret
}
