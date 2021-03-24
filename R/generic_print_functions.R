#' Print Moodle Forum Post Summary
#'
#' Overrides generic print function
#' @inheritParams base::print
#' @export
print.mdl_post_summary <- function(x, ...) {

  cat("----------\n")
  for (my_name in names(x)) {
    cat(str_pad(paste0(my_name, ":"), 10, "right"),
        "\t", my_format(x[[my_name]]), "\n")
  }
  invisible(x)
}

#' Print Moodle Grades Summary
#'
#' Overrides generic print function
#' @inheritParams base::print
#'
#' @export
print.mdl_grades_summary <- function(x, ...) {
  # Pretty print
  cat("----------\n")
  for (my_name in names(x)) {
    cat(str_pad(paste0(my_name, ":"), 10, "right"), "\t",
        my_format(x[[my_name]]), "\n")
  }
  invisible(x)
}

#' Print Moodle Courses Summary
#'
#' Overrides generic print function
#' @inheritParams base::print
#'
#' @export
print.mdl_courses_summary <- function(x, ...) {
  # Pretty print
  cat("----------\n")
  for (my_name in names(x)) {
    cat(str_pad(paste0(my_name, ":"), 10, "right"), "\t",
        my_format(x[[my_name]]), "\n")
  }
  invisible(x)
}

#' Print Moodle Users Summary
#'
#' Overrides generic print function
#' @inheritParams base::print
#'
#' @export
print.mdl_users_summary <- function(x, ...) {
  # Pretty print
  cat("----------\n")
  for (my_name in names(x)) {
    cat(str_pad(paste0(my_name, ":"), 10, "right"), "\t",
        my_format(x[[my_name]]), "\n")
  }
  invisible(x)
}
