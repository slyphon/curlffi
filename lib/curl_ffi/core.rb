module CurlFFI
  module Core
    module Easy
      include Logger
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

      WRITE_FUNC      = callback([:pointer, :size_t, :size_t, :pointer], :size_t) unless defined?(WRITE_FUNC)
      attach_function :_setwritefunc, :curl_easy_setopt, [ :pointer, :int, WRITE_FUNC ], :int

      @@global_init_done = false     unless defined?(@@global_init_done)
      @@mutex            = Mutex.new unless defined?(@@mutex)

      class CurlHandle < FFI::AutoPointer
        def self.release(ptr)
          CurlFFI::Core::Easy.cleanup(ptr)
        end
      end

      def self.global_init!
        @@mutex.synchronize do
          return if @@global_init_done
          @@global_init_done = true
          assert_zero(_global_init(CURL_GLOBAL_DEFAULT))
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
          assert_zero(_getinfo(handle, const, ptr))
          ptr.__send__(:"read_#{ptr_type}")
        end
      end

      def self.setoptstr(ptr, int, str)
        assert_zero(_setoptstr(ptr, int, str))
        str
      end

      def self.setopt(ptr, int, val)
        assert_zero(_setopt(ptr, int, val))
        val
      end

      def self.setoptlong(ptr, int, long)
        assert_zero(_setoptlong(ptr, int, long))
        long
      end

      def self.setwritefunc(ptr, int, prok)
        assert_zero(_setwritefunc(ptr, int, prok))
        prok
      end

      def self.init
        ptr = self._init
        raise CurlInitFailedError unless ptr
        CurlHandle.new(ptr)
      end

      def self.perform(ptr)
        assert_zero(_perform(ptr))
      end

      def self.duphandle(ptr)
        new_ptr = _duphandle(ptr)
        raise CurlDuphandleFailedError unless new_ptr
        CurlHandle.new(new_ptr)
      end

      protected
        def self.assert_zero(val)
          raise_curl_errno!(val) unless val == 0
          val
        end

        def self.raise_curl_errno!(int)
          $stderr.puts "raising curl errno: #{int}"
          raise CurlFFIError, self.strerror(int)
        end
    end
  end
end

