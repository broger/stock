############################# RUBY  ############################################

def validar_fecha(fecha,cant_digitos)
    begin
    if fecha.nil? || fecha.blank?
		  return  nil
    else
          if fecha == '00000000' || "#{fecha}".to_s == "00000000" || fecha.to_i == 0
	          return  nil
          end 

          if cant_digitos == 6
             if fecha.slice(0,2).to_i.between?(0,14)
                 fecha = "20#{fecha.slice(0,2)}#{fecha.slice(2,2)}#{fecha.slice(4,2)}"
             else
                 fecha = "19#{fecha.slice(0,2)}#{fecha.slice(2,2)}#{fecha.slice(4,2)}"
             end
          end
          # arreglar año
          # case
              # when fecha.slice(0,4) == '2092' then anio = "1992"
              # when fecha.slice(0,4) == '2093' then anio = "1993"
              # when fecha.slice(0,4) == '2094' then anio = "1994"
              # when fecha.slice(0,4) == '2095' then anio = "1995"
              # when fecha.slice(0,4) == '2096' then anio = "1996"
              # when fecha.slice(0,4) == '2097' then anio = "1997"
              # when fecha.slice(0,4) == '2098' then anio = "1998"
              # when fecha.slice(0,4) == '2099' then anio = "1999"
              # when fecha.slice(0,4) == '1900' then anio = "2000"
              # when fecha.slice(0,4) == '1905' then anio = "2005"
              # when fecha.slice(0,4) == '1906' then anio = "2006"
              # when fecha.slice(0,4) == '1907' then anio = "2007"
              # when fecha.slice(0,4) == '1908' then anio = "2008"
              # when fecha.slice(0,4) == '1909' then anio = "2009"
              # when fecha.slice(0,4) == '1910' then anio = "2010"
              # when fecha.slice(0,4) == '1911'  then anio = "2011"
          # else
             anio = fecha.slice(0,4)
          #end
          #arreglar dias 31 de cada mes.
          case
              # febrero
              when fecha.slice(4,4).to_s == '0229' then dia = "28"
              when fecha.slice(4,4).to_s == '0230' then dia = "28"
              when fecha.slice(4,4).to_s == '0231' then dia = "28"
              # Abril
              when fecha.slice(4,4).to_s == '0431' then dia = "30"
              # Junio
              when fecha.slice(4,4).to_s == '0631' then dia = "30"
              # Septiembre
              when fecha.slice(4,4).to_s == '0931' then dia = "30"
              # Noviembre
              when fecha.slice(4,4).to_s == '1131' then dia = "30"
          else
             dia = fecha.slice(6,2)
          end
          fecha_ok = "#{anio}-#{fecha.slice(4,2)}-#{dia}".to_date
          unless fecha_ok.between?('1900-01-01'.to_date,'2020-01-01'.to_date)
             #         puts "FECHAS FUERA DE RANGO  #{fecha_ok}"
                      return '1900-01-01'.to_date
                     #return fecha_ok
           end
           return fecha_ok
      end
      rescue
            escribe_en_log('error_caracteres_fecha',fecha)
            return '1900-01-01'.to_date
      end
   end


def validar_fecha_hora(fecha, hora,min)
    begin
          if fecha.nil? || fecha.blank? || fecha == '00000000' || fecha == '0'  || "#{fecha}".to_s == "00000000"
                return  nil
          else
				fecha_hora_ok = DateTime.new(fecha.year,fecha.month,fecha.day,hora,min)
                fecha_hora_ok = DateTime.parse("#{fecha.year}-#{fecha.month}-#{fecha.day} #{hora}:#{min}:01.000000")
                return fecha_hora_ok
          end
   rescue
          return nil
   end
end

def limpia_caracteres(r)
            r.gsub!("A�o ","Año ")
            r.gsub!("a�o ","año ")
            r.gsub!("A#o ","Año ")
            r.gsub!("a#o ","año ")
            r.gsub!("N^","Nro")
            r.gsub!("Nº","Nro")
            r.gsub!("NRO'","Nro")
            r.gsub!("Nª'","Nro")
            r.gsub!("(CTES)"," Ctes. ")
            r.gsub!("(Ctes)"," Ctes. ")
	        r.gsub!("-"," - ")
            r.gsub!("'","")
            r.gsub!("`","")
            r.gsub!("#'","ñ")
            r.gsub!("|","ñ")
            r.gsub!("%","ñ")
            r.gsub!("€","ñ")
            r.gsub!("@","º")
            r.gsub!("�","º")
            r.gsub!("  "," ")

  return r
