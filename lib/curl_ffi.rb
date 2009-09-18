CURL_FFI_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))
$LOAD_PATH.unshift(File.join(CURL_FFI_ROOT, 'lib')).uniq!

require 'rubygems'
gem 'ffi', '>= 0.3.5'
require 'ffi'

module CurlFFI
  class CurlFFIError < StandardError; end
end

require 'curl_ffi/constants'
require 'curl_ffi/core'

