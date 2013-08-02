require 'spec_helper'

describe ElementTypes::GenericElement do

  let(:test_page) { TestPage.new(driver) }
  before(:all) { start_web_driver TEST_PAGE_URL }
  after(:all) { stop_web_driver }

  it 'should return correct object type' do
    test_page.input_checkbox_element.should be_an ElementTypes::CheckboxElement
  end

  it 'should return correct superclass object type' do
    test_page.input_checkbox_element.should be_an ElementTypes::GenericElement
  end

  it 'should provide location' do
    test_page.form_element.location.should == {id: 'form'}
  end

  it 'should return a web driver element' do
    test_page.form_element.el.should be_an Selenium::WebDriver::Element
  end

  it 'should find visible elements' do
    test_page.form_element.visible?.should be_true
  end

  it 'should return the value' do
    test_page.input_button_element.value.should == 'Click me'
  end

  it 'When there is more than one element with the provided locator, it should return an array of GenericElements' do
    test_page.listings_element.list.should be_an Array
    test_page.listings_element.list[0].should be_a ElementTypes::GenericElement
  end

  it 'List element should provide correct information' do
    test_page.listings_element.list[0].location.should == {css: 'li.listing:nth-of-type(1)'}
    test_page.listings_element.list[0].text.should == 'Herpa'
  end

  describe '#double_click' do
    it 'should double-click the given element' do
      status_before = test_page.input_doubleclick['readonly']
      test_page.input_doubleclick.double_click
      status_after = test_page.input_doubleclick['readonly']

      status_after.should_not == status_before
    end
  end

  describe '#double_click!' do
    it 'should simply invoke click twice, ignoring any errors encountered on the initial click' do
      status_before = test_page.input_doubleclick['readonly']
      test_page.input_doubleclick.double_click!
      status_after = test_page.input_doubleclick['readonly']

      status_after.should == status_before # Because two #click()'s does not equal one #dblclick()
    end
  end

  describe 'Dynamic Locators' do
    it 'should allow a single dynamic selection of an element with id' do
      specific_element = test_page.dynamic_locator_id.update_locator(id: 222222)
      specific_element.location.should == {id: 'link222222'}
      specific_element.link.should == 'http://yahoo.com/'
    end

    it 'should allow multiple dynamic selections of an element with css' do
      specific_element = test_page.dynamic_locator_css.update_locator(locator: 'id', id: 333333)
      specific_element.location.should == {css: "a[id='link333333']"}
      specific_element.link.should == 'http://google.com/'
    end

    it 'should allow changing the selector to allow for different selections with the same element' do
      specific_element = test_page.dynamic_locator_css.update_locator(locator: 'id', id: 333333)
      specific_element.location.should == {css: "a[id='link333333']"}
      specific_element.link.should == 'http://google.com/'
      specific_element = test_page.dynamic_locator_css.update_locator(locator: 'id', id: 222222)
      specific_element.location.should == {css: "a[id='link222222']"}
      specific_element.link.should == 'http://yahoo.com/'
    end
  end

  describe Selenium::WebDriver::Element do
    it 'should return the correct value of a method defined in WebDriver::Element, but not GenericElement class' do
      test_page.input_button_element.tag_name.should == 'input'
    end

    it 'should throw an WebDriver Element error when using a method not defined in either WebDriver::Element or GenericElement classes' do
      expect { test_page.input_checkbox.clickit_good }.to raise_error(NoMethodError)
    end
  end
end