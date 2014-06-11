function simple_reporter__test_files_start_running() {
  :
}

function simple_reporter__test_file_starts_running() {
	system__print_line "[File] $1"
}

function simple_reporter__global_setup_has_failed() {
  system__print_line_with_color \
    "Global setup has failed" ${SBU_YELLOW_COLOR_CODE}
}

function simple_reporter__test_starts_running() {
	system__print_line "[Test] $1"
}

function simple_reporter__test_has_succeeded() {
  system__print_line_with_color "OK" ${SBU_GREEN_COLOR_CODE}
}

function simple_reporter__test_has_failed() {
  system__print_line_with_color "KO" ${SBU_RED_COLOR_CODE}
}

function simple_reporter__test_is_skipped() {
  system__print_line_with_color "Skipped" ${SBU_YELLOW_COLOR_CODE}
}

function simple_reporter__redirect_test_output() {
  local text
  while read text; do
    system__print_line "${text}"
  done
}

function simple_reporter__test_ends_running() {
  :
}

function simple_reporter__test_file_ends_running() {
	system__print_new_line
}

function simple_reporter__test_files_end_running() {
	system__print_line "[Results]"
	local color="$(_reporter__get_color_code_for_tests_result)"
	local total_count="$(_simple_reporter__get_total_count_message)"
	local failures_count="$(_simple_reporter__get_failures_count_message)"
	local skipped_count="$(results__get_skipped_tests_count) skipped"
	local time="in $(results__get_run_time)s"
	local message="${total_count}, ${failures_count}, ${skipped_count} ${time}"
	system__print_line_with_color "${message}" "${color}"
}

function _simple_reporter__get_total_count_message() {
  local count="$(results__get_total_tests_count)"
  system__print "${count} test$(_simple_reporter__get_agreement ${count})"
}

function _simple_reporter__get_failures_count_message() {
  local count="$(results__get_failing_tests_count)"
  system__print "${count} failure$(_simple_reporter__get_agreement ${count})"
}

function _simple_reporter__get_agreement() {
  (( $1 > 1 )) \
    && system__print "s" \
    || system__print ""
}