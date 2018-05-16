gem "smusher", ">= 0.4.0"
require "smusher"

require "reduce/version"

module Reduce
  class << self
    def reduce(file, options = {})
      extension = File.extname(file).downcase.sub('.','')
      case extension
        # when 'html', 'xml'
          # compressor = File.join(File.dirname(__FILE__),'..','vendor','htmlcompressor*.jar')
          # `java -jar #{compressor} --type #{extension} --compress-js --compress-css --js-compressor closure #{file}`
        when 'html'
          doc = Nokogiri::XML.parse(File.read(file), options)
          doc.to_xml(indent: 0)
        when 'xml'
          doc = Nokogiri::HTML.parse(File.read(file), options)
          doc.to_html(indent: 0)
        when 'js'
          compressor = File.join(File.dirname(__FILE__),'..','vendor','compiler.jar')
          # `java -jar #{compressor} --js #{file}`
          Uglifier.compile(File.read(file), {
            output: { comments: :copyright },
            compress: options.reverse_merge({
              ie8: false,
              reduce_vars: true,
              passes: 3
            })
          })
        when 'css'
          # compressor = File.join(File.dirname(__FILE__),'..','vendor','yuicompressor*.jar')
          # `java -jar #{compressor} --type #{extension} #{file}`
          Sass.compile(File.read(file),
            options.reverse_merge({
              syntax: :scss,
              style: :compressed,
              cache: false
            })
          )
        when 'jpg', 'jpeg', 'png', 'gif'
          reduce_image file
        else
          raise "reduce does not know how to handle a .#{extension} file (#{file})"
        end
      end

    private

    def reduce_image(input)
      output = input+'.temp'
      FileUtils.cp(input, output)

      service = (input.downcase =~ /\.gif$/ ? 'PunyPng' : 'SmushIt')
      Smusher.optimize_image(output, :quiet=>true, :service => service)

      data = File.read(output)
      FileUtils.rm(output)
      data
    end
  end
end
