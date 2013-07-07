module SeleniumFury
  module SeleniumWebDriver
    module PageObjectComponents

      class GenericElement
        include GenericElementHelpers
        include ElementWaitHelpers

        def initialize(locator, driver=nil, opt={})
          @original_location = locator.freeze
          @location = Marshal.load(Marshal.dump(@original_location))
          @driver = driver
          @tags = opt[:tags]
          # Should validate if opt[:validate] is nil, should not validate if doing dynamic matchin
          @validate = opt[:validate] != false  && !locator.values.first.match(/__/)
          # This is different from implicit_wait. This explicitly waits for this element, not for entire driver session.
          @wait = 10 || opt[:wait]
        end

        attr_accessor :location, :driver, :tags, :wait, :implicit_wait
        attr_writer :validate

        def validate?
          @validate
        end

        def update_locator(variables)
          locator = Marshal.load(Marshal.dump(@original_location))
          variables.each { |key, value| locator.first[1].gsub! ('__' + key.to_s.upcase + '__'), value.to_s }
          @location = locator
          self
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

      class SelectableElement < GenericElement
        include SelectableElementHelpers
      end
    end
  end
end