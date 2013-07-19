module Webhookr
  module Stripe
    module Generators

      class ExampleHooksGenerator < Rails::Generators::Base
        EXAMPLE_HOOK_FILE = 'app/models/stripe_hooks.rb'
        source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

        desc "Creates an example Stripe hook file: '#{EXAMPLE_HOOK_FILE}'"
        def example_hooks
          copy_file( "stripe_hooks.rb", EXAMPLE_HOOK_FILE)
        end
      end

    end
  end
end
