require '/lib/tasks/funciones'
require 'spreadsheet'

namespace :stock do

   task :cargar_productos  => :environment do
        preparar_tabla('productos')
        ################## LECTURA EXCEL ###########################
        #include the libraries.
        entrada = Spreadsheet.open '/home/broger/Dropbox/STOCK/Lista_Precios/broger-griferia.xls'
        #open the required file
        libro_entrada = entrada.worksheet 0
        #open the required sheet
        #
        #################### NUEVO EXCEL PARA LA ESCRITURA ##########
        # create a new excel file
        salida = Spreadsheet::Workbook.new
        libro_salida = salida.create_worksheet
        # recorremos el excel de entrada
        libro_entrada.each do |columna|
              ############################################
              # DESDE EXCEL A TABLA

			  codigo =  columna[1]
			  costos = "#{columna[3]}".to_d

              ActiveRecord::Base.connection.execute("
		INSERT INTO productos(codigo,nombre,costo,categoria_id,seccion_id,rubro_id,marca_id,unidad_id,estado_id,proveedor_id,calificacion
) 
                                                    VALUES ('#{codigo}',
															'#{columna[2]}',
															 '#{costos}',
															  '#{columna[4]}',
															  '#{columna[5]}',
															  '#{columna[6]}',1,1,1,1,'A')")
              ############################################
              # DESDE EXCEL A RAIL
	                
 
        end

 end




end # final

