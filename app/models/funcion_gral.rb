# To change this template, choose Tools | Templates
# and open the template in the editor.
class FuncionGral

  def initialize
    
  end

  def sql_nombre(nombre,limite)
     sql = nil
     nombre = nombre.squish
     i = 0
     nombre = nombre.split(' ')
     nombre.each do |p|
        if i == 0
           # if visible == true AGREGAR !!!!
            # sql = "SELECT * FROM beneficiarios where es_visible = TRUE AND apellido_y_nombre ilike '%#{nombre[0]}%'"
           #else
              sql = "SELECT * FROM beneficiarios where apellido_y_nombre ilike '%#{nombre[0]}%'"
        else
           sql += " AND apellido_y_nombre ilike '%#{nombre[i]}%'"
        end
        i += 1
     end
     sql += " LIMIT #{limite}"
     return sql
  end

  def rellena_con_ceros (long_cadena,valor)
     valor = valor.to_i
     valor = valor.to_s
     total = long_cadena - valor.length.to_i
      case
           when total == 0 then
              resultado = valor
           when total == 1 then
              resultado = "0#{valor}"
           when total > 1  then
              ceros = "0"
              for i in (2 .. total)
                     ceros = ceros + '0'
                     # puts "#{i} #{ceros}"
              end
              resultado = "#{ceros}#{valor}"
         end
      return resultado
  end

 
end