end

def limpia_ultimo_caracter(nombre,con_punto)
  if con_punto == true
      especiales =[".","!","·","$","%","&","/","(","=","?","¿",";",":","_","-","ª","*"]
    else
      especiales =["!","·","$","%","&","/","(","=","?","¿",";",":","_","-","ª","*"]
  end
            if especiales.include?("#{nombre.to_s.last}")
                   nombre = nombre.slice(0,nombre.length-1)
                   if especiales.include?("#{nombre.to_s.last}")
                            nombre = nombre.slice(0,nombre.length-1)
                            if especiales.include?("#{nombre.to_s.last}")
                                nombre = nombre.slice(0,nombre.length-1)
                            end
                   end
            end
            return nombre
end

def mayuscula(cadena)
   cadena.gsub!(",",", ") 
   cadena.gsub!(",",". ") 
   pronombres = ['de','del','a','la','S.A.','S.R.L.','y','el','o','']
   cadena  = cadena.squish unless cadena.nil? || cadena.blank?
   resultado = nil
   a = cadena.split
   i = 0
   a.each do |palabra|
     palabra = palabra.to_s.downcase
     if  i == 0
          resultado =  palabra.to_s.capitalize
     else
           if pronombres.include?(palabra)
              resultado = resultado + " #{palabra}"
           else
              resultado = resultado + " #{palabra.capitalize}"
           end
     end
     i += 1
   end
   return resultado
end

def escribe_en_log(nombre_archivo,frase)
      File.open("/home/broger/proyectos/migracion/log/#{nombre_archivo}.log", "a+") { |file|
      file.puts "#{frase}"
      }
  end

  ############################# BASE DE DATOS ####################################

