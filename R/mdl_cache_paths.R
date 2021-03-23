#' Get the Cache Directory
#'
#' @import here
#' @import config
#' @return a character vector with the directory path
#' @export
#'
#' @examples
mdl_get_cache_dir <- function() {
  ret <- config::get("moodleR")$cache_dir
  if (is.null(ret)) {
   ret <- here::here("mdl_cache")
   if (!file.exists(ret)) {
     dir.create(ret)
     message("Directory created: ", ret)
   }
    message("Directory'", ret,
            "' used by default. Set config variable in moodleR:mdl_cache_dir to override.")
  }
  ret
}

#' Get the Cache Filename
#'
#' @return a character vector with the filename
#' @export
#'
#' @examples
mdl_get_cache_filename <- function() {
  ret <- config::get("moodleR")$cache_filename
  if (is.null(ret)) {
   ret <- "mdl_cache.sqlite"
    message("Filename'", ret, "' used by default. Set config variable in moodleR:mdl_cache_dir to override.")
  }
  ret
}
