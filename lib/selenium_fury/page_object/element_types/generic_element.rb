#/* Copyright (c) 2010 HomeAway, Inc.
# * All rights reserved.  http://www.homeaway.com
# *
# * Licensed under the Apache License, Version 2.0 (the "License");
# * you may not use this file except in compliance with the License.
# * You may obtain a copy of the License at
# *
# *      http://www.apache.org/licenses/LICENSE-2.0
# *
# * Unless required by applicable law or agreed to in writing, software
# * distributed under the License is distributed on an "AS IS" BASIS,
# * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# * See the License for the specific language governing permissions and
# * limitations under the License.
# */
module SeleniumFury
  module PageObject
    module ElementTypes
      class GenericElement
        include ElementHelpers::GenericElementHelper
        include ElementHelpers::WaitElementHelper

        def initialize(locator, driver=nil, opt={})
          @original_location = locator.freeze
          @location = Marshal.load(Marshal.dump(@original_location))
          @driver = driver
          @tags = opt[:tags]
          # Should validate if opt[:validate] is nil, should not validate if doing dynamic matchin
          @validate = opt[:validate] != false && !locator.values.first.match(/__/)
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
      end # GenericElement
    end # ElementTypes
  end # PageObject
end # SeleniumFury