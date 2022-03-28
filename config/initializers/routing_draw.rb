# frozen_string_literal: true

module ActionDispatch
  module Routing
    class Mapper
      def draw_routes_for(api_version)
        instance_eval(File.read(Rails.root.join("config/routes/#{api_version}.rb")))
      end
    end
  end
end
