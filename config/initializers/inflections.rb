# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format 
# (all these examples are active by default):
ActiveSupport::Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
    inflect.irregular 'localidad','localidades'
    inflect.irregular 'rol','roles'
    inflect.irregular 'roles_user','roles_users'
    inflect.irregular 'menu','menus'
    inflect.irregular 'menus_rol','menus_roles'
    inflect.irregular 'unidad','unidades'
	inflect.irregular 'proveedor','proveedores'
    inflect.irregular 'seccion','secciones'
    inflect.irregular 'parametro','parametros'
    inflect.irregular 'cliente','clientes'
    inflect.irregular 'producto_lista_precio','producto_lista_precios'
    
    
    


end
