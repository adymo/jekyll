module Jekyll
  module Converters
    class MediaWiki < Converter
      safe true

      pygments_prefix '<nowiki>'
      pygments_suffix '</nowiki>'

      def setup
        return if @setup
        require 'mediacloth'
        @setup = true
      rescue LoadError
        STDERR.puts 'You are missing a library required for MediaWiki. Please run:'
        STDERR.puts '  $ [sudo] gem install mediacloth'
        raise FatalException.new("Missing dependency: mediacloth")
      end

      def matches(ext)
        rgx = '(' + @config['mediawiki_ext'].gsub(',','|') +')'
        ext =~ Regexp.new(rgx, Regexp::IGNORECASE)
      end

      def output_ext(ext)
        ".html"
      end

      def convert(content)
        setup
        MediaCloth.wiki_to_html(content)
      end
    end
  end
end
