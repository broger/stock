# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper


 def hacer_menu(usuario, nodo,desplegable,submenu)
    tiene_permiso = usuario.roles.map{|r| r.menus }.flatten.include?(nodo)
    if tiene_permiso
            unless nodo.tooltip.blank?
              fan="class='#{nodo.tooltip}'"
            else
             fan = nil
            end
            


            if desplegable
              if submenu == true             
                  salida = "<li class='dropdown-submenu' style ='border-radius:1px'><a  class='dropdown-toggle' data-toggle='dropdown' href='#{nodo.url}'>#{nodo.nombre} "
              else
                  salida = "<li class='dropdown' style ='border-radius:1px'><a  class='dropdown-toggle' data-toggle='dropdown' href='#{nodo.url}'>#{nodo.nombre} <b class='caret'></b> "
             
              end                           


            else
              salida = "<li style ='border-radius:1px' ><a  href='#{nodo.url}'>#{nodo.nombre} "
            end
            
            salida = salida + "</a>"


 #  if submenu == true
 #                     salida = "<li class='dropdown'><a  class='dropdown-toggle' data-toggle='dropdown' href='#{nodo.url}'>#{nodo.nombre} <b class='caret'></b></a>"
 #               else
 #                  salida =  "<li><a href='#{nodo.url}' #{fan}>#{nodo.nombre}</a>"
#     end


            
            if nodo.children.count != 0 && tiene_permiso
                salida << "<ul class='dropdown-menu' style ='border-radius:1px' role='menu' aria-labelledby='dLabel'>"
                nodo.children.each do |child|
                    if child.children.count != 0
                       salida << hacer_menu(usuario, child,true,true)

                   else
                      salida << hacer_menu(usuario, child,false,false)
                   end
                  
                end
                salida << "</ul>"
            end

      salida <<  "</li>"
  else
    salida = ""
    end
    salida
  end

def hacer_menu_form(rol, nodo)

    #salida =  "<li><a href='#{nodo.url}'>#{nodo.descripcion}</a>"
    salida =  "<li style='list-style-type:none;'>#{check_box_tag('rol[menu_ids][]',nodo.id,rol.menus.include?(nodo))} #{nodo.descripcion}"
    if nodo.children.count != 0
      salida << "<ul>"
      nodo.children.each do |child|
        salida << hacer_menu_form(rol,child)
      end
      salida << "</ul>"
    end

    salida <<  "</li>"

    salida
end

  def hacer_menu_rol(rol, nodo)
    tiene_permiso = rol.menus.include?(nodo)
    if tiene_permiso
    salida =  "<li><a href='#'>#{nodo.descripcion}</a>"

    if nodo.children.count != 0
      salida << "<ul>"
      nodo.children.each do |child|
        salida << hacer_menu_rol(rol, child)
      end
      salida << "</ul>"
    end

    salida <<  "</li>"
  else
    salida=""
  end
    salida
  end

  def image_tag_sexo(sexo_id)
    archivo = 'no_avatar.gif'
    if sexo_id == 1
      archivo = 'user.png'
    elsif sexo_id == 2
      archivo = 'she_user.png'
    end
    image_tag archivo
  end
  def select_meses(parametro,valor)
     meses={1=> 'Enero',2=>'Febrero',3=>'Marzo',4=>'Abril',5=>'Mayo',6=>'Junio',7=>'Julio',8=>'Agosto',9=>'Septiembre',10=>'Octubre',11=>'Noviembre',12=>'Diciembre'}
     select parametro.to_sym, :mes, meses.collect{|a,b| [b,a]}.insert(0,''),:selected => valor
  end
  def select_formatos(parametro,valor)
     formatos={1=> 'pdf',2=>'xls'}
     select parametro.to_sym, :formato, formatos.collect{|a,b| [b,a]},:selected => valor
  end


  def nombredemeses(paramsito)
     meses={1=> 'Enero',2=>'Febrero',3=>'Marzo',4=>'Abril',5=>'Mayo',6=>'Junio',7=>'Julio',8=>'Agosto',9=>'Septiembre',10=>'Octubre',11=>'Noviembre',12=>'Diciembre'}
     meses[paramsito]
  end

  def meses
    [['Enero',1],['Febrero',2],['Marzo',3],['Abril',4],['Mayo',5],['Junio',6],['Julio',7],['Agosto',8],['Septiembre',9],['Octubre',10],['Noviembre',11],['Diciembre',12]]
  end

  def format_fecha(fecha)
    fecha.strftime('%d/%m/%Y') unless fecha.blank?
  end

  def format_hora_utc(hora)
    hora.utc.strftime("%I:%M%p") unless hora.blank?
  end

  def format_fecha_hora_local(fecha_hora)
    fecha_hora.in_time_zone.strftime("%d/%m/%Y--%I:%M%p") unless fecha_hora.blank?
  end

  def format_fecha_hora_utc(fecha_hora)
    fecha_hora.utc.strftime("%d/%m/%Y--%I:%M%p") unless fecha_hora.blank?
  end

  def anionuevenueve(fecha)
#    dosultimos = fecha.slice(6,2)
#    if dosultimos.to_i.between?(0,11)
#      fecha = "#{fecha.slice(0,2)}-#{fecha.slice(3,2)}-20#{dosultimos}"
#    else
#      fecha = "#{fecha.slice(0,2)}-#{fecha.slice(3,2)}-19#{dosultimos}"
#    end
    return fecha
  end

  def errores_lista(lista,separador=".")
   salida="<div style='text-align:left;'>"
   lista_aux=lista.split(separador)
   lista_aux.each { |e| salida << "<div> #{image_tag("16x16/cross.png")}  #{e.to_s} </div>" }
   salida << "</div>"
 end


end
