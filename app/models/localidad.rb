class Localidad < ActiveRecord::Base
	belongs_to :provincia
  
  
  validates_presence_of :provincia_id, :message => "es un campo Obligatorio."
  validates_presence_of :nombre, :message => 'es obligatorio.'
  validates_length_of :nombre, :in => 3..30, :message => "debe tener entre 3 y 30 caracteres."
  validates_uniqueness_of :nombre, :message => "ya existe."


  cattr_reader :per_page
  @@per_page = 30

end
