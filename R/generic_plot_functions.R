#' Wordcloud Plot
#'
#' Create a simple wordcloud plot based on a mdl_posts object.
#'
#' @param x a lazy tbl reference or data.frame.
#' @param use_base_graphics Should base graphics be produces instead of ggplot?
#' @param ... passed to ggplot or base graphics
#'
#' @return A ggplot
#'
#' @import ggwordcloud
#' @import tidytext
#' @import dplyr
#' @import magrittr
#' @import ggplot2
#' @importFrom utils head
#' @export
plot.mdl_forum_posts <- function(x, use_base_graphics = FALSE,...) {
  max_freq <- 200
  x %>%
    collect() %>%
    tidytext::unnest_tokens(word, message) %>%
    anti_join(tidytext::stop_words, by = "word") %>%
    count(word, sort = TRUE) -> tmp
  if (nrow(tmp) > max_freq) {
    message("Frequency table is larger than ", max_freq, " entries. (N=", nrow(tmp), ") The first ", max_freq, " entries are used for this visualization.")
    tmp <- head(tmp, max_freq)
  }
  tmp %>%
    ggplot(aes(label = word, size = n)) +
    geom_text_wordcloud_area()
}

plot.mdl_log <- function() {

}

#' Plot Moodle Grades
#'
#' Histogram (density) of normalized grades
#'
#' @param x a lazy tbl reference
#' @param use_base_graphics Should base graphics be used (instead of ggplot)
#' @param ... passed along to ggplot or base graphic function
#'
#' @import dplyr
#' @import ggplot2
#' @return A ggplot or base  graphic plot
#' @export
plot.mdl_grades <- function(x, use_base_graphics = FALSE, ...) {
  x %>%
    filter(rawgrademax > 0) %>%
    mutate(normalized_grade = rawgrade / rawgrademax) %>%
    filter(!is.na(normalized_grade)) %>%
    filter(normalized_grade >= 0) %>%
    filter(normalized_grade <= 1) -> tmp
  if(!use_base_graphics) {
    tmp %>%
    ggplot(aes(normalized_grade)) +
    geom_histogram(binwidth = .1) +
    scale_x_continuous(labels = scales::percent,limits = c(-.1,1.1)) +
    scale_y_continuous(labels = scales::label_number_si()) +
    xlab("Normalized Grade") +
    ylab("")
  } else { # ==> use base graphics
    tmp <- tmp %>%
      collect()
      hist(tmp$normalized_grade,
           xlab = "Normalized Grades",main="Histogram of Normalized Grades",...)
  }
}
