class Personaje < ApplicationRecord
    validates :nombre, presence:true,length: {minimum:3}
end
