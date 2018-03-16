describe Fastlane::Actions::RescanFlakyTestsAction do
  describe '#run' do
    it 'raise error if report does not exist' do
      expect do
        Fastlane::FastFile.new.parse(<<-FASTFILE).runner.execute(:test)
          lane :test do
            rescan_flaky_tests(
              report_file: 'hoge'
            )
          end
        FASTFILE
      end.to raise_error(FastlaneCore::Interface::FastlaneError, "The report file 'hoge' is not found.")
    end

    it 'raise error if report does not junit xml' do
      expect do
        Fastlane::FastFile.new.parse(<<-FASTFILE).runner.execute(:test)
          lane :test do
            rescan_flaky_tests(
              report_file: '../spec/fixture/report.txt'
            )
          end
        FASTFILE
      end.to raise_error(FastlaneCore::Interface::FastlaneError, "The report should be junit xml file.")
    end

    it 'continue if no failed test cases' do
      expect(Fastlane::UI).to receive(:important).with("There is no test to retry.")

      Fastlane::FastFile.new.parse(<<-FASTFILE).runner.execute(:test)
        lane :test do
          rescan_flaky_tests(
            report_file: '../spec/fixture/report_has_no_failed.junit'
          )
        end
      FASTFILE
    end

    it 'rescan if there is failed test cases' do
      expect(Fastlane::Helper::RescanFlakyTestsHelper).to receive(:extract_failed_test_cases).and_return(
        ['SampleDiceUITests/SampleDiceUITests/testDiceReturned',
         'SampleDiceUITests/SampleDiceUITests/testDiceReturned2']
      )
      expect(Fastlane::UI).to receive(:important).with("Rescan 'SampleDiceUITests/SampleDiceUITests/testDiceReturned'.")
      expect(Fastlane::UI).to receive(:important).with("Rescan 'SampleDiceUITests/SampleDiceUITests/testDiceReturned2'.")
      expect(Fastlane::UI).to receive(:important).with("Reports are saved 'test-results/rescan/1'.")
      expect(Fastlane::UI).to receive(:important).with("Reports are saved 'test-results/rescan/2'.")
      expect(Fastlane::Actions::ScanAction).to receive(:run) do |arg|
        expect(arg[:device]).to eq('iPhone 8')
        expect(arg[:only_testing]).to eq(['SampleDiceUITests/SampleDiceUITests/testDiceReturned'])
        expect(arg[:output_directory]).to eq('test-results/rescan/1')
      end
      expect(Fastlane::Actions::ScanAction).to receive(:run) do |arg|
        expect(arg[:device]).to eq('iPhone 8')
        expect(arg[:only_testing]).to eq(['SampleDiceUITests/SampleDiceUITests/testDiceReturned2'])
        expect(arg[:output_directory]).to eq('test-results/rescan/2')
      end

      Fastlane::FastFile.new.parse(<<-FASTFILE).runner.execute(:test)
        lane :test do
          rescan_flaky_tests(
            scan: { device: 'iPhone 8', output_directory: 'scan-results' },
            report_file: '../spec/fixture/report_has_failed.junit',
            output_directory: 'test-results'
          )
        end
      FASTFILE
    end

    it 'do not rescan if there is failed test cases over threshold' do
      expect(Fastlane::UI).to receive(:error).with("Stop rescan because there are too many faild cases, 3 > 2 (threshold).")
      expect(Fastlane::Actions::ScanAction).to receive(:run).at_most(0).times

      expect do
        Fastlane::FastFile.new.parse(<<-FASTFILE).runner.execute(:test)
          lane :test do
            rescan_flaky_tests(
              report_file: '../spec/fixture/report_has_many_failed.junit',
              output_directory: 'test-results',
              failed_test_limit: 2
            )
          end
        FASTFILE
      end.to raise_error SystemExit
    end
  end

  describe '#available_options' do
    it 'return options correctly' do
      options = Fastlane::Actions::RescanFlakyTestsAction.available_options
      expect(options.count).to equal(4)
    end
  end
end
