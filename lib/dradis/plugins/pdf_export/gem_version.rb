module Dradis
  module Plugins
    module PdfExport
      # Returns the version of the currently loaded Frontend as a <tt>Gem::Version</tt>
      def self.gem_version
        Gem::Version.new VERSION::STRING
      end

      module VERSION
        MAJOR = 4
        MINOR = 9
        TINY = 0
        PRE = nil

        STRING = [MAJOR, MINOR, TINY, PRE].compact.join(".")
      end
    end
  end
end
