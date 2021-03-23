#' Wordcloud Plot
#'
#' Create a simple wordcloud plot based on a mdl_posts object.
#'
#' @param my_posts a lazy tbl reference with class mdl_forum_posts
#'
#' @return ggplot
#' @import ggwordcloud
#' @import tidytext
#' @importFrom utils head
#' @export
plot.mdl_forum_posts <- function(my_posts) {
  max_freq <- 200
  my_posts %>%
    collect() %>%
    unnest_tokens(word, message) %>%
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
