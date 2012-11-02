require 'spec_helper'
describe SeleniumFury::SeleniumApiChooser do
  context "Finding generate/validate methods" do
    it "should find the generator for selenium web_driver tests" do
      launch_web_driver TEST_PAGE_URL
      should_receive(:web_driver_generate)
      generate(driver)
    end
    it "should find the validator for selenium web driver tests" do
      launch_web_driver TEST_PAGE_URL
      should_receive(:web_driver_validate).with(NilClass)
      validate(NilClass)
    end
  end
end