class LRUCache 
    def initialize
        @list = []
        @size = size  #expresses the size of cache 
    end 

    def count 
        @list.length 
    end 

    def add(el)
        #if cache includes el, delete and add to end 
        #if cache doesn't include el, add and take off last element 
        if list.include?(el)
            list.delete(el)
            list << el
        elsif count >= @size 
            list.shift 
            list << el 
        else 
            list << el             
        end 
    end 

    def show 
        p list 
        
    end 

    private 

end 