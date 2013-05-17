module SeleniumFury
  module SeleniumWebDriver
    module PageObjectComponents

      class GenericElement
        include GenericElementHelpers
        include ElementWaitHelpers

        def initialize(locator, driver=nil, opt={})
          @location = locator
          @driver = driver
        end

        attr_accessor :location, :driver
      end

      class CheckboxElement < GenericElement
        include CheckboxElementHelpers
        include SelectableElementHelpers
      end

      class DropDownElement < GenericElement
        include DropDownHelpers
        include SelectableElementHelpers
      end

      class ImageElement < GenericElement
        include ImageElementHelpers
      end

      class LinkElement < GenericElement
        include LinkElementHelpers
        include SelectableElementHelpers
      end

      class RadioButtonElement < GenericElement
        include SelectableElementHelpers
      end

      class SubmitElement < GenericElement
        include SelectableElementHelpers
      end

      class TextElement < GenericElement
      end

      class TextInputElement < GenericElement
        include TextElementHelpers
      end
    end
  end
end