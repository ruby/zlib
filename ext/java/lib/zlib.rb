# frozen_string_literal: true

require 'zlib.jar'
require 'zlib/versions'

require 'jar-dependencies'
require_jar('org.jruby', 'jzlib', Zlib::JZLIB_VERSION)

JRuby::Util.load_ext('org.jruby.ext.zlib.ZlibLibrary')

module Zlib
  autoload :StringIO, 'stringio'

  def self.gzip(src, opts = nil)
    if Hash === opts
      level = opts[:level]
      strategy = opts[:strategy]
    end
    io = StringIO.new("".b)
    GzipWriter.new(io, level, strategy) do |writer|
      writer.write(src)
    end
    io.string
  end

  def self.gunzip(src)
    io = StringIO.new(src)
    reader = GzipReader.new(io)
    result = reader.read
    reader.close
    result
  end
end
