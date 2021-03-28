#' Creates a Local Cache
#'
#' Create local cache from a  Moodle Database
#'
#' @param con a database connection (to a moodle database)
#' @param format output format (mysql, csv)
#' @param tables which tables should be included
#' @param output_dir where does the cache go
#' @param output_filename filename (in the case of sqlite output), or prefilx (in_case of CSV download)
#' @param views should stardard views be created
#' @param tbl_prefix Moodle DB table prefix
#' @import config
#' @import rlang
#' @import glue
#'
#' @export
mdl_create_cache <- function(con,
                             format=c("sqlite"),
                             views = TRUE,
                             tables = c("base"),
                             tbl_prefix = "mdl_",
                             output_dir = mdl_get_cache_dir(),
                             output_filename = mdl_get_cache_filename()
) {

  # Get connection to Moodle DB
  inform("Gettng Moodle DB connection")
  moodle_connection <- mdl_get_connection(use_cache = FALSE)

  inform("Gettng sqlite connection")
  # Get connection to sqlite
  sqlite_connection <- mdl_get_cache_connection(access = "RWC")
  inform(glue::glue("Cache file created: {sqlite_connection@dbname}"))

  # Check connection

  # Course Table####
  inform("Downloading course table")

  myCourses <-
    tbl(moodle_connection, glue("{tbl_prefix}course")) %>%
    mutate(courseid = id) %>%
    mutate(categoryid = category) %>%
    left_join(
      tbl(moodle_connection, glue("{tbl_prefix}course_categories")) %>%
        select(categoryid = id, category_name = name)
    ) %>%
    collect()

  inform("Caching course table")
  DBI::dbWriteTable(sqlite_connection, "courses", myCourses)

  # Discussion posts ####
  inform("Downloading discussion posts table")
  posts_query <-
    glue('SELECT f.course as courseid,
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
  fp.wordcount,
  fp.created,
  fp.modified
  FROM {tbl_prefix}forum_posts fp
  LEFT JOIN  {tbl_prefix}forum_discussions fd ON fd.id = fp.discussion
  LEFT JOIN {tbl_prefix}forum f ON fd.forum = f.id
  LEFT JOIN {tbl_prefix}forum_posts fp2 ON fp2.parent = fp.id')

  myPosts <- DBI::dbGetQuery(moodle_connection, posts_query)
  inform("Caching discussion posts table")
  DBI::dbWriteTable(sqlite_connection, "posts",
                    myPosts %>%
                      collect())


  # Users table ####
  inform("Downloading user table")

  myUsers <-
    tbl(moodle_connection, glue("{tbl_prefix}user")) %>%
    mutate(userid = id)

  DBI::dbWriteTable(sqlite_connection, "user",
                    myUsers %>%
                      collect())

  inform("Downloading grades table")
  myGrades <-
    tbl(moodle_connection, glue({tbl_prefix},grades))

  ## Clean up ####
  DBI::dbDisconnect(sqlite_connection)
  DBI::dbDisconnect(moodle_connection)
}
