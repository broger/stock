class ComprasController < ApplicationController
  

  def index
   # filtros =  " "
   # unless params[:rubro_id].blank?
   #   filtros += " AND rubro_id = #{params[:rubro_id]}"
   # end

   # unless params[:seccion_id].blank?
   #   filtros += " AND seccion_id = #{params[:seccion_id]}"
   # end

   # unless params[:categoria_id].blank?
   #   filtros += " AND categoria_id = #{params[:categoria_id]}"
   # end

#    unless params[:marca_id].blank?
#     filtros += " AND marca_id = #{params[:marca_id]}"
#    end

#    unless params[:proveedor_id].blank?
#      filtros += " AND marca_id = #{params[:proveedor_id]}"
#    end


#      if params[:txtbuscar].blank? && filtros == " "
#         @compras = Producto.paginate(:page => params[:page],:per_page => 24,:order => "nombre")
#      else
      
#          if params[:txtbuscar].blank?
#                @compras = Producto.find_by_sql("SELECT * FROM compras p where id > 0 #{filtros}")#

#          else
#                if /^\d{1,10}$/.match(params[:txtbuscar].strip)
#                    @compras = Producto.find_by_sql("SELECT * FROM compras p where p.codigo ilike '%#{params[:txtbuscar].strip}%' #{filtros}")
#                else
#                    @compras = Producto.find_by_sql("#{sql_descripcion('compras','nombre',params[:txtbuscar],30,false,filtros)}")
#                end
#          end 

           @compras = @compras.paginate :per_page => 24, :page => params[:page],:include=>[:talbas,:estado_beneficiario]
#      end     


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @compras }
    end
  end


  def new
    @comprobante = Comprobante.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comprobante }
    end
  end


    
  
end #final

