#' Creates a Local Cache
#'
#' Create local cache from a  Moodle Database.
#'
#' @param con a database connection (to a moodle database)
#' @param format output format (mysql, csv)
#' @param output_dir where does the cache go
#' @param output_filename filename (in the case of sqlite output), or prefix (in_case of CSV download)
#' @param tbl_prefix Moodle DB table prefix
#' @return invisible(NULL)
#' @import config
#' @import rlang
#' @importFrom glue glue
#'
#' @export
mdl_create_cache <- function(con = mdl_get_connection(use_cache = FALSE),
                             format=c("sqlite"),
                             tbl_prefix = "mdl_",
                             output_dir = mdl_get_cache_dir(),
                             output_filename = mdl_get_cache_filename()
) {

  # Get connection to Moodle DB
  inform("Gettng Moodle DB connection")
  moodle_connection <- con

  inform("Gettng sqlite connection")
  # Get connection to sqlite
  sqlite_connection <- mdl_get_cache_connection(access = "RWC")
  inform(glue::glue("Cache file created: {sqlite_connection@dbname}"))

  # Check connection

  # Course Table####
  inform("Downloading course table")

  my_courses <-
    tbl(moodle_connection, glue("{tbl_prefix}course")) %>%
    mutate(courseid = id) %>%
    mutate(categoryid = category) %>%
    left_join(
      tbl(moodle_connection, glue("{tbl_prefix}course_categories")) %>%
        select(categoryid = id, category_name = name)
    ) %>%
    collect()

  inform("Caching course table")
  DBI::dbWriteTable(sqlite_connection, "courses", my_courses)
  rm(my_courses)

  # Discussion posts ####
  inform("Downloading discussion posts table")

  my_posts <-
    DBI::dbGetQuery(moodle_connection,
                    mdl_posts_query(tbl_prefix))

  inform("Caching discussion posts table")
  DBI::dbWriteTable(sqlite_connection, "posts",
                    my_posts %>%
                      collect())
  rm(my_posts)


  # Users table ####
  inform("Downloading user table")

  my_users <-
    tbl(moodle_connection, glue("{tbl_prefix}user")) %>%
    mutate(userid = id)
  inform("Caching user table")
  DBI::dbWriteTable(sqlite_connection, "user",
                    my_users %>%
                      collect())
  rm(my_users)

    # Grades table ####
  inform("Downloading grades table")
  my_grades <-
    DBI::dbGetQuery(moodle_connection, mdl_grades_query(tbl_prefix))

  inform("Caching grades table")
  DBI::dbWriteTable(sqlite_connection, "grades",
                    my_grades %>% collect())
  rm(my_grades)

  # Moodle config ####
  inform("Downloading config table")
  my_config_tbl <-
    tbl(moodle_connection, glue("{tbl_prefix}config"))
  DBI::dbWriteTable(sqlite_connection, "mdl_config",
                    my_config_tbl %>% collect())
  rm(my_config_tbl)

  # Log tables ####
  inform("Downloading log table")
  my_moodle_log <-
    tbl(moodle_connection, glue("{tbl_prefix}logstore_standard_log"))
  inform("Caching log table")
  DBI::dbWriteTable(sqlite_connection, "standard_log",
                    my_moodle_log %>% collect())
  rm(my_moodle_log)

  # Roles
  inform("Downloading roles table")
  my_roles <-
    tbl(moodle_connection, glue("{tbl_prefix}role"))
  inform("Caching role table")
  DBI::dbWriteTable(sqlite_connection, "role",
                    my_roles %>% collect())
  rm(my_roles)


  # Enrolment ####
  inform("Downloading enrolments")
  my_enrolments <-
    tbl(moodle_connection, glue("{tbl_prefix}user_enrolments"))
  inform("Caching enrolments")
  DBI::dbWriteTable(sqlite_connection, "enrolments",
                    my_enrolments %>% collect())
  rm(my_enrolments)

  # Clean up ####
  DBI::dbDisconnect(sqlite_connection)
  DBI::dbDisconnect(moodle_connection)
  invisible(NULL)
}
