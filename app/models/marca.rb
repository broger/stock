class Marca < ActiveRecord::Base
 
  belongs_to :rubro
  
  validates_presence_of :nombre, :message => 'es obligatorio.'
  validates_uniqueness_of :nombre,:message => "ya existe"
	validates_length_of :nombre, :in => 3..30, :message => "debe tener al menos 3 caracteres"
  
  cattr_reader :per_page
  @@per_page = 30

end
