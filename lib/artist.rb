class Artist
    extend Concerns::Findable
    attr_accessor :name

    @@all = []

    def initialize(name)
        @name = name
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
        new(name).save
    end

    def songs
        Song.all.select {|song| song.artist == self}
    end

    def add_song(song)
        song.artist = self unless song.artist
    end

    def genres
        genre_array = []
        self.songs.each do |song|
            genre_array << song.genre
        end
        genre_array.uniq
    end
end