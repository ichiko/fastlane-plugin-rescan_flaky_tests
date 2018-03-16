# rescan_flaky_tests plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-rescan_flaky_tests)


## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-rescan_flaky_tests`, add it to your project by running:

```bash
fastlane add_plugin rescan_flaky_tests
```

## About rescan_flaky_tests

Re-run `scan` action for each failed test case.

When you running UI tests (XCUITest, EarlGrey or others), sometime that failed with un clear reason.

This plugin re-scan each failed test cases. And report result under `#{output_directory}/rescan/NN`.

## Example

Check out the [example `Fastfile`](example/SampleDice/fastlane/Fastfile) to see how to use this plugin. Try it by cloning the repo, running `cd example/SampleDice; fastlane install_plugins` and `bundle exec fastlane test_ui`.

## Run tests for this plugin

To run both the tests, and code style validation, run

```
rake
```

To automatically fix many of the styling issues, use
```
rubocop -a
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