def preparar_tabla(tabla)
   ActiveRecord::Base.connection.execute("DELETE FROM #{tabla};
                                        ALTER SEQUENCE #{tabla}_id_seq RESTART WITH 1;")
end

def alter_ide(tabla)
   ultimo = ActiveRecord::Base.connection.execute("SELECT max(id) FROM #{tabla};")
   pasaje = ultimo[0]
   ultimo = pasaje["max"]
   id_final = ultimo + 1
   ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{tabla}_id_seq RESTART #{id_final}")
end

def eliminar_indice(nombre_indice)
   ActiveRecord::Base.connection.execute("DROP INDEX IF EXISTS #{nombre_indice};")
end

def crear_indice(tabla,columna,nombre_indice)
  ActiveRecord::Base.connection.execute("CREATE INDEX #{nombre_indice} ON #{tabla}  USING btree (#{columna});")
end

def tuning_tabla(tabla)
  ActiveRecord::Base.connection.execute("VACUUM FULL #{tabla};")
end

def tuning_extremo_tabla(tabla)
  ActiveRecord::Base.connection.execute("CLUSTER #{tabla};")
end

############################# TABLAS ####################################

def local_y_prov(postal)

    
    if postal.nil? || postal.blank?
      localidad_id = 110
      provincia_id = 26
    else
      a = Localidad.find(:first, :conditions => {:codigo_postal => postal.to_i})
      if a
        localidad_id = a.id
        provincia_id = Provincia.find(a.provincia_id).id
      else
        localidad_id = 110
        provincia_id = 26
      end
    end
    return [localidad_id, provincia_id]
 end

























def trae_tipo_prestador(tipo)
      case tipo
              when 'M' then tipo_matricula_id = 1  # medico
              when 'B' then tipo_matricula_id = 2  # bioq
              when 'O' then tipo_matricula_id = 3  # odonto
              when 'K' then tipo_matricula_id = 4  # kinesio
              when 'P' then tipo_matricula_id = 5  # podolo
              when 'E' then tipo_matricula_id = 6  # enfermero
              when 'F' then tipo_matricula_id = 7  # farmacia
              when 'C' then tipo_matricula_id = 8  # clinica
              when 'H' then tipo_matricula_id = 9  # hospital
              when 'D' then tipo_matricula_id = 10 # fonoaudiologo
              when 'S' then tipo_matricula_id = 11 # psicologo
              when ' ' then tipo_matricula_id = 13 # Sin Datos migracion
              when 'I' then tipo_matricula_id = 14 # COlegio Medico Ctes.
              when 'U' then tipo_matricula_id = 15 # caps
              when 'J' then tipo_matricula_id = 16 # centro dialisis
              when 'N' then tipo_matricula_id = 17 # Asoc. de clinicas
              when 'L' then tipo_matricula_id = 18 # asopocor
              when 'W' then tipo_matricula_id = 19 # conv. con otras prov.
              when 'G' then tipo_matricula_id = 20 # Colegio Médico Internos
              when 'Z' then tipo_matricula_id = 21 # SIN DATOS
              when 'R' then tipo_matricula_id = 22 # sin datos
	      when nil then tipo_matricula_id = 13 # Sin Datos migracion	

      else
              escribe_en_log('tipo_prestador_no_encotrado',"no existe #{tipo}")
              tipo_matricula_id = 12 # sin datos

      end

      return tipo_matricula_id

 end

def trae_prestador(tipo,matricula)

      tipo_prestador_id = trae_tipo_prestador(tipo)

      a = PrestadorProfesional.find(:first, :conditions=>{:matricula_profesional =>  matricula.to_i, :tipo_prestador_id => tipo_prestador_id.to_i})
      if a
        return a.id
      else
         File.open('/home/broger/proyectos/migracion/prestadores_no_encontrados_planes.log', "a+") { |file|
         file.puts "#{matricula}"}
        return "0".to_i
      end
 end

def trae_auditor(tipo,matricula)
      a = Auditor.find(:first, :conditions=>{:tipo_prestador_id => tipo.to_i, :nro_matricula =>  matricula.to_i})
      if a
        return a.id
      else
         File.open("/home/broger/proyectos/migracion/auditores_no_encontrados_practicas.log", "a+") { |file|
         file.puts "#{matricula}"}
        return '0'.to_i
      end
 end

def trae_beneficiario(documento)
    a = Beneficiario.find(:first, :conditions =>['nro_documento = ?', documento.to_i])
    if a
         return a.id
    else
         return '0'.to_i
    end
end

def trae_nomenclador_id(nomencla)
       begin
            b = NomencladorPractica.find(:first, :conditions =>{:codigo => nomencla})
            if  b
              return b.id
            else
              return '0'.to_i
            end
       rescue
            return '0'.to_i
       end
end

def trae_oms(codigo)
            a = OmsDiagnostico.find(:first, :conditions => {:codigo => codigo.to_i}).id
            if  a
              return a
            else
              return ' 913'
            end
end

def trae_caja_fecha(tipo,codigo)
            a = MigracionCajafecha.find(:first, :conditions => {:tipo_bono_id => tipo, :numero_orden => codigo.to_i})
            if  a
              return a
            else
              return  nil
            end
end


############################# PLANES ESPECIALES #############################################

def baja_chequera(solicitud,nombre_archivo)
     c = MigracionBajaPlan.find(:first, :conditions =>{:solicitud => solicitud, :nombre_archivo => nombre_archivo})
     if c
          fecha = c.fecha_baja
     else
          fecha = nil
     end
     return fecha
end

def motivo_baja_chequera(solicitud,nombre_archivo)
     c = MigracionBajaPlan.find(:first, :conditions =>{:solicitud => solicitud, :nombre_archivo => nombre_archivo})
     if c
          motivo = c.motivo_baja
     else
          motivo = nil
     end
     return motivo
end

def new_beneficiario_plan(nro_orden, ide_beneficiario,ide_plan,fecha_alta, fecha_baja,fecha_vencimiento,prestador = nil,motivo_baja = nil,migracion_tipo_orden = nil)
   begin
        a = BeneficiarioPlan.new
        a.beneficiario_id = ide_beneficiario
        a.plan_especial_id = ide_plan
        a.fecha_alta = fecha_alta
        a.fecha_baja = fecha_baja
        a.fecha_vencimiento = fecha_vencimiento.to_date
        a.prestador_profesional_id = prestador
        a.motivo_baja_plan_id = motivo_baja
        a.nro_orden = nro_orden
        a.migracion_tipo_orden = migracion_tipo_orden
        a.save!
   rescue
         File.open('/home/broger/proyectos/migracion/errores_en_alta_benef_planes.log', "a+") { |file|
         file.puts "fecha-alta #{fecha_alta} baja #{fecha_baja} venci #{fecha_vencimiento} #{prestador}"}
   end
end

def new_dato_plan(ide_beneficiario_plan,ide_dato_plan, valor)
  a = BeneficiarioPlanDato.new
  a.beneficiario_plan_id = ide_beneficiario_plan
  a.plan_dato_especial_id = ide_dato_plan
  a.valor = valor
  a.save!
end

def oms_2digitos(codigo_diagnostico)
    case
        when codigo_diagnostico == 9   then oms_diagnostico_id = 368
        when codigo_diagnostico == 17  then oms_diagnostico_id = 296
        when codigo_diagnostico == 20  then oms_diagnostico_id = 714
        when codigo_diagnostico == 27  then oms_diagnostico_id = 251
        when codigo_diagnostico == 29  then oms_diagnostico_id = 331
        when codigo_diagnostico == 56  then oms_diagnostico_id = 344
        when codigo_diagnostico == 15  then oms_diagnostico_id = 296
        when codigo_diagnostico == 58  then oms_diagnostico_id = 296
        when codigo_diagnostico == 14  then oms_diagnostico_id = 345
        when codigo_diagnostico == 16  then oms_diagnostico_id = 295
        when codigo_diagnostico == 25  then oms_diagnostico_id = 277
        when codigo_diagnostico == 44  then oms_diagnostico_id = 340
        when codigo_diagnostico == 47  then oms_diagnostico_id = 322
        when codigo_diagnostico == 5   then oms_diagnostico_id = 244
        when codigo_diagnostico == 10  then oms_diagnostico_id = 389
        when codigo_diagnostico == 8   then oms_diagnostico_id = 742
        when codigo_diagnostico == 49  then oms_diagnostico_id = 344
        when codigo_diagnostico == 57  then oms_diagnostico_id = 042
        when codigo_diagnostico == 18  then oms_diagnostico_id = 584
        when codigo_diagnostico == 51  then oms_diagnostico_id = 318
        when codigo_diagnostico == 6   then oms_diagnostico_id = 359
        when codigo_diagnostico == 7   then oms_diagnostico_id = 318
        when codigo_diagnostico == 46  then oms_diagnostico_id = 742
        when codigo_diagnostico == 52  then oms_diagnostico_id = 358
        when codigo_diagnostico == 30  then oms_diagnostico_id = 340
        when codigo_diagnostico == 31  then oms_diagnostico_id = 340
        when codigo_diagnostico == 33  then oms_diagnostico_id = 318
        when codigo_diagnostico == 2   then oms_diagnostico_id = 343
        when codigo_diagnostico == 40  then oms_diagnostico_id = 340
        when codigo_diagnostico == 45  then oms_diagnostico_id = 343
        when codigo_diagnostico == 60  then oms_diagnostico_id = 296
        when codigo_diagnostico == 32  then oms_diagnostico_id = 318
        when codigo_diagnostico == 34  then oms_diagnostico_id = 318
        when codigo_diagnostico == 1   then oms_diagnostico_id = 758
        when codigo_diagnostico == 55  then oms_diagnostico_id = 389
        when codigo_diagnostico == 42  then oms_diagnostico_id = 11
        when codigo_diagnostico == 53  then oms_diagnostico_id = 340
        when codigo_diagnostico == 48  then oms_diagnostico_id = 425
        when codigo_diagnostico == 19  then oms_diagnostico_id = 710
        when codigo_diagnostico == 62  then oms_diagnostico_id = 285
    else
        oms_diagnostico_id = 913
    end
    return oms_diagnostico_id
end

################################ ORDENES  ###################################################


def trae_tipo_orden_id(letra_de_cajas,nro_de_fiscal,nomencla)

     case
          ############ CAJAS ################  FISCAL ############## NOMENCLA ##############
          when letra_de_cajas  == 'C'  || nro_de_fiscal == 1   || nomencla == 420101  then tipo_orden_id = 1   # comun
          when letra_de_cajas  == 'P'  || nro_de_fiscal == 2                          then tipo_orden_id = 2   # practica
          when  letra_de_cajas == 'O'  || nro_de_fiscal == 3   || nomencla == 305001  then tipo_orden_id = 3   # oftalmolog
          when letra_de_cajas  == 'F'  || nro_de_fiscal == 99                         then tipo_orden_id = 4   # BETA
          when letra_de_cajas  == 'N'  || nro_de_fiscal == 10  || nomencla == 425001  then tipo_orden_id = 5   # neuro 1 o 2 (APARAENTEMENTE PARA LOS DOS )??????????????????
          when letra_de_cajas  == 'D'  || nro_de_fiscal == 99  || nomencla == 005000  then tipo_orden_id = 6   # Podologo
          when letra_de_cajas  == 'G'  || nro_de_fiscal == 99  || nomencla == 310101  then tipo_orden_id = 7   # fonoaudiologo
          when letra_de_cajas  == 'A'  || nro_de_fiscal == 99  || nomencla == 310101  then tipo_orden_id = 8   # NO SE USA ONCOLOGICO
          when letra_de_cajas  == 'Q'  || nro_de_fiscal == 99                         then tipo_orden_id = 9  # ?
          when letra_de_cajas  == 'XX' || nro_de_fiscal == 99                        then tipo_orden_id = 10  # Oncologico de fiscalizacion ?
          when letra_de_cajas  == 'XX' || nro_de_fiscal ==  1000                    then tipo_orden_id = 11  # BETA
          when letra_de_cajas  == 'XX' || nro_de_fiscal ==  12312                        then tipo_orden_id = 12  # PMI1
          when letra_de_cajas  == 'XX' || nro_de_fiscal ==  26516                    then tipo_orden_id = 13  # PMIB


      else
       # nada
      end

end

def alta_ordenes(tipo_orden_id,nombre_archivo,documento,numero,fecha_hora,estado,codigo_nomencla,coseguro_pesos ='0.0'.to_f,motivo=nil,excepcion_codigo=nil,excepcion_descripcion=nil,nomenclador_id=0,internacion_id = 0,beneficiario_plan_id=0,es_plan = false,tipo_matricula = 0, matricula = 0,codigo_postal=0)
   begin 
	   ActiveRecord::Base.connection.execute("INSERT INTO migracion_ordenes(tipo_orden_id,
								              archivo,
								              documento,
								              numero_orden,
								              fecha_hora_emision,
								              estado_orden,
								              motivo_orden,
								              motivo_excepcion_id,
								              motivo_excepcion_descripcion,
								              codigo_nomencla,
								              coseguro_pesos,
								              nomenclador_id,
								              internacion_id,
								              beneficiario_plan_id,
								              es_plan,
								              tipo_matricula,
								              matricula,
											  codigo_postal
								               )
						                      VALUES ('#{tipo_orden_id}',
						                               '#{nombre_archivo}',
						                               '#{documento}',
						                               '#{numero}',
						                               '#{fecha_hora}',
						                               '#{estado}',
						                               '#{motivo}',
						                               '#{excepcion_codigo}',
						                               '#{excepcion_descripcion}',
						                               '#{codigo_nomencla}',
						                               '#{coseguro_pesos}',
						                               '#{nomenclador_id}',
						                               '#{internacion_id}',
						                               '#{beneficiario_plan_id}',
						                               '#{es_plan}',
						                               '#{tipo_matricula}',
						                               '#{matricula}',
													   '#{codigo_postal}' 	
						                                );

						                          ")
   rescue
   		 escribe_en_log('error_alta_ordenes',"doc #{documento} numero #{numero} fecha #{fecha_hora} estado #{estado}")	

   end 




end

