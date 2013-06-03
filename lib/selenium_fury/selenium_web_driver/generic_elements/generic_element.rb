module SeleniumFury
  module SeleniumWebDriver
    module PageObjectComponents

      class GenericElement
        include GenericElementHelpers
        include ElementWaitHelpers

        def initialize(locator, driver=nil, opt={})
          @location = locator
          @driver = driver
          @tags = opt[:tags]
          @validate = opt[:validate] != false  # true if nil
          @wait = 10 || opt[:wait]
        end

        attr_accessor :location, :driver, :tags
        attr_writer :validate

        def validate?
          @validate
        end
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