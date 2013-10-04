class PedidoComprasController < ApplicationController
  
  def index
           @pedido_compras = Comprobante.pedido_compra.find(:all, :order=>'created_at DESC')
           @pedido_compras = @pedido_compras.paginate(:per_page => 24, :page => params[:page])

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
    @detalle =  @pedido_compra.movimientos.paginate(:per_page => 14, :page => params[:page])

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


            unless params["comprobante"].blank?   

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

                ok = true
                noticia =  "El Pedido de Compras Nº: #{params[:numero]} ha sido creado correctamente, recuerde que esto no modifica su stock de productos."

            
            else
                ok = false
                noticia = "No existen productos en el detalle del pedido de compras."
            end
            


                  else
            ok = false
            noticia = "El Pedido de Compras Nº: #{params[:numero]} ya existe."
            
      end #repetido
      redirect_to(show_pedido_compra_path(:id=>pedido_compra.id),:notice =>noticia)
    end  
  end


end # final
