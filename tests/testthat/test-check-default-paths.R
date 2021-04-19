test_that("Default paths look good", {
  expect_equal(mdl_get_cache_filename(),"mdl_cache.sqlite")
})
