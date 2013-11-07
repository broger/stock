class InventariosController < ApplicationController
  
def index
    @ajustes = Comprobante.paginate(:page => params[:page],:per_page => 6, :conditions=>{:tipo_comprobante_id => 4})
    
    @busqueda = params[:txtbuscar]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ajustes }
    end
  end


  def ajuste_positivo
  	   @comprobante = Comprobante.ajuste_positivo.new
       @ajuste_pos = TipoComprobante.find(4).ultimo_nro .to_i + 1
      
	   respond_to do |format|
	      format.html # new.html.erb
	      format.xml  { render :xml => @comprobante }
	   end	

  end

  def ajuste_negativo

  end


  def show_ajuste
      @ajuste = Comprobante.ajuste_positivo.find(params[:id])
      @detalle = @ajuste.movimientos.paginate(:page => params[:page],:per_page => 6)

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @ajuste }
      end
  end 


  def agregar_detalle
     @productos = ActiveRecord::Base.connection.execute("select p.id     as id,
                                                                p.codigo as codigo,
                                                                p.nombre as nombre,
                                                                u.nombre as unidad,
                                                                ps.stock as stock
                                                         from productos p 
                                                         inner join unidades        u  ON p.unidad_id = u.id
                                                         inner join producto_stocks ps ON ps.producto_id = p.id
                                                         where
                                                            ps.deposito_id = #{current_user.sucursal.deposito.id}
                                                            AND p.id = #{params[:producto_id]}
                                                        ")
     #raise "xxxx #{@productos}"

     respond_to do |format|
          format.js
     end
  end

  def guardar_ajuste

   Comprobante.transaction do
            
            ajuste = Comprobante.ajuste_positivo.new
            if ajuste.existe_nro?(4,params[:numero]) == true 
               raise  "Error el nro de comprobante ya existe"
            end   
            ajuste.numero        = params[:numero]
            ajuste.observaciones = params[:observaciones] if params[:observaciones]
            ajuste.user_id       = current_user
            ajuste.sucursal_id   = current_user.sucursal.id
            ajuste.concepto_operacion_id = params[:concepto_operacion_id]
            ajuste.save!

            a =  TipoComprobante.find(4)
            a.ultimo_nro = params[:numero] 
            a.save!

            unless params["comprobante"].blank?   

                cant_total = 0
                params["comprobante"].each do |k,o|
                   # producto_id = k 
                   # costo = o        

                   # nuevo movimiento
                   mov = Movimiento.new
                   mov.producto_id = k
                   mov.cantidad = o[:cant].to_f
                   mov.afecta_stock = true
                   mov.comprobante_id  = ajuste.id
                   mov.deposito_id = params[:deposito_id]
                   mov.save!  
    
                   # actualiza STOCK GENERAL del producto
                   producto = Producto.find(k)
                   producto.stock =  producto.stock.to_f + o[:cant].to_f
                   producto.save!
                   # actualiza STOCK DE LA SUCURSAL
                   
                   ps = ProductoStock.find(:first, :conditions=>['producto_id = ? AND deposito_id = ?',k,params[:deposito_id]])
                   ps.stock =  ps.stock.to_f + o[:cant].to_f
                   ps.save!

                   cant_total = cant_total + o[:cant].to_f

                end 
                

                if cant_total == params[:cant_total].to_f
                     ok = true
                     noticia =  "El Ajuste (+) Nº: #{params[:numero]} ha sido creado correctamente, el stock de los productos incluidos a sido modificado."
                else
                     raise  " Error: diferencia en la suma total de moviminetos con el parametro cantidad_total. Contactese con el Adminsitrador gracias!."
                end
            
            else
                ok = false
                noticia = "No existen productos en el detalle de la factura de ventas."
            end
           redirect_to(show_ajuste_inventarios_url(:id=>ajuste.id),:notice =>noticia)
     end  
  end

  def transferencia_sucursales

  end

  def tomar_inventario


  end


end
