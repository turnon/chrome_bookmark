class ChromeBookmark
  class Folder

    attr_reader :children, :name
    attr_accessor :parent

    def self.=== line
      /\s*\<DT\>\<H3/ =~ line
    end

    def initialize line
      @children = []
      @name = line.gsub(/.*>(.*)<\/H3.*/, '\1').chomp
    end

    def << child
      children << child
      child.parent = self
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

  class TopFolder < Folder

    def initialize
      @children = []
      @name = ''
    end

    def whole_path
      ''
    end

    def inspect
      "#<#{self.class.name}:#{whole_path}>"
    end
  end

  class FolderEnd
    def self.=== line
      /\<\/DL\>\<p\>/ =~ line
    end
  end
end
