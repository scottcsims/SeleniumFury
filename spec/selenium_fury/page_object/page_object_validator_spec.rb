require 'spec_helper'

describe PageObjectValidator do

  before(:all) { launch_web_driver TEST_PAGE_URL }
  after(:all) { stop_web_driver }

  context "with present elements" do
    it "should not raise an error when validating" do
      expect { PageObjectValidator.validate(TestPage) }.to_not raise_error
    end
  end

  context "with missing elements" do
    class MissingElement < PageObject
      element :not_a_element1, {id: 'not a element1'}
      element :not_a_element2, {id: 'not a element2'}
      generic_element :not_a_element3, {id: 'not a element3'}
      generic_element :not_a_element4, {id: 'not a element4'}
    end

    it "should find missing elements for both old and new element types" do
      expect { PageObjectValidator.validate(MissingElement) }.
          to raise_exception(RuntimeError, 'Found Missing Elements: [:not_a_element1, :not_a_element2, :not_a_element3, :not_a_element4]')
    end
  end

  context "with skipped elements" do
    class SkippedElement < PageObject
      generic_element :skip_hard_coded_element, {id: 'not_here'}, {validate: false}
      generic_element :foo_element, {css: 'missing_foo_element'}, {tags: [:foo]}
      generic_element :bar_element, {css: 'missing_bar_element'}, {tags: [:bar]}
      generic_element :multiple_tag, {css: 'missing_mult_tag_element'}, {tags: [:foo, :bar]}
      generic_element :no_tag, {css: 'missing_no_tag_element'}
    end

    it "should validate everything not hard coded when no tags are passed" do
      expect { PageObjectValidator.validate(SkippedElement) }.
          to raise_exception(RuntimeError, 'Found Missing Elements: [:foo_element, :bar_element, :multiple_tag, :no_tag]')
    end

    it "should validate all elements where all tags defined in the Page Object are passed in with the test" do
      expect { PageObjectValidator.validate(SkippedElement, validate_all: [:foo]) }.
          to raise_exception(RuntimeError, 'Found Missing Elements: [:foo_element, :no_tag]')
      expect { PageObjectValidator.validate(SkippedElement, validate_all: [:bar]) }.
          to raise_exception(RuntimeError, 'Found Missing Elements: [:bar_element, :no_tag]')
      expect { PageObjectValidator.validate(SkippedElement, validate_all: [:foo, :bar]) }.
          to raise_exception(RuntimeError, 'Found Missing Elements: [:foo_element, :bar_element, :multiple_tag, :no_tag]')
    end

    it "should validate all elements where any tag defined in Page Object is passed in with the test" do
      expect { PageObjectValidator.validate(SkippedElement, validate_any: [:foo]) }.
          to raise_exception(RuntimeError, 'Found Missing Elements: [:foo_element, :multiple_tag, :no_tag]')
      expect { PageObjectValidator.validate(SkippedElement, validate_any: [:bar]) }.
          to raise_exception(RuntimeError, 'Found Missing Elements: [:bar_element, :multiple_tag, :no_tag]')
      expect { PageObjectValidator.validate(SkippedElement, validate_any: [:foo, :bar]) }.
          to raise_exception(RuntimeError, 'Found Missing Elements: [:foo_element, :bar_element, :multiple_tag, :no_tag]')
    end

    it "should not allow multiple types of tag logic" do
      expect { PageObjectValidator.validate(SkippedElement, {validate_any: [:foo], validate_all: [:bar]}) }.
          to raise_exception(RuntimeError, 'Cannot use both :validate_any and :validate_all tags')
    end
  end
end
