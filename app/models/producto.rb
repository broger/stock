class Producto < ActiveRecord::Base
	belongs_to :marca
	belongs_to :rubro
	belongs_to :seccion
  belongs_to :categoria
  belongs_to :proveedor
	belongs_to :deposito
	belongs_to :unidad
	belongs_to :moneda

	validates_presence_of :nombre, :message => 'es obligatorio.'
  validates_uniqueness_of :nombre,:message => "ya existe"
  validates_length_of :nombre, :in => 3..60, :message => "debe tener al menos 3 caracteres"

	validates_presence_of :marca_id, :message => 'es obligatorio.'
	validates_presence_of :marca_id, :message => 'es obligatorio.'
	validates_presence_of :categoria_id, :message => 'es obligatorio.'
#	validates_presence_of :subcategoria_id, :message => 'es obligatorio.'
	validates_presence_of :deposito_id, :message => 'es obligatorio.'
	validates_presence_of :unidad_id, :message => 'es obligatorio.'
	validates_presence_of :moneda_id, :message => 'es obligatorio.'


end
