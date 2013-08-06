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

require 'monitor'
require 'singleton'

# So this was mocked out from the Repository class in Log4r
# It's writen with syncs because at some point we might care about
# multi-threaded things; and this not exploding.
# You're welcome? - Alan Scherger
module SeleniumFury
  module Utilities
    class DriverCollection
      extend MonitorMixin
      include Singleton
      attr_reader :drivers

      def initialize
        @drivers = Hash.new
      end

      class << self
        def [](name)
          self.synchronize do
            instance.drivers[name]
          end # exclusive
        end

        def []=(name, driver)
          self.synchronize do
            instance.drivers[name] = driver
          end # exclusive
        end

        def has_tag?(tag)
          self.synchronize do
            instance.drivers.has_key?(tag)
          end
        end

        def tags
          self.synchronize do
            instance.drivers.keys
          end
        end

        def delete(tag)
          self.synchronize do
            instance.drivers.delete(tag)
          end
        end

        def all
          self.synchronize do
            instance.drivers
          end
        end
      end # class << self
    end # DriverCollection
  end # Utilities
end # SeleniumFury
