class PedidoComprasController < ApplicationController
  

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
           @pedido_compras = Comprobante.pedido_compra.all
           @pedido_compras = @pedido_compras.paginate(:per_page => 24, :page => params[:page])

#      end     


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml =>  @pedido_compras}
    end
  end


  def new
    @comprobante = Comprobante.pedido_compra.new
    @ultimo_pd = TipoComprobante.find(2).ultimo_nro .to_i + 1
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comprobante }
    end
  end

  
  def show
    @pedido_compra = Comprobante.pedido_compra.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @pedido_compra }
      end

  end



  def agregar_detalle
      case 
           when params[:agrega] == 'todos' then
                   @agrega = 'todos' 
                   @productos = Producto.find(:all, :conditions=>{:estado_id=>1, :proveedor_id => params[:proveedor_id]}, :limit=>100)    
           when params[:agrega] == 'sin_stock' then
                   @agrega = 'sin_stock' 
                   @productos = Producto.find(:all, :conditions=>['estado_id = 1 AND stock <= punto_de_pedido AND proveedor_id = ?',params[:proveedor_id]], :limit=>100)  

          when params[:agrega] == 'uno_solo' then
                   @agrega = 'uno_solo'
                   @productos = Producto.find(:all, :conditions=>{:id=>params[:producto_id]})
      end            
       
        
        respond_to do |format|
          format.js
        end
  end


  def guardar
    Comprobante.transaction do


      nro_repetido = Comprobante.find(:first, :conditions=>{:numero => params[:numero].to_i})

      
      if nro_repetido.blank?


            pedido_compra = Comprobante.pedido_compra.new
            pedido_compra.numero = params[:numero]
            pedido_compra.proveedor_id =  params[:proveedor_id]
            pedido_compra.observaciones=  params[:observaciones]
            pedido_compra.usuario_id  =   current_user
            pedido_compra.vendedor_id  =  current_user
            pedido_compra.aprobado = true
            pedido_compra.save!
              

            tipo_pd = TipoComprobante.find(2)
            tipo_pd.ultimo_nro = params[:numero]
            tipo_pd.save!

            params["comprobante"].each do |k,o|
               # producto_id = k 
               # pedido = o        
               mov = Movimiento.new
               mov.producto_id = k
               mov.cantidad = o[:pedido]
               mov.afecta_stock = false 
               mov.comprobante_id  = pedido_compra.id
               mov.usuario_id = current_user
               mov.deposito_id = params[:deposito_id]
               mov.save!  
            end 

             redirect_to(pedido_compras_path(:id=>pedido_compra.id),:notice =>"El Pedido de Compras Nº: #{params[:numero]} ha sido creado correctamente, recuerde que esto no modifica su stock de productos." )
      else
         
            redirect_to(pedido_compras_path(:id=>pedido_compra.id),:notice =>"El Pedido de Compras Nº: #{params[:numero]} ya existe." )


      end #repetido

    end  
  end


end # final
