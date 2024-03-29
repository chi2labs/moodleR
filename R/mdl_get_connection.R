#' Connect to Moodle Data
#'
#' Returns a connection to a Moodle database or the cached version if available.e
#'
#' @param use_cache If TRUE (the default) connection to the local cache is returned.
#' @param config Select configuration from config file
#'
#' @import DBI
#' @import RMariaDB
#' @return a DBI connection object
#' @export
mdl_get_connection <- function(
  use_cache = TRUE,
  config = "default"
) {
  if (isTRUE(use_cache)) {
    return(
      mdl_get_cache_connection()
    )
  }
  # mySQL connection
  myConf <- tryCatch(config::get(config = config),
                     error = function(e){NULL}
  )
  if(is.null(myConf))stop("Configuration could not be loaded.")

  if(identical(myConf$moodleR$db_driver,"postgres")){
    db_port <- myConf$moodleR$port
    if(is.null(db_port)) db_port <- 5432
    my_connection <-
      DBI::dbConnect(
        RPostgres::Postgres(),
        user = myConf$moodleR$user,
        password = myConf$moodleR$password,
        dbname = myConf$moodleR$dbname,
        host = myConf$moodleR$host,
        port = db_port,
        bigint = "integer64"
      )

  } else { #default

    my_connection <-
      DBI::dbConnect(
        RMariaDB::MariaDB(),
        user = myConf$moodleR$user,
        password = myConf$moodleR$password,
        dbname = myConf$moodleR$dbname,
        host = myConf$moodleR$host,
        bigint = "integer64"
      )
  }

  attr(my_connection,"use_cache") <- FALSE
  my_connection
}


#' Connection to Cached Moodle Data
#'
#' @param access Specifies RO or RWC access
#'
#' @importFrom RSQLite SQLite
#' @importFrom DBI dbConnect
#' @return a DBI connection object
#' @export
mdl_get_cache_connection <- function(access = c("RO","RWC")) {

  flags <- match.arg(access)
  flags <- switch(
    flags,
    RO = RSQLite::SQLITE_RO,
    RWC = RSQLite::SQLITE_RWC
  )

  con <- DBI::dbConnect(RSQLite::SQLite(),
                        dbname = file.path(mdl_get_cache_dir(), mdl_get_cache_filename()),
                        flags = flags
  )
  # TODO: Add checks etc. here

  con
}
