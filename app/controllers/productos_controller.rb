class ProductosController < ApplicationController
  # GET /productos
  # GET /productos.xml
  def index
    filtros =  " "
    unless params[:rubro_id].blank?
      filtros += " AND rubro_id = #{params[:rubro_id]}"
    end

    unless params[:txtbuscar].blank?
      filtros += " AND lower(nombre) like lower('%#{params[:txtbuscar]}%') "
    end

    if filtros == " "
       @productos = Producto.paginate(:page => params[:page],:per_page => 6,:order => "nombre")
    else

      @productos = Producto.find_by_sql("SELECT * FROM productos p where p.id > 0 #{filtros}")
      @productos = @productos.paginate :per_page => 6, :page => params[:page],:order => 'nombre.apellido_y_nombre ASC',:include=>[:talbas,:estado_beneficiario]

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
      format.html # new.html.erb
      format.xml  { render :xml => @producto }
    end
  end

  # GET /productos/1/edit
  def edit
    @producto = Producto.find(params[:id])
  end

  # POST /productos
  # POST /productos.xml
  def create
    @producto = Producto.new(params[:producto])

    respond_to do |format|
      if @producto.save
        format.html { redirect_to(@producto, :notice => 'El Producto ha sido creado satisfactoriamente.') }
        format.xml  { render :xml => @producto, :status => :created, :location => @producto }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @producto.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /productos/1
  # PUT /productos/1.xml
  def update
    @producto = Producto.find(params[:id])

    respond_to do |format|
      if @producto.update_attributes(params[:producto])
        format.html { redirect_to(@producto, :notice => 'El Producto ha sido actualizado satisfactoriamente.') }
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
    @producto = Producto.find(params[:id])
    @producto.destroy

    respond_to do |format|
      format.html { redirect_to(productos_url) }
      format.xml  { head :ok }
    end
  end
end
