#' Raw query for discussion posts
#'
#' @importFrom glue glue
#' @param tbl_prefix for moodle
#' @keywords internal
#' @return character vector with moodle query
mdl_posts_query <- function(tbl_prefix) {
glue("SELECT f.course as courseid,
  fp.userid,
  f.id as forum_id,
  f.name as forum_name,
  f.intro as forum_desc,
  f.name as thread_name,
  fp2.id as id,
  fp.discussion as discussion_id,
  fp.subject as subject,
  fp.message as message,
  fp.parent as parent_discussion_id,
  fp2.userid as parent_discussion_participant_id,
  -- fp.wordcount,
  fp.created,
  fp.modified
  FROM {tbl_prefix}forum_posts fp
  LEFT JOIN  {tbl_prefix}forum_discussions fd ON fd.id = fp.discussion
  LEFT JOIN {tbl_prefix}forum f ON fd.forum = f.id
  LEFT JOIN {tbl_prefix}forum_posts fp2 ON fp2.parent = fp.id")
}
