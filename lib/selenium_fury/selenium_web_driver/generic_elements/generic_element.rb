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
          # Should validate if opt[:validate] is nil, should not validate if doing dynamic matchin
          @validate = opt[:validate] != false  && !locator.values.first.match(/\^([^=].*?)\$/)
          # Since SeFury doesn't initiate a session,
          #   and there is no way to ask the driver what the implicit wait is set to,
          #   if an implicit wait is desired, it will need to get passed in somehow.
          # Figure out a better way than requiring it on every definition or initialization
          # This should be the same for entire driver session, not updated with every element
          @implicit_wait = 0 || opt[:implicit_wait]
          # This is element specific, implicit_wait should be for entire driver session
          @wait = 10 || opt[:wait]
        end

        attr_accessor :location, :driver, :tags, :wait, :implicit_wait
        attr_writer :validate

        def validate?
          @validate
        end

        def update_locator(variables)
          locator_value = @location.values.first
          variables.each { |key, value|
            locator_value.scan(/\^([^=]\w*)\$/).flatten.each { |match|
              locator_value.gsub!("^#{match}$", value.to_s) if match == key.to_s
            }
          }
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