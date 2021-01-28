class MusicImporter  
    attr_accessor :path 
    def initialize(path)
        self.path = path 
    end 

    def files
        array = Dir.entries(@path)
        array = array.select {|file| file.end_with?("mp3")}
    end 

    def import
        self.files.each {|file| Song.create_from_filename(file)}
    end 
end 