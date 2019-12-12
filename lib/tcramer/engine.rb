# frozen_string_literal: true

require 'rails'

module Tcramer
  # Vroom, vrooooooom!
  class Engine < Rails::Engine
    isolate_namespace Tcramer
  end
end
