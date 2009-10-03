module CurlFFI
  module Logger
    def self.logger
      @_logger ||= CurlFFI.logger
    end

    def logger
      @_logger ||= CurlFFI.logger
    end
  end
end

