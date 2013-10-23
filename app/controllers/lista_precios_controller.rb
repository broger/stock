class ListaPreciosController < ApplicationController
  # GET /lista_precios
  # GET /lista_precios.xml
    def index
    if params[:txtbuscar].blank?
       @listas = ListaPrecio.paginate(:page => params[:page],:per_page => 6,:order => "nombre")
    else
       @listas = ListaPrecio.paginate(:page => params[:page],:per_page => 6,:conditions=> ['lower(nombre) like lower(?)','%'+params[:txtbuscar]+'%'],:order => "nombre")
    end


    respond_to do |format|
      format.html 
      format.xml  { render :xml => @listas }
    end
  end

  # GET /lista_precios/1
  # GET /lista_precios/1.xml
  def show
    @lista_precio = ListaPrecio.find(params[:id])
    @producto_listas = @lista_precio.producto_lista_precios.paginate(:page => params[:page],:per_page => 30)
    @cant_productos = @lista_precio.producto_lista_precios.count    

    respond_to do |format|
      format.html 
      format.xml  { render :xml => @lista_precio}
    end
  end

  # GET /lista_precios/new
  # GET /lista_precios/new.xml
  def new
    @lista_precio = ListaPrecio.new
     respond_to do |format|
      format.html{render :layout=>false}
    end
  end

  # GET /lista_precios/1/edit
  def edit
    @lista_precio = ListaPrecio.find(params[:id])
    respond_to do |format|
      format.html{render :layout=>false}
    end
  end

  # POST /lista_precios
  # POST /lista_precios.xml
  def create
    @lista_precio = ListaPrecio.new(params[:lista_precio])

    respond_to do |format|
      if @lista_precio.save

        format.html { redirect_to(@lista_precio, :notice => "La Nueva Lista de Precio #{@lista_precio.nombre} ha sido creada satisfactoriamente.") }
        format.xml  { render :xml => @lista_precio, :status => :created, :location => @lista_precio }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @lista_precio.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /lista_precios/1
  # PUT /lista_precios/1.xml
  def update
    @lista_precio = ListaPrecio.find(params[:id])

    respond_to do |format|
      if @lista_precio.update_attributes(params[:lista_precio])
        format.html { redirect_to(@lista_precio, :notice => 'ListaPrecio was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @lista_precio.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /lista_precios/1
  # DELETE /lista_precios/1.xml
  def destroy
        @lista_precio = ListaPrecio.find(params[:id])

        #existen_reg = Comprobante.find(:all, :conditions=>{:lista_precio_id=>params[:id]}))

        
        respond_to do |format|

           # unless  existen_reg
           #       @lista_precio.destroy
           #       noti = "La lista de precios #{@lista_precio.nombre} ha sido eliminada satisfactoriamente."
           #       format.xml  { head :ok }
           # else
                  ruta = "lista_precios/#{@lista_precio.id.to_s}/edit"
                  noti = "Existen registro relacionados a esta lista de precio, solamente puede cambiar su estado a baja desde #{ActionController::Base.helpers.link_to 'aqu&iacute;', ruta, :class=> 'fancybox'}."       
           # end
            
            format.html { redirect_to( lista_precios_url, :notice=> noti)}
                  
        end        

  end


   
end #final
