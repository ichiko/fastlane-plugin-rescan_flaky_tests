require 'rexml/document'

module Fastlane
  module Helper
    class RescanFlakyTestsHelper
      # class methods that you define here become available in your action
      # as `Helper::RescanEachFragileTestsHelper.your_method`
      #
      def self.extract_failed_test_cases(report_file)
        xml_doc = REXML::Document.new(File.open(report_file))

        if xml_doc.elements.collect("testsuites") { |e| e }.count == 0
          return nil
        end

        test_cases = []
        xml_doc.elements.each("testsuites/testsuite/testcase[failure]") do |test_case|
          (bundle, test_suite) = test_case.attributes["classname"].split(".")
          method = test_case.attributes["name"]
          # xcodebuild changes '-' to '_'
          bundle.gsub!("_", "-")
          test_cases << "#{bundle}/#{test_suite}/#{method}"
        end
        test_cases
      end
    end
  end
end
