class Producto < ActiveRecord::Base
	belongs_to :marca
	belongs_to :rubro
	belongs_to :seccion
    belongs_to :categoria
    belongs_to :proveedor
	belongs_to :unidad
    belongs_to :estado
    has_many :producto_lista_precios
	has_many :producto_stocks


	validates_presence_of :nombre, :message => 'es obligatorio.'
	validates_uniqueness_of :codigo,:message => "ya existe"
    validates_uniqueness_of :nombre,:message => "ya existe"
    validates_length_of :nombre, :in => 3..60, :message => "debe tener al menos 3 caracteres"

	validates_presence_of :marca_id, :message => 'es obligatorio.'
	validates_presence_of :marca_id, :message => 'es obligatorio.'
	validates_presence_of :categoria_id, :message => 'es obligatorio.'
	validates_presence_of :unidad_id, :message => 'es obligatorio.'


end
