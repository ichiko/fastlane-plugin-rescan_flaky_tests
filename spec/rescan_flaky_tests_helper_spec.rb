describe Fastlane::Helper::RescanFlakyTestsHelper do
  describe '#extract_failed_test_cases_from_file' do
    it 'return empty array because no failed test cases' do
      path = 'spec/fixture/report_has_no_failed.junit'

      failed_test_cases = Fastlane::Helper::RescanFlakyTestsHelper.extract_failed_test_cases(path)
      expect(failed_test_cases).to eq([])
    end

    it 'return failed test cases correctly' do
      path = 'spec/fixture/report_has_failed.junit'

      failed_test_cases = Fastlane::Helper::RescanFlakyTestsHelper.extract_failed_test_cases(path)
      expect(failed_test_cases).to eq(['SampleDiceUITests/SampleDiceUITests/testDiceReturned',
                                       'SampleDiceUITests/SampleDiceUITests/testDiceReturned2'])
    end

    it 'return nil if report does not have a testsuite' do
      path = 'spec/fixture/report.txt'

      failed_test_cases = Fastlane::Helper::RescanFlakyTestsHelper.extract_failed_test_cases(path)
      expect(failed_test_cases).to be_nil
    end
  end
end
