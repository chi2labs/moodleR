#' Get Forum Posts
#'
#' Returns a reference to the (cached) forum_posts table, with the most relevant columns selected.
#'
#' For convenience two additional columns: forum_name and thread_name; are added.
#'
#' @param con a database connection object
#' @importFrom dplyr tbl
#' @importFrom dplyr select
#' @return A dbplyr reference object.
#' @export
mdl_forum_posts <- function(
  con = mdl_get_connection()
) {
  ret <- tbl(con, "posts") %>%
  select(
    id,
    discussion = forumId,
    parent,
    created = created_raw,
    userid = participantId,
    courseid = courseId,
    subject,
    message = cleansedMessage,
    wordcount = wordCount,
    forum_name,
    forum_id = forumId,
    thread_name
  )

  class(ret) <- c(class(ret), "mdl_forum_posts")

  ret
}
