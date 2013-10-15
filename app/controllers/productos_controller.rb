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
         @productos = Producto.paginate(:page => params[:page],:per_page => 24,:order => "nombre")
      else
      
          if params[:txtbuscar].blank?
                @productos = Producto.find_by_sql("SELECT * FROM productos p where id > 0 #{filtros}")

          else
                if /^\d{1,10}$/.match(params[:txtbuscar].strip)
                    @productos = Producto.find_by_sql("SELECT * FROM productos p where p.codigo ilike '%#{params[:txtbuscar].strip}%' #{filtros}")
                else
                    @productos = Producto.find_by_sql("#{sql_descripcion('productos','nombre',params[:txtbuscar],30,false,filtros)}")
                end
          end 
           @productos = @productos.paginate :per_page => 24, :page => params[:page],:include=>[:talbas,:estado_beneficiario]
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

    @producto = Producto.new(params[:producto])

    Producto.transaction do

        @producto.save

        # guardar produto_lista
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
    @producto = Producto.find(params[:id])
    @producto.destroy

    respond_to do |format|
      format.html { redirect_to(productos_url) }
      format.xml  { head :ok }
    end
  end



  def todos

    unless params[:proveedor_id].blank? || params[:proveedor_id].nil?
        

        # 1ro buscar x CODIGO
        @productos=Producto.find(:all, :conditions=>['estado_id = 1 and codigo = ? and proveedor_id = ?', params[:q], params[:proveedor_id]])
       
        # 2do si no existe buscar x NOMBRE 
        if @productos.blank?
          @productos=Producto.find(:all, :conditions=>['estado_id = 1 and nombre ilike ? and proveedor_id = ?',"%#{params[:q]}%", params[:proveedor_id]], :order => :nombre,:limit=>30)
        end

    else
    

        # 1ro buscar x CODIGO
        @productos=Producto.find(:all, :conditions=>['estado_id = 1 and codigo = ?', params[:q] ])
       
        # 2do si no existe buscar x NOMBRE 
        if @productos.blank?
          @productos=Producto.find(:all, :conditions=>['estado_id = 1 and nombre ilike ?',"%#{params[:q]}%"], :order => :nombre,:limit=>30)
        end
    
    end    

    respond_to do |format|
      format.json{render :json => @productos.to_json}
    end
  end


end
