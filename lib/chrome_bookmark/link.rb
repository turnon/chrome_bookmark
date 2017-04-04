class ChromeBookmark
  class Link

    attr_reader :name
    attr_accessor :parent

    def self.=== line
      /\s*\<DT\>\<A/ =~ line
    end

    def initialize line
      @name = line.gsub(/.*>(.*)<\/A.*/, '\1').chomp
    end

    def whole_path
      "#{parent.whole_path}/#{self}"
    end

    def to_s
      name
    end

    def inspect
      "#<#{self.class.name}:#{whole_path}>"
    end
  end
end
