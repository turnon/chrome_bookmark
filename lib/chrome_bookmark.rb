require "chrome_bookmark/version"
require "chrome_bookmark/folder"
require "chrome_bookmark/link"

class ChromeBookmark

  attr_reader :path, :stack, :folders, :links

  def initialize path
    @path = path
    @stack, @folders, @links = [], [], []
    stack << TopFolder.new
    parse
  end

  def parse
    File.
      readlines(path).
      each do |line|
        case line
        when Link
          l = Link.new line
          stack[-1] << l
          links << l
        when Folder
          f = Folder.new line
          stack[-1] << f
          stack << f
          folders << f
        when FolderEnd
          stack.pop
        end
      end
  end

  def duplicate_links
    links.group_by do |l|
      l.name
    end.select do |name, links|
      links.count > 1
    end
  end

  def inspect
    "#<#{self.class.name}: #{links.count} links, #{folders.count} folders>"
  end

end
