class Song
    attr_accessor :name, :artist, :genre

    @@all = []

    def initialize(name, artist=nil, genre=nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
        save
    end

    def save
        @@all << self
        self
    end

    def self.all
        @@all.uniq
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(name)
        self.new(name).save
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
      end

    def genre=(genre)
        @genre = genre
        genre.add_song(self) 
    end

    def self.find_by_name(title)
        self.all.find {|song| song.name == title}
    end

    def self.find_or_create_by_name(title)
        if self.find_by_name(title)
            self.find_by_name(title)
        else 
            self.create(title)
        end
    end

    def self.new_from_filename(filename)
        split_name = filename.split(' - ')
        artist_name = split_name[0]
        song_name = split_name[1]
        genre_name = split_name[2].gsub('.mp3', "")

        artist = Artist.find_or_create_by_name(artist_name)
        genre = Genre.find_or_create_by_name(genre_name)

        self.new(song_name, artist, genre)
    end

    def self.create_from_filename(filename)
        new_from_filename(filename).save
    end
end