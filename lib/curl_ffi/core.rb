module CurlFFI
  module Core
    module Easy
      include Constants
      extend FFI::Library

      ffi_lib "curl"

      attach_function :cleanup,       :curl_easy_cleanup,   [:pointer], :void
      attach_function :strerror,      :curl_easy_strerror,  [:int],     :string

      attach_function :_global_init,  :curl_global_init,    [:long],    :int
      attach_function :_init,         :curl_easy_init,      [],         :pointer
      attach_function :_perform,      :curl_easy_perform,   [:pointer], :int

      attach_function :_setopt,       :curl_easy_setopt,    [:pointer, :int, :pointer], :int
      attach_function :_setoptstr,    :curl_easy_setopt,    [:pointer, :int, :string],  :int
      attach_function :_setoptlong,   :curl_easy_setopt,    [:pointer, :int, :long],    :int

      attach_function :_getinfo,      :curl_easy_getinfo,   [:pointer, :int, :pointer], :int

      attach_function :_duphandle,    :curl_easy_duphandle, [:pointer], :pointer
      attach_function :reset,         :curl_easy_reset,     [:pointer], :void

#       callback :default_data_handler_callback, [:string, :ulong, :ulong, 
        

      @@global_init_done = false     unless defined?(@@global_init_done)
      @@mutex            = Mutex.new unless defined?(@@mutex)

      def self.global_init!
        @@mutex.synchronize do
          return if @@global_init_done
          @@global_init_done = true
          check_zero { _global_init(CURL_GLOBAL_DEFAULT) }
        end
      end

      def self.with_handle
        handle = init()
        setoptlong(handle, CURLOPT_NOSIGNAL, 1)
        yield handle
      ensure
        cleanup(handle) if handle
      end

      def self.response_code(handle)
        getinfo(handle, CURLINFO_RESPONSE_CODE, :long)
      end

      def self.getinfo(handle, const, ptr_type)
        FFI::MemoryPointer.new(ptr_type.to_sym) do |ptr|
          check_zero { _getinfo(handle, const, ptr) }
          ptr.__send__(:"read_#{ptr_type}")
        end
      end

      def self.setoptstr(ptr, int, str)
        check_zero { _setoptstr(ptr, int, str) }
        str
      end

      def self.setopt(ptr, int, val)
        check_zero { _setopt(ptr, int, val) }
        val
      end

      def self.setoptlong(ptr, int, long)
        check_zero { _setoptlong(ptr, int, long) }
        long
      end

      def self.init
        check_non_null { _init }
      end

      def self.perform(ptr)
        check_zero { _perform(ptr) }
      end

      def self.duphandle(ptr)
        check_non_null { _duphandle(ptr) }
      end

      protected
        def self.check_zero
          rval = yield
          raise_curl_errno! unless rval == 0
          rval
        end

        def self.check_non_null
          yield or raise_curl_errno!
        end

        def self.raise_curl_errno!
          raise CurlFfiError, self.strerror
        end
    end
  end
end

