test_that("Default paths look good", {
  expect_equal(mdl_get_cache_filename(),"mdl_cache.sqlite")
  expect(endsWith(mdl_get_cache_dir(),"mdl_cache"),failure_message = "Default cache directory path unexpected")
})
