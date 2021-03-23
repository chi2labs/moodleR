#' Summary of mdl_forum_posts Object
#'
#' Provides summary statistics for forum posts.
#'
#' @param object a lazy tbl reference with class mdl_grades
#' @param ... currently ignored
#'
#' @import dplyr
#' @importFrom stringr str_pad
#' @return a tibble with the summary.
#' @export
summary.mdl_forum_posts <- function(object, ...) {
  ret <-
    object %>%
    summarize(
      "# of posts" = n(),
      Courses = n_distinct(courseid),
      Users = n_distinct(userid),
      "Word count" = sum(wordcount),
      Threads = n_distinct(thread_name),
      "Date range" = "----",
      "First post" = min(created),
      "Most recent" = max(created)
    ) %>%
    collect()
  .mf <- function(x) {
    if (is.numeric(x)) {
      return(toupper(pretty_num(x, style = "6")))
    }
    x
  }
  # # Pretty print
  cat("----------\n")
  for (my_name in names(ret)) {
    cat(str_pad(paste0(my_name, ":"), 10, "right"),
        "\t", .mf(ret[[my_name]]), "\n")
  }
  invisible(ret)
}

#' Summary of mdl_grads Object
#'
#' Provides summary statistics for moodle grades
#' @inheritParams summary.mdl_forum_posts
#' @import dplyr
#' @importFrom stats sd
#' @importFrom stats median
#' @importFrom stringr str_pad
#' @return a tibble with the summary.
#' @export
summary.mdl_grades <- function(object, ...) {
  ret <- object %>%
    mutate(normalized_grades = finalGrade / rawgrademax) %>%
    summarize(
      "# of Grades" = n(),
      Courses = n_distinct(courseid),
      Users = n_distinct(userid),
      "Normalized Grades" = "",
      "Median" = median(normalized_grades, na.rm = TRUE),
      "Mean" = mean(normalized_grades, na.rm = TRUE),
      "SD" = sd(normalized_grades, na.rm = TRUE),
    ) %>%
    collect()
  # Pretty print
  cat("----------\n")
  for (my_name in names(ret)) {
    tmp <- ret[[my_name]]
    if (is.numeric(tmp)) {
      tmp <- pretty_num(tmp)
    }
    cat(str_pad(paste0(my_name, ":"), 10, "right"), "\t", tmp, "\n")
  }
  invisible(ret)
}
