class ProductoListaPreciosController < ApplicationController
  # GET /producto_lista_precios
  # GET /producto_lista_precios.xml
  def index
    @producto_lista_precios = ProductoListaPrecio.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @producto_lista_precios }
    end
  end

  # GET /producto_lista_precios/1
  # GET /producto_lista_precios/1.xml
  def show
    @producto_lista_precio = ProductoListaPrecio.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @producto_lista_precio }
    end
  end

  # GET /producto_lista_precios/new
  # GET /producto_lista_precios/new.xml
  def new
    @producto_lista_precio = ProductoListaPrecio.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @producto_lista_precio }
    end
  end

  # GET /producto_lista_precios/1/edit
  def edit
    @producto_lista_precio = ProductoListaPrecio.find(params[:id])
  end

  # POST /producto_lista_precios
  # POST /producto_lista_precios.xml
  def create
    @producto_lista_precio = ProductoListaPrecio.new(params[:producto_lista_precio])

    respond_to do |format|
      if @producto_lista_precio.save
        format.html { redirect_to(@producto_lista_precio, :notice => 'ProductoListaPrecio was successfully created.') }
        format.xml  { render :xml => @producto_lista_precio, :status => :created, :location => @producto_lista_precio }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @producto_lista_precio.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /producto_lista_precios/1
  # PUT /producto_lista_precios/1.xml
  def update
    @producto_lista_precio = ProductoListaPrecio.find(params[:id])

    respond_to do |format|
      if @producto_lista_precio.update_attributes(params[:producto_lista_precio])
        format.html { redirect_to(@producto_lista_precio, :notice => 'ProductoListaPrecio was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @producto_lista_precio.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /producto_lista_precios/1
  # DELETE /producto_lista_precios/1.xml
  def destroy
    @producto_lista_precio = ProductoListaPrecio.find(params[:id])
    @producto_lista_precio.destroy

    respond_to do |format|
      format.html { redirect_to(producto_lista_precios_url) }
      format.xml  { head :ok }
    end
  end



 def editar_x_producto

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
         @producto_listas = ProductoListaPrecio.all(:limit=> 50)
      else
      
          if params[:txtbuscar].blank?
              # @producto_listas = Producto.find_by_sql("SELECT * FROM productos p where id > 0 #{filtros}")

          else
                if /^\d{1,10}$/.match(params[:txtbuscar].strip)
               #     @producto_listas = Producto.find_by_sql("SELECT * FROM productos p where p.codigo ilike '%#{params[:txtbuscar].strip}%' #{filtros}")
                else
                #    @producto_listas = Producto.find_by_sql("#{sql_descripcion('productos','nombre',params[:txtbuscar],30,false,filtros)}")
                end
          end 
      end     

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @productos }
    end


 end





end #final
