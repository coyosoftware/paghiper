module Paghiper
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __dir__)
      desc 'Creates the PagHiper initializer'

      def copy_initializer
        template 'paghiper.rb', 'config/initializers/paghiper.rb'
      end
    end
  end
end
