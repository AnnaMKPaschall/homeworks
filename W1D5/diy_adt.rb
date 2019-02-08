class Stack 
    def initialize 
        @stack = []
    end 

    def push(el)
        self.push(el)
    end 

    def pop
        self.pop
    end 

    def peek 
        self.last
    end
end 



class Queue 
    def enqueue(el)
        self.push
    end 

    def dequeue
        self.shift
    end 

    def peek 
        self[0]
    end 
end 

p [1, 2, 3, 4].enqueue(5)

class Map 
    def set(key, value)
        map_array = []
        self[key] = value 
    end 

    def get(key)
        self.find(key)
    end 
    
    def delete(key)
        self.delete(key)
    end 

    def show 
        self[]
    end 

end 