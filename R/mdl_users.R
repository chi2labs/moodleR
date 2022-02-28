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
  con = mdl_get_connection(),
  tbl_prefix = "mdl_"
) {
  if(!attr(con, "use_cache")){ #direct connection
  ret <- tbl(con, glue("{tbl_prefix}user")) %>%
    mutate(userid = id) %>%
      collect()
  } else {
    ret <- tbl(con, "user")
  }

  class(ret) <- c(class(ret), "mdl_users")
  ret
}
