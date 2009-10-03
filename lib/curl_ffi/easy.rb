module CurlFFI
  class Easy
    include Logger
    include Constants
    include Core

    BODY_BUF_SIZE = 32 * 1024  #:nodoc:
    HEADER_BUF_SIZE = BODY_BUF_SIZE

    attr_reader :interface, :url, :header_str, :body_str

    DEFAULT_WRITE_HANDLER = FFI::Function.new(:size_t, [:pointer, :size_t, :size_t, :pointer]) do |ptr,size,nmemb,stream|
      p [ptr,size,nmemb,stream]
      size * nmemb
    end unless defined?(DEFAULT_WRITE_HANDLER)

    def initialize(url=nil)
      @url = url
      @easy = Core::Easy.init
      
      Core::Easy.setoptlong(@easy, CURLOPT_NOSIGNAL, 1)
      
      @interface = nil

      @body_str, @header_str = '', ''

      @body_proc_wrapper = @header_proc_wrapper = nil

      @body_proc = default_data_handler(@body_str)
      Core::Easy.setopt(@easy, CURLOPT_WRITEFUNCTION, @body_proc)  

      @header_proc = default_data_handler(@header_str)
      Core::Easy.setopt(@easy, CURLOPT_HEADERFUNCTION, @header_proc)  
    end

    def url=(str)
      logger.debug "set url to #{str}"
      @url = str.dup.freeze
      @url_mem_ptr = FFI::MemoryPointer.from_string(str)      # h/t wmeissner
      Core::Easy.setopt(@easy, CURLOPT_URL, @url_mem_ptr)
    end

    def interface=(str)
      logger.debug "set interface to #{str}"
      @interface = str.dup.freeze
      @interface_mem_ptr = FFI::MemoryPointer.from_string(str)
      Core::Easy.setopt(@easy, CURLOPT_INTERFACE, @interface)
    end

    def on_body(&block)
      orig_blk, @body_proc = @body_proc, block.to_proc
      @body_proc_wrapper = data_proc_wrapper(@body_proc)
      Core::Easy.setopt(@easy, CURLOPT_WRITEFUNCTION, @body_proc_wrapper)
      orig_blk
    end

    def on_header(&block)
      orig_blk, @header_proc = @header_proc, block.to_proc
      @header_proc_wrapper = data_proc_wrapper(@header_proc)
      Core::Easy.setopt(@easy, CURLOPT_HEADERFUNCTION, @header_proc_wrapper)
      orig_blk
    end

    def perform
      logger.debug "calling perform"
      Core::Easy.perform(@easy)
    end

    #--
    # informational methods
    #++

    def connect_time
      getinfo(CURLINFO_CONNECT_TIME, :double).to_f
    end

    def content_type
      getinfo(CURLINFO_CONTENT_TYPE, :string)
    end

    def response_code
      getinfo(CURLINFO_RESPONSE_CODE, :long)
    end

    # 7.9.7
    def redirect_count
      getinfo(CURLINFO_REDIRECT_COUNT, :long)
    end
    
    # 7.9.7
    def redirect_time
      getinfo(CURLINFO_REDIRECT_TIME, :double).to_f
    end

    # 7.18.2
    # not supported yet
    def redirect_url
      nil
    end

    def last_effective_url
      getinfo(CURLINFO_EFFECTIVE_URL, :string)
    end

    def pre_transfer_time
      getinfo(CURLINFO_PRETRANSFER_TIME, :double).to_f
    end

    def start_transfer_time
      getinfo(CURLINFO_STARTTRANSFER_TIME, :double).to_f
    end

    def uploaded_bytes
      getinfo(CURLINFO_SIZE_UPLOAD, :double).to_f
    end

    def downloaded_bytes
      getinfo(CURLINFO_SIZE_DOWNLOAD, :double).to_f
    end

    def upload_speed
      getinfo(CURLINFO_SPEED_UPLOAD, :double).to_f
    end

    def download_speed
      getinfo(CURLINFO_SPEED_DOWNLOAD, :double).to_f
    end

    def header_size
      getinfo(CURLINFO_HEADER_SIZE, :long).to_i
    end

    def request_size
      getinfo(CURLINFO_REQUEST_SIZE, :long).to_i
    end

    def uploaded_content_length
      getinfo(CURLINFO_CONTENT_LENGTH_UPLOAD, :double).to_f
    end

    protected
      def getinfo(const, ptr_type)
        Core::Easy.getinfo(@easy, const, ptr_type)
      end

      def create_curl_data_callback(&block)
        FFI::Function.new(:size_t, [:pointer, :size_t, :size_t, :pointer], &block)
      end

      def progress_proc_wrapper(prok)
        FFI::Function.new(:size_t, [:pointer, :double, :double, :double, :double]) do |_,dl_total,dl_now,ul_total,ul_now|
          prok.call(dl_total,dl_now,ul_total,ul_now) ? 0 : 1
        end
      end

      def data_proc_wrapper(prok)
        create_curl_data_callback do |ptr,size,nmemb,stream|
          rval = prok.call(ptr.get_string(0, size*nmemb))

          unless rval
            warn("Curl data handlers should return the number of bytes read as an Integer")
            rval = (size * nmemb)
          end

          rval
        end
      end

      def default_data_handler(sink)
        p = lambda do |data|
          sink << data
          data.length
        end

        data_proc_wrapper(p)
      end
  end
end

