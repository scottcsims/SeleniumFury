require "spec_helper"
describe TestPageCustomGeneratorConfiguration do

  it "should generate the test page link locators" do
    create_selenium_driver TEST_PAGE_URL
    browser.start_new_browser_session
    puts "Testing #{browser.browser_url} on #{browser.browser_string} "
    browser.open TEST_PAGE_URL
    test_page_custom_generator_configuration = TestPageCustomGeneratorConfiguration.new
    result = custom_generator(:browser => browser,
                     :custom_configuration => test_page_custom_generator_configuration)
    result.should == custom_generator_result
  end
  let(:custom_generator_result){
<<EOF
found (3 elements)
class YourPageFile
	def initialize *browser
		@browser = *browser
		@link_1 = "link111111"
		@link_2 = "link222222"
		@link_3 = "link333333"
	end
	attr_accessor :browser, :link_1, :link_2, :link_3

end
EOF
}
end
