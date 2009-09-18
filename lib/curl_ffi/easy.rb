module CurlFfi
  class Easy
    include Constants

    def initialize(url=nil)
      @url = url
      @handle = Core::Easy.init
      
      Core::Easy.setoptlong(@handle, CURLOPT_NOSIGNAL, 1)
      
      # assign to an ivar so that the proc doesn't get gc'd
      @_finalizer = lambda { |ptr| Core::Easy.cleanup(@handle) }
      ObjectSpace.define_finalizer(self, @_finalizer)
    end


    def url=(str)
      Core::Easy.setoptstr(@handle, CURLOPT_URL, str)
    end

    def url
      @url 
    end

  end
end

