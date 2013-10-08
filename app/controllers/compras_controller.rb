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

      nro_repetido = Comprobante.compra.find(:first, :conditions=>{:numero => params[:numero].to_i})

      if nro_repetido.blank?

            compra = Comprobante.compra.new
            compra.numero = params[:numero]
            compra.proveedor_id =  params[:proveedor_id]
            compra.observaciones=  params[:observaciones] if params[:observaciones]
            compra.usuario_id  =   current_user
            compra.deposito_id = params[:deposito_id]
            compra.aprobado = true
            compra.save!

            tipo_compra = TipoComprobante.find(1)
            tipo_compra.ultimo_nro = params[:numero]
            tipo_compra.save!

            validacion_total = 0
            
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

                   mov.save!  

            
                   # actualiza stock del producto
                   producto = Producto.find(k)
                   producto.stock =  producto.stock.to_f + o[:cant].to_f
                   producto.save!


                   # CALCULAR TOTAL 
                   #total = o[:pedido] * o[:costo]
                   #validacion_total =+ total

                   #if validacion_total == total_facturado 


                   #end

                end 

                ok = true
                noticia =  "La Factura de Compras Nº: #{params[:numero]} ha sido creado correctamente, el stock de los productos incluidos a sido modificado."
            
            else
                ok = false
                noticia = "No existen productos en el detalle de la factura de compras."
            end
 
      else
            ok = false
            noticia = "La Factura de Compras Nº: #{params[:numero]} ya existe."
            
      end #repetido
      redirect_to(show_compra_path(:id=>compra.id),:notice =>noticia)
    end  
  end


end # final
