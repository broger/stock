
class ProductosController < ApplicationController
  # GET /productos
  # GET /productos.xml
  def index
    filtros =  " "
    unless params[:rubro_id].blank?
      filtros += " AND rubro_id = #{params[:rubro_id]}"
    end

    unless params[:seccion_id].blank?
      filtros += " AND seccion_id = #{params[:seccion_id]}"
    end

    unless params[:categoria_id].blank?
      filtros += " AND categoria_id = #{params[:categoria_id]}"
    end

    unless params[:marca_id].blank?
      filtros += " AND marca_id = #{params[:marca_id]}"
    end

    unless params[:proveedor_id].blank?
      filtros += " AND marca_id = #{params[:proveedor_id]}"
    end


      if params[:txtbuscar].blank? && filtros == " "
         @productos = Producto.paginate(:page => params[:page],:per_page => 16,:order => "nombre")
      else
      
          if params[:txtbuscar].blank?
                @productos = Producto.find_by_sql("SELECT * FROM productos p where id > 0 #{filtros}")

          else
          
                 # 1ro buscar x CODIGO
                 @productos=Producto.find(:all, :conditions=>['estado_id = 1 and codigo = ?', params[:txtbuscar] ])
                       
                 # 2do si no existe buscar  que el parametro sea IGUAL al NOMBRE 
                 if @productos.blank?
                      @productos=Producto.find(:all, :conditions=>['estado_id = 1 and nombre = ?',"#{params[:txtbuscar]}"], :order => :nombre)
                 end

                 # 3do si no existe buscar que el parametro sea PARECIDO al NOMBRE 
                 if @productos.blank?
                       @productos=Producto.find(:all, :conditions=>['estado_id = 1 and nombre ilike ?',"%#{params[:txtbuscar]}%"], :order => :nombre)
                 end

          end 

#SELECT 
#        p.codigo as codigo,
#  p.nombre as nombre,
#  m.nombre as marca,
#  u.nombre as unidad,
#  p.stock  as stoct_total,
#  p.nombre as nombre,
#  plp.precio as precio,
#  plp.descuento as descuento,
#  ps.stock      as stock_suc
  
# FROM productos p 
 
