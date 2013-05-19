class MarcasRubro < ActiveRecord::Base
   belongs_to :marca
   belongs_to :rol
end
