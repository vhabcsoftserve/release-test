require 'yaml'

module Constants
  LOCAL_SETTINGS_FILENAME = 'settings.local.yaml'.freeze
  LOCAL_SETTINGS = File.exist?(LOCAL_SETTINGS_FILENAME) ? YAML.load_file(LOCAL_SETTINGS_FILENAME) : {}
  RELEASE_TYPES = %w[major minor patch].freeze
end
