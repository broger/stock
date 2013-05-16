class Rol < ActiveRecord::Base

  has_many :menus_roles, :class_name => 'MenusRol'
  
  has_many :menus, :through => :menus_roles do |m|
    def roots
      find :all, :conditions => {:parent_id => nil}
    end
  end

  has_many :roles_users, :class_name => 'RolesUser'
  has_many :users, :through => :roles_users

  validates_presence_of :nombre, :message => "es obligatorio"
  validates_uniqueness_of :nombre,:message => "ya existe"
  validates_length_of :nombre, :in => 3..60, :message => "debe tener al menos 3 caracteres"

  #auditoria
  #acts_as_audited
  #has_many :audits, :as => :auditable

  #deleted_at baja logica
  #acts_as_paranoid



end
