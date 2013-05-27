require 'spec_helper'
describe SeleniumFury::SeleniumWebDriver::PageValidator do

  before(:each) do
    launch_web_driver TEST_PAGE_URL
  end

  context "with present elements" do

    it "should not raise an error when validating" do
      expect { validate(TestPage) }.to_not raise_error
    end
  end


  context "with missing elements" do

    class MissingElement < PageObject
      element :not_a_element1, {:id => "not a element1"}
      element :not_a_element2, {:id => "not a element2"}
      generic_element :not_a_element3, {:id => "not a element3"}
      generic_element :not_a_element4, {:id => "not a element4"}
    end

    it "should find missing elements for both old and new element types" do
      expect { validate(MissingElement) }.
          to raise_exception(RuntimeError, "Found Missing Elements: [:not_a_element1, :not_a_element2, :not_a_element3, :not_a_element4]")
    end
  end


  context "with skipped elements" do

    class SkippedElement < PageObject
      generic_element :skip_element, {id: 'not_here'}, {validate: false}
    end

    it "should not raise an error when new element types are designated to be skipped" do
      expect { validate(SkippedElement) }.to_not raise_error
    end
  end
end