#inner join unidades                u   ON u.id = p.unidad_id
##inner join marcas                  m   ON m.id = p.marca_id
#inner join producto_lista_precios  plp ON plp.producto_id = p.id
##inner join lista_precios           lp  ON lp.id = plp.lista_precio_id
#inner join producto_stocks         ps  ON ps.producto_id = p.id
##inner join depositos               d   ON d.id = ps.deposito_id
#inner join sucursales              s   ON d.id = s.deposito_id
#where s.lista_precio_id = lp.id  and s.id =  2
#order by p.nombre



           @productos = @productos.paginate :per_page => 16, :page => params[:page],:include=>[:talbas,:estado_beneficiario]
      end     


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @productos }
    end
  end


    
  # GET /productos/1
  # GET /productos/1.xml
  def show
    @producto = Producto.find(params[:id])

    respond_to do |format|
      format.html{render :layout=>false}
    end
  end

  # GET /productos/new
  # GET /productos/new.xml
  def new
    @producto = Producto.new

   respond_to do |format|
      format.html{render :layout=>false}
    end
  end

  # GET /productos/1/edit
  def edit
    @producto = Producto.find(params[:id])
    respond_to do |format|
      format.html{render :layout=>false}
    end
  end

  # POST /productos
  # POST /productos.xml
  def create

    Producto.transaction do

        # PRODUCTO
        @producto = Producto.new(params[:producto])    
        @producto.save!


        # PRODUCTO LISTA PRECIOS
        unless params["lista_precio"].blank?   
              params["lista_precio"].each do |k,o|
                # lista_precio_id = k 
                # valores_input = o        
                existe_ya = ProductoListaPrecio.find(:first, :conditions=>{:producto_id=>@producto.id, :lista_precio_id=> k})
                unless existe_ya 
                   plp = ProductoListaPrecio.new
                   plp.producto_id = @producto.id
                   plp.lista_precio_id = k
                   plp.precio = o[:precio]
                   plp.descuento= o[:desc]
                   plp.save!
                end           
              end 
        end

        # PRODUCTO STOCK
        Deposito.all.each do |deposito|

            existe_ya = ProductoStock.find(:all, :conditions=>{:producto_id=>@producto.id, :deposito_id=>deposito.id})
            
            if existe_ya.nil? || existe_ya.blank?
                ps = ProductoStock.new
                ps.producto_id = @producto.id
                ps.deposito_id = deposito.id
                ps.stock = 0 
                ps.save!
            end
        end

        respond_to do |format|
            if @producto.save
                format.html { redirect_to(productos_url, :notice => "El Producto #{@producto.nombre} ha sido creado satisfactoriamente.") }
                format.xml  { render :xml => @producto, :status => :created, :location => @producto }
            else
                format.html { render :action => "new" }
                format.xml  { render :xml => @producto.errors, :status => :unprocessable_entity }
            end
        end
  end

  end

  # PUT /productos/1
  # PUT /productos/1.xml
  def update
    @producto = Producto.find(params[:id])

    respond_to do |format|
      if @producto.update_attributes(params[:producto])
        format.html { redirect_to(productos_url, :notice => "El Producto #{@producto.nombre} ha sido actualizado satisfactoriamente.") }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @producto.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /productos/1
  # DELETE /productos/1.xml
  def destroy
     Producto.transaction do
         @producto = Producto.find(params[:id])
         control = Movimiento.find(:all, :conditions=>{:producto_id=> @producto.id})
     
          if control.blank?
              ActiveRecord::Base.connection.execute("Delete from producto_stocks where producto_id = #{@producto.id}")
              ActiveRecord::Base.connection.execute("Delete from producto_lista_precios where producto_id = #{@producto.id}")
              @producto.destroy
              ok = true
           else
              ok = false
          end  
         respond_to do |format|
              if ok == true
                  format.html { redirect_to(productos_path, :notice => "El Producto #{@producto.nombre} ha sido eliminado satisfactoriamente.") }
                  format.xml  { head :ok }
              else
                  format.html { redirect_to(productos_path, :notice => "No es posible eliminar #{@producto.nombre} debido a que existen movimientos relacionados a &eacute;l. Puede editar el registro asignandole un estado igual a baja.") }
                  format.xml  { render :xml => @producto.errors, :status => :unprocessable_entity }
              end
         end
     end   
  end

  
  def todos

    unless params[:proveedor_id].blank? || params[:proveedor_id].nil?

        # 1ro buscar x CODIGO
        @productos=Producto.find(:all, :conditions=>['estado_id = 1 and codigo = ?', params[:q] ])
       
        # 2do si no existe buscar  que el parametro sea IGUAL al NOMBRE 
        if @productos.blank?
          @productos=Producto.find(:all, :conditions=>['estado_id = 1 and nombre = ?',"#{params[:q]}"], :order => :nombre)
        end

        # 3do si no existe buscar que el parametro sea PARECIDO al NOMBRE 
        if @productos.blank?
          @productos=Producto.find(:all, :conditions=>['estado_id = 1 and nombre ilike ?',"%#{params[:q]}%"], :order => :nombre)
        end

    else
    

        # 1ro buscar x CODIGO
        @productos=Producto.find(:all, :conditions=>['estado_id = 1 and codigo = ?', params[:q] ])
       
        # 2do si no existe buscar  que el parametro sea IGUAL al NOMBRE 
        if @productos.blank?
          @productos=Producto.find(:all, :conditions=>['estado_id = 1 and nombre ilike ?',"#{params[:q]}"], :order => :nombre)
        end

        # 3do si no existe buscar que el parametro sea PARECIDO al NOMBRE 
        if @productos.blank?
          @productos=Producto.find(:all, :conditions=>['estado_id = 1 and nombre ilike ?',"%#{params[:q]}%"], :order => :nombre)
        end
    
    end    

    respond_to do |format|
      format.json{render :json => @productos.to_json}
    end
  end


end # final
