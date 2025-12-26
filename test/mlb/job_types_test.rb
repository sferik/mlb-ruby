require_relative "../test_helper"

module MLB
  class JobTypesTest < Minitest::Test
    cover JobTypes

    def test_self_all
      stub_request(:get, "https://statsapi.mlb.com/api/v1/jobTypes")
        .to_return(body: '[{"code":"UMPR","job":"Umpire","sortOrder":1}]',
          headers: {"Content-Type" => "application/json;charset=UTF-8"})
      job_type = JobTypes.all.first

      assert_requested :get, "https://statsapi.mlb.com/api/v1/jobTypes"
      assert_equal "UMPR", job_type.code
      assert_equal "Umpire", job_type.job
    end
  end
end
