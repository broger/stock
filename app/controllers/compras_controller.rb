class ComprasController < ApplicationController
  

  def index
    @compras = Comprobante.compra.find(:all, :order=>'created_at DESC')
    @compras = @compras.paginate :per_page => 24, :page => params[:page],:include=>[:talbas,:estado_beneficiario]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @compras }
    end
  end


  def new
    @comprobante = Comprobante.compra.new

    @ultimo_nro = TipoComprobante.find(2).ultimo_nro + 1

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comprobante }
    end
  end


  def show
    @compra = Comprobante.compra.find(params[:id])
    @detalle =  @compra.movimientos.paginate(:per_page => 14, :page => params[:page])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @pedido_compra }
      end

  end




 def agregar_detalle
     
     @productos = Producto.find(:all, :conditions=>{:id=>params[:producto_id]})
     
     respond_to do |format|
          format.js
        end
  end


  def guardar
    Comprobante.transaction do


        
            compra = Comprobante.compra.new
            compra.numero = params[:numero]
            compra.proveedor_id =  params[:proveedor_id]
            compra.observaciones=  params[:observaciones] if params[:observaciones]
            compra.usuario_id  =   current_user
            compra.deposito_id = params[:deposito_id]
            compra.aprobado = true
            compra.total =  params[:total_factura]
            compra.save!

            tipo_compra = TipoComprobante.find(1)
            tipo_compra.ultimo_nro = params[:numero]
            tipo_compra.save!
            
            unless params["comprobante"].blank?   

                params["comprobante"].each do |k,o|
                   # producto_id = k 
                   # costo = o        

                   # nuevo movimiento
                   mov = Movimiento.new
                   mov.producto_id = k
                   mov.cantidad = o[:cant]
                   mov.afecta_stock = true
                   mov.comprobante_id  = compra.id
                   mov.usuario_id = current_user
                   mov.deposito_id = params[:deposito_id]
                   mov.costo = o[:costo]
                   mov.precio_total = (o[:cant].to_f * o[:costo].to_f)
                   mov.save!  
            
                   # actualiza stock del producto
                   producto = Producto.find(k)
                   producto.stock =  producto.stock.to_f + o[:cant].to_f
                   producto.save!

                end 
                   
                
                total_mov = Movimiento.sum(:precio_total, :conditions=>['comprobante_id = ?',compra.id])

                if total_mov.to_f == params[:total_factura].to_f
                     ok = true
                     noticia =  "La Factura de Compras Nº: #{params[:numero]} ha sido creado correctamente, el stock de los productos incluidos a sido modificado."
                else
                     raise  " Error: diferencia en la suma total de moviminetos con el parametro total_factura. Contactese con el Adminsitrador gracias!."

                end
               
            else
                ok = false
                noticia = "No existen productos en el detalle de la factura de compras."
            end
 
           redirect_to(show_compra_path(:id=>compra.id),:notice =>noticia)
    end  
  end


end # final
