module CurlFFI
  class Version
    include Comparable

    def initialize(version_info)
      @vstruct = version_info
    end

    def major
      (@vstruct[:version_num] & 0xff0000) >> 16
    end

    def minor
      (@vstruct[:version_num] & 0xff00) >> 8
    end

    def tiny
      @vstruct[:version_num] & 0xff
    end

    # commpare with a string representing a version i.e. '7.12.4'
    def <=>(str)
      [major, minor, tiny] <=> other.to_s.split('.').map { |n| Integer(n) }
    end
  end
end

