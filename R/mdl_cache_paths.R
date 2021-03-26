#' Get the Cache Directory
#'
#' @import here
#' @import config
#' @importFrom rlang inform
#' @return a character vector with the directory path
#' @export
mdl_get_cache_dir <- function() {
  ret <- config::get("moodleR")$cache_dir
  if (is.null(ret)) {
   ret <- here::here("mdl_cache")
   if (!file.exists(ret)) {
     dir.create(ret)
     rlang::inform(paste0("Directory created: ", ret))
   }
   rlang::inform(message = paste0("Directory ' ", ret,
            "' used by default. Set config variable in moodleR:mdl_cache_dir to override."),
            .frequency = "once",
            .frequency_id = "mdl_get_cache_dir"
            )
  }
  ret
}

#' Get the Cache Filename
#'
#' @inheritParams mdl_get_cache_dir
#' @impmortFrom rlang inform
#' @impor config
#' @return a character vector with the filename
#' @export
mdl_get_cache_filename <- function() {
  ret <- config::get("moodleR")$cache_filename
  if (is.null(ret)) {
   ret <- "mdl_cache.sqlite"
   rlang::inform(
     message = paste0("Filename '", ret, "' used by default. Set config variable in moodleR:mdl_cache_dir to override."),
     .frequency = "once",
     .frequency_id = "mdl_get_cache_filename"
   )
  }
  ret
}
