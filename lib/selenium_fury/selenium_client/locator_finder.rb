module SeleniumFury
  module SeleniumClient
    class LocatorFinder
      def initialize (nokogiri_elements)
        @nokogiri_elements=nokogiri_elements
        @valid_locators=["id", "name", "title"]
      end

      attr_reader :nokogiri_elements, :valid_locators

      def find_locators
        locators=[]
        nokogiri_elements.each do |nokogiri_element|
          valid_locators.each do |valid_locator|
            if nokogiri_element.get_attribute(valid_locator) != nil
              locators.push(nokogiri_element.get_attribute(valid_locator))
              break
            end
          end
        end
        return locators
      end

      def page_object_attributes
        locators=find_locators

        object_attributes ={}
        locators.each do |locator|
          name=attribute_name(locator)
          object_attributes[name] = locator
        end
        return object_attributes
      end

      def attribute_name name
        if !name.nil?
          name.gsub!('input-', '')
          name.gsub!('select-', '')
          name.gsub!(/([A-Z]+)/, '_\1')
          name.gsub!('\\', '')
          name.gsub!(' ', '_')
          name.gsub!('.', '_')
          name.gsub!('-', '_')
          name.gsub!('__', '_')
          name = name.to_s.downcase
        end
        return name
      end
    end
  end
end