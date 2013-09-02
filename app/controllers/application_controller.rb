# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  include AuthenticatedSystem

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :session_expiry, :except => [:login, :logout]
  before_filter :update_activity_time, :except => [:login, :logout]


  def session_expiry
    unless session[:expires_at].nil?
      @time_left = (session[:expires_at] - Time.now).to_i
      unless @time_left > 0
        logout_killing_session!
        flash[:error] = 'La session ha expirado.'
        redirect_to login_url
      end
    end
  end

  def update_activity_time
    session[:expires_at] = 6.hours.from_now
  end



  # Busqueda optimizada por campo nombre o descripcion.

  def sql_descripcion(tabla,campo,txtbuscar,limite,visible,filtros)
     sql = nil
     txtbuscar = txtbuscar.squish
     i = 0
     nombre = txtbuscar.split(' ')
     nombre.each do |p|
        if i == 0
                  if visible == true
                      sql = "SELECT * FROM #{tabla} where es_visible = TRUE AND #{campo} ilike '%#{nombre[0]}%'"
                  else
                      sql = "SELECT * FROM #{tabla} where #{campo} ilike '%#{nombre[0]}%'"
                  end
        else
           sql += " AND #{campo} ilike '%#{nombre[i]}%'"
        end
        i += 1
     end
     sql += " #{filtros} LIMIT #{limite}"
     return sql
  end


  def sql_descripcion_con_orden(tabla,campo,txtbuscar,limite,visible,campo_orden,tipo_orden)
     sql = nil
     txtbuscar = txtbuscar.squish
     i = 0
     nombre = txtbuscar.split(' ')
     nombre.each do |p|
        if i == 0
            if visible == true
               sql = "SELECT * FROM #{tabla} where es_visible = TRUE AND #{campo} ilike '%#{nombre[0]}%'"
            else
               sql = "SELECT * FROM #{tabla} where #{campo} ilike '%#{nombre[0]}%'"
            end
        else
           sql += " AND #{campo} ilike '%#{nombre[i]}%'"
        end
        i += 1
     end
     unless campo_orden.blank?
        sql += " ORDER BY #{campo_orden} #{tipo_orden}"
     end
     sql += " LIMIT #{limite}"
     return sql
  end

  


  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
end
