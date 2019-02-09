module Madmin
  class Engine < ::Rails::Engine
    isolate_namespace Madmin

    config.to_prepare do
      Dir.glob("#{Rails.root}/app/madmin/**/*.rb").each { |r| require_dependency(r) }
    end
  end
end
