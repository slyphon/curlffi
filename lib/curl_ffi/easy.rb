module CurlFfi
  class Easy
    include Constants
    include Core

    BODY_BUF_SIZE = 32 * 1024  #:nodoc:

    DEFAULT_DATA_HANDLER = lambda do |stream,size,nmemb,out|

      size * nmemb
    end

    attr_reader :interface, :url

    class << self
      def _finalize(inst) #:nodoc:
        inst.finalize!
      end
    end

    def initialize(url=nil)
      @url = url
      @handle = Core::Easy.init
      
      Core::Easy.setoptlong(@handle, CURLOPT_NOSIGNAL, 1)
      
      ObjectSpace.define_finalizer(self, self.class.method(:_finalize).to_proc)

      @interface = nil
      @body_buf = FFI::MemoryPointer.new(:buffer_in, BODY_BUF_SIZE)
    end

    def url=(str)
      @url = str.dup.freeze
      Easy.setoptstr(@handle, CURLOPT_URL, @url)
    end

    def interface=(str)
      @interface = str.dup.freeze
      Easy.setoptstr(@easy, CURLOPT_INTERFACE, @interface)
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

    def finalize! #:nodoc:
      CurlFfi::Core::Easy.cleanup(@handle)
      @body_buf.free if @body_buf 
    end

    protected
      def getinfo(const, ptr_type)
        Easy.getinfo(@handle, const, ptr_type)
      end
  end
end

