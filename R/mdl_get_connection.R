#' Connect to Moodle Data
#'
#' Returns a connection to a Moodle database or the cached version if available.e
#'
#' @param use_cache If TRUE (the default) connection to the local cache is returned.
#'
#' @return a DBI connection object
#' @export
mdl_get_connection <- function(
  use_cache = TRUE
) {
  if (isTRUE(use_cache)) {
    mdl_get_cache_connection()
  }
}


#' Connection to Cached Moodle Data
#'
#' @importFrom RSQLite SQLite
#' @importFrom DBI dbConnect
#' @return a DBI connection object
#' @export
mdl_get_cache_connection <- function() {
  con <- DBI::dbConnect(RSQLite::SQLite(),
                        dbname = paste0(mdl_get_cache_dir(), "/", mdl_get_cache_filename())
  )
  # TODO: Add checks etc. here

  con
}
