require 'test_helper'

class LogFilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @log_file = log_files(:one)
  end

  test "should get index" do
    get log_files_url
    assert_response :success
  end

  test "should get new" do
    get new_log_file_url
    assert_response :success
  end

  test "should create log_file" do
    assert_difference('LogFile.count') do
      post log_files_url, params: { log_file: {  } }
    end

    assert_redirected_to log_file_url(LogFile.last)
  end

  test "should show log_file" do
    get log_file_url(@log_file)
    assert_response :success
  end

  test "should get edit" do
    get edit_log_file_url(@log_file)
    assert_response :success
  end

  test "should update log_file" do
    patch log_file_url(@log_file), params: { log_file: {  } }
    assert_redirected_to log_file_url(@log_file)
  end

  test "should destroy log_file" do
    assert_difference('LogFile.count', -1) do
      delete log_file_url(@log_file)
    end

    assert_redirected_to log_files_url
  end
end
