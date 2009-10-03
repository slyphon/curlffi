module CurlFfi
  class Easy
    include Constants
    include Core

    BODY_BUF_SIZE = 32 * 1024  #:nodoc:
    HEADER_BUF_SIZE = BODY_BUF_SIZE

    DEFAULT_DATA_HANDLER = lambda do |stream,size,nmemb,out|

      size * nmemb
    end

    attr_reader :interface, :url, :header_str, :body_str

    class << self
      def _finalize(inst) #:nodoc:
        inst.finalize!
      end
    end

    def initialize(url=nil)
      @url = url
      @handle = Core::Easy.init
      
      Core::Easy.setoptlong(@handle, CURLOPT_NOSIGNAL, 1)
      
      @interface = nil
      @body_buf = FFI::MemoryPointer.new(:buffer_in, BODY_BUF_SIZE)
      @body_str = ''

      @header_buf = FFI::MemoryPointer.new(:buffer_in, HEADER_BUF_SIZE)
      @header_str = ''

      on_body(&default_data_handler(@body_str, @body_buf))
      on_header(&default_data_handler(@header_str, @header_buf))
    end

    def url=(str)
      @url = str.dup.freeze
      @url_mem_ptr = MemoryPointer.from_string(str)      # h/t wmeissner
      Easy.setoptstr(@handle, CURLOPT_URL, @url_mem_ptr)
    end

    def interface=(str)
      @interface = str.dup.freeze
      @interface_mem_ptr = MemoryPointer.from_string(str)
      Easy.setoptstr(@easy, CURLOPT_INTERFACE, @interface)
    end

    def on_body(&block)
      orig_blk, @body_proc = @body_proc, block
      Easy.setwritefunc(@easy, CURLOPT_WRITEFUNCTION, @body_proc)
      orig_blk
    end

    def on_header(&block)
      orig_blk, @header_proc = @header_proc, block
      Easy.setwritefunc(@easy, CURLOPT_HEADERFUNCTION, @header_proc)
      orig_blk
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
        Easy.getinfo(@handle, const, ptr_type)
      end

      def default_data_handler(sink, buffer)
        lambda do |_,size,nmemb,_|
          rval = size * nmemb
          sink << buffer.get_string(0, rval)
          rval
        end
      end
  end
end

