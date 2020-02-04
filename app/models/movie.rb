class Movie < ActiveRecord::Base
    
    class << self
        def all_ratings
            # using find and map, can get a hash of all ratings
            # uniq extracts all the unique indexes
            # sort to sort the result of the unique responses
            # code adapted from: 
                # 1. https://stackoverflow.com/questions/21186067/ruby-extracting-the-unique-values-per-key-from-an-array-of-hashes
                # 2. https://guides.rubyonrails.org/active_record_basics.html
                # 3. https://stackoverflow.com/questions/9658881/rails-select-unique-values-from-a-column
            #return self.distinct.pluck(:rating)
            return self.uniq.pluck(:rating)
        end
        
        def selected_ratings
            
            return self.where(:rating => @selected_ratings.keys)
        end
    end
end
