class Genre
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
        Song.all.select {|song| song.genre == self}
    end

    def add_song(song)
        song.genre = self unless song.genre
    end

    def artists
        artists_array = []

        self.songs.each do |song|
            artists_array << song.artist
        end
        artists_array.uniq
    end
end