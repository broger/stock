class Rubro < ActiveRecord::Base
  has_many :secciones
  has_many :categorias
  has_many :marcas

  validates_presence_of :nombre, :message => 'es obligatorio.'
  validates_uniqueness_of :nombre,:message => "ya existe"
  validates_length_of :nombre, :in => 3..30, :message => "debe tener al menos 3 caracteres"

end
