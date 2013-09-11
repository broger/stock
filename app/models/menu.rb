class Menu < ActiveRecord::Base


  acts_as_list  :scope => :parent_id # ORDENO EL MENU POR PARENT_ID
  acts_as_tree  :order => "posicion"
  
  has_many :menus_roles, :class_name => 'MenuRol'
  has_many :roles, :through => :menus_roles

  validates_presence_of :nombre, :message => 'es obligatorio.'

  cattr_reader :per_page
  @@per_page = 30


end
