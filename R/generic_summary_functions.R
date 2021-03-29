
#' Summary of mdl_forum_posts Object
#'
#' Provides summary statistics for forum posts.
#'
#' @param object a lazy tbl reference with class mdl_grades
#' @param ... currently ignored
#'
#' @import dplyr
#' @import anytime
#' @return a tibble with the summary.
#' @export
summary.mdl_forum_posts <- function(object, ...) {
  ret <-
    object %>%
    summarize(
      "# of posts" = n(),
      "Missing data" = sum(is.na(message)),
      Courses = n_distinct(courseid),
      Users = n_distinct(userid),
      ##"Word count" = sum(wordcount, na.rm = TRUE),
      Threads = n_distinct(thread_name),
      "Date range" = "----",
      mintime = min(created, na.rm = TRUE),
      maxtime= max(created, na.rm = TRUE)
    ) %>%
    collect() %>%
    mutate("First post" = anytime(mintime),
           "Last post" = anytime(maxtime)) %>%
    select(-mintime, -maxtime)
  class(ret) <- c("mdl_post_summary", class(ret))
  ret

}

#' Summary of mdl_grades Object
#'
#' Provides summary statistics for moodle grades
#' @inheritParams summary.mdl_forum_posts
#' @import dplyr
#' @importFrom stats sd
#' @importFrom stats median
#' @return a tibble with the summary.
#' @export
summary.mdl_grades <- function(object, ...) {
  ret <- object %>%
    mutate(normalized_grade = rawgrade / rawgrademax) %>%
    summarize(
      "# of Grades" = n(),
      "Missing" = sum(is.na(rawgrade)),
      Courses = n_distinct(courseid),
      Users = n_distinct(userid),
      "Normalized Grades" = "",
      "Median" = median(normalized_grade, na.rm = TRUE),
      "Mean" = mean(normalized_grade, na.rm = TRUE),
      "SD" = sd(normalized_grade, na.rm = TRUE),
    ) %>%
    collect()
  class(ret) <- c("mdl_grades_summary", class(ret))
  ret
}


#' Summary of mdl_courses Object
#'
#' Provides summary statistics for moodle courses
#' @inheritParams summary.mdl_forum_posts
#' @import dplyr
#' @importFrom stringr str_pad
#' @return a tibble with the summary.
#' @export
summary.mdl_courses <- function(object, ...) {
  ret <- object %>%
    summarize(
      "# of Courses" = n(),
      "Categories" = n_distinct(category_name)
    ) %>%
    collect()
  class(ret) <- c("mdl_courses_summary", class(ret))
  ret
}


#' Summary of mdl_users Object
#'
#' Provides summary statistics for moodle courses
#' @inheritParams summary.mdl_forum_posts
#' @import dplyr
#' @return a tibble with the summary.
#' @export
summary.mdl_users <- function(object, ...) {
  ret <- object %>%
    summarize(
      "# of Users" = n(),
      "Context variables:" = "",
      "Gender" = sum(!is.na(gender))
    ) %>%
    collect()
  # Check for context variables

  class(ret) <- c("mdl_users_summary", class(ret))
  ret
}
