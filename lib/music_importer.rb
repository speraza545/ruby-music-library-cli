class MusicImporter
    attr_accessor :path

    def initialize(path)
        @path = path
    end

    def files
        @files ||= Dir.glob("#{path}/*.mp3").collect{ |f| f.gsub("#{path}/", "") }
    end

    def import
        files.each do |song|
            Song.create_from_filename(song)
        end
    end

end