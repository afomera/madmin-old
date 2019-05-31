require "test_helper"
require "generators/madmin/controller/controller_generator"

module Madmin
  class Madmin::ControllerGeneratorTest < Rails::Generators::TestCase
    tests Madmin::ControllerGenerator
    destination Rails.root.join("tmp/generators")
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
