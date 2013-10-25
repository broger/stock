class VentasController < ApplicationController
	 

  def index
    @ventas = Comprobante.venta.find(:all, :order=>'created_at DESC')
    @ventas = @ventas.paginate :per_page => 24, :page => params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ventas }
    end
  end


  def new
    @comprobante = Comprobante.venta.new
    @ultima_venta = TipoComprobante.find(3).ultimo_nro .to_i + 1
      
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comprobante }
    end
  end


  def show
    @venta = Comprobante.venta.find(params[:id])
    @detalle =  @venta.movimientos.paginate(:per_page => 14, :page => params[:page])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @pedido_venta }
      end

  end

  def eliminar
    
    venta = Comprobante.find(params[:id])
    venta.destroy

    if venta.destroy
        flash[:notice] = "La Factura de venta se elimin&oacute; satisfactoriamente."
    else
        flash[:notice] = "Error al eliminar."
    end     
      redirect_to(ventas_url)
        
  end 


 def agregar_detalle
     
     @productos = ActiveRecord::Base.connection.execute("select * from productos p 
                                                        inner join producto_lista_precios plp ON plp.id = p.id
                                                        inner join producto_stocks         ps  ON ps.producto_id = p.id
                                                        where ps.deposito_id = #{current_user.sucursal.deposito_id}
                                                        and p.id = #{params[:producto_id]}
                                                        ")

     








     
     respond_to do |format|
          format.js
        end

 end





 def guardar
    Comprobante.transaction do


        
            venta = Comprobante.venta.new
            venta.numero         = params[:numero]
            venta.proveedor_id   = params[:proveedor_id]
            venta.observaciones  = params[:observaciones] if params[:observaciones]
            venta.usuario_id     = current_user
            venta.sucursal_id    = current_user.sucursal.id
            venta.total          = params[:total_factura]
            venta.comprobante_id = params[:comprobante_id]  if params[:comprobante_id]
            
            venta.save!

            # RELACIONO EL PEDIDO venta CON LA FACTURA venta
            if params[:comprobante_id]
                 pd = Comprobante.pedido_venta.find(params[:comprobante_id])
                 pd.comprobante_id = venta.id
                 pd.save!
            end  


            # FORMA DE PAGO

            case 
                when params[:forma_pago].strip == 'Efectivo' then

                         # raise "dddd #{params[:forma_pago].strip}"

                when params[:forma_pago].strip == 'Tarjeta' then 
                
                          # raise "tarjeta #{params[:forma_pago].strip}"
          
                when params[:forma_pago].strip == 'Cta. Cte.' then 

                         # raise "ddddd3333333 #{params[:forma_pago].strip}"

            end



            unless params["comprobante"].blank?   

                params["comprobante"].each do |k,o|
                   # producto_id = k 
                   # costo = o        

                   # nuevo movimiento
                   mov = Movimiento.new
                   mov.producto_id = k
                   mov.cantidad = o[:cant].to_f
                   mov.afecta_stock = true
                   mov.comprobante_id  = venta.id
                   mov.usuario_id = current_user
                   mov.deposito_id = params[:deposito_id]
                   mov.costo = o[:costo].to_f
                   mov.precio_total = o[:cant].to_f * o[:costo].to_f
                   mov.save!  
            
                   # actualiza STOCK GENERAL del producto
                   producto = Producto.find(k)
                   producto.stock =  producto.stock.to_f + o[:cant].to_f
                   producto.save!

                   # actualiza STOCK DE LA SUCURSAL
                   ps = ProductoStock.find(:first, :conditions['producto_id = ? AND deposito_id = ?',k,current_user.sucursal.deposito.id])
                   ps.stock =  ps.stock.to_f + o[:cant].to_f
                   ps.save!



                end 
                   
                
                total_mov = Movimiento.sum(:precio_total, :conditions=>['comprobante_id = ?',venta.id])

                if total_mov.to_f == params[:total_factura].to_f
                     ok = true
                     noticia =  "La Factura de ventas Nº: #{params[:numero]} ha sido creado correctamente, el stock de los productos incluidos a sido modificado."
                else
                     raise  " Error: diferencia en la suma total de moviminetos con el parametro total_factura. Contactese con el Adminsitrador gracias!."

                end
               
            else
                ok = false
                noticia = "No existen productos en el detalle de la factura de ventas."
            end
 
           redirect_to(show_venta_path(:id=>venta.id),:notice =>noticia)
    end  
  end


end # final

