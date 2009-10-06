
module DataMapper
  class Pager
    
    attr_reader :total 
    attr_reader :per_page 
    attr_reader :current_page 
    
    def initialize options = {}
      @total = options.delete :total
      @per_page = options.delete :limit
      @current_page = options.delete :current_page
    end
  end
end