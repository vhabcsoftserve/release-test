#!/usr/bin/env ruby

require 'yaml'
require 'workato-connector-sdk'

class Decryptor
  attr_reader :key_path, :encrypted_file_path, :encrypted_config

  def initialize(path:, options: {})
    @encrypted_file_path = path
    @key_path = options[:key] || Workato::Connector::Sdk::DEFAULT_MASTER_KEY_PATH
    @encrypted_config ||= ActiveSupport::EncryptedConfiguration.new(
      config_path: encrypted_file_path,
      key_path: @key_path,
      env_key: Workato::Connector::Sdk::DEFAULT_MASTER_KEY_ENV,
      raise_if_missing_key: false
    )
  end

  def self.decrypt(path: Workato::Connector::Sdk::DEFAULT_ENCRYPTED_SETTINGS_PATH, options: {})
    decryptor = new(path: path, options: options)

    raise 'Key not found' if decryptor.encrypted_config.key.blank?

    begin
      YAML.safe_load(decryptor.encrypted_config.read)
    rescue ActiveSupport::MessageEncryptor::InvalidMessage => e
      puts "Couldn't decrypt #{decryptor.encrypted_file_path}."
      puts e.message
    end
  end
end
