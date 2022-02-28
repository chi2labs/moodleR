#' Get Forum Posts
#'
#' Returns a reference to the (cached) forum_posts table, with the most relevant columns selected.
#'
#' For convenience two additional columns: forum_name and thread_name; are added.
#'
#' @param tbl_prefix table prefix
#' @param con a database connection object
#'
#' @importFrom dplyr tbl
#' @importFrom dplyr select
#' @return A dbplyr reference object.
#' @export
mdl_forum_posts <- function(
  con = mdl_get_connection(),
  tbl_prefix = "mdl_"
) {
  if(!attr(con, "use_cache")){ #direct connection
     ret <-
       DBI::dbGetQuery(con,
                       mdl_posts_query(tbl_prefix))
  } else{
    ret <- tbl(con, "posts")

  }
  class(ret) <- c(class(ret), "mdl_forum_posts")
  ret

}
