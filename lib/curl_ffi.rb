CURL_FFI_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))
$LOAD_PATH.unshift(File.join(CURL_FFI_ROOT, 'lib')).uniq!

require 'rubygems'
gem 'ffi', '>= 0.5.0'
require 'ffi'
require 'logger'

module CurlFFI
  @@logger = nil unless defined?(@@logger)

  def self.logger
    @@logger
  end

  def self.logger=(v)
    @@logger = v
  end

  class CurlFFIError < StandardError; end

  class CurlInitFailedError < CurlFFIError
    def initialize
      super("curl_easy_init returned NULL, something went *really* wrong")
    end
  end

  class CurlDuphandleFailedError < CurlFFIError
    def initialize
      super("curl_easy_duphandle returned NULL, something went *really* wrong")
    end
  end
end

require 'curl_ffi/logger'
require 'curl_ffi/version'
require 'curl_ffi/constants'
require 'curl_ffi/core'
require 'curl_ffi/easy'

CurlFFI.logger = Logger.new($stderr)
CurlFFI.logger.progname = 'curl_ffi'
CurlFFI.logger.level = Logger::DEBUG

