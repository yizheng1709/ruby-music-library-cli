require 'pry'

class Song 
    extend Concerns::Findable 
    attr_accessor :name, :artist, :genre  
    @@all = []

    def initialize(name, artist = nil, genre = nil) #module
        @name = name 
        self.artist = artist 
        self.genre = genre
    end 

    def self.all #module
        @@all
    end 

    def self.destroy_all #module
        self.all.clear
    end 

    def save 
        @@all << self 
    end 

    def self.create(name)
        song = self.new(name)
        song.save   
        song
    end  

    def artist=(artist)
        if artist != nil 
            @artist = artist #this statement doesnt conform with 
            artist.add_song(self) #the logic of add_song
            # binding.pry
        end #technically this wont be added to artist's list of songs
    end 

    def genre=(genre)
        @genre = genre
        if genre!=nil && !genre.songs.include?(self)
            genre.songs << self 
        end 
    end 

    # def self.find_by_name(name_property) 
    #     self.all.find {|song| song.name == name_property}
    # end 
    
    # def self.find_or_create_by_name(name) 
    #     if !self.find_by_name(name)
    #         self.create(name)
    #     else 
    #         self.find_by_name(name)
    #     end 
    # end 

    def self.new_from_filename(filename)
        file = filename.split(" - ")
        artist = file[0]
        name = file[1]
        genre = file[2].gsub(".mp3","")
        genre = Genre.find_or_create_by_name(genre)
        artist = Artist.find_or_create_by_name(artist)
        self.new(name, artist, genre)
    end 

    def self.create_from_filename(filename)
        new_from_filename(filename).tap{ |s| s.save}
    end 
  
end 



