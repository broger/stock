class ProveedoresController < ApplicationController
  # GET /proveedores
  # GET /proveedores.xml
  def index
    if params[:txtbuscar].blank?
       @proveedores = Proveedor.paginate(:page => params[:page],:per_page => 6,:order => "nombre")
    else
       @proveedores = Proveedor.paginate(:page => params[:page],:per_page => 6,:conditions=> ['lower(nombre) like lower(?)','%'+params[:txtbuscar]+'%'],:order => "nombre")
    end

    @busqueda = params[:txtbuscar]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @proveedores }
    end
  end

  
  # GET /proveedores/1
  # GET /proveedores/1.xml
  def show
    @proveedor = Proveedor.find(params[:id])

    respond_to do |format|
      format.html{render :layout=>false}
    end
  end

  # GET /proveedores/new
  # GET /proveedores/new.xml
  def new
    @proveedor = Proveedor.new

    respond_to do |format|
      format.html{render :layout=>false}
    end
  end

  # GET /proveedores/1/edit
  def edit
    @proveedor = Proveedor.find(params[:id])
    
    respond_to do |format|
      format.html{render :layout=>false}
    end
  end

  # POST /proveedores
  # POST /proveedores.xml
  def create
    @proveedor = Proveedor.new(params[:proveedor])

    respond_to do |format|
      if @proveedor.save
        format.html { redirect_to(proveedores_url, :notice => 'El Proveedor ha sido creado satisfactoriamente.') }
        format.xml  { render :xml => proveedor_url, :status => :created, :location => @proveedor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @proveedor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /proveedores/1
  # PUT /proveedores/1.xml
  def update
    @proveedor = Proveedor.find(params[:id])

    respond_to do |format|
      if @proveedor.update_attributes(params[:proveedor])
        format.html { redirect_to(proveedores_url, :notice => 'El Proveedor ha sido actualizado satisfactoriamente.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @proveedor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /proveedores/1
  # DELETE /proveedores/1.xml
  def destroy


    @proveedor = Proveedor.find(params[:id])
    control = Comprobante.find(:all, :conditions=>{:proveedor_id => params[:id]})

    respond_to do |format|
         if control.blank?
            @proveedor.destroy
            format.html { redirect_to(proveedores_path, :notice => "El proveedor #{@proveedor.nombre} ha sido eliminado satisfactoriamente.") }
            format.xml  { render :xml => @cliente, :status => :created, :location => @proveddor }
          else
            format.html { redirect_to(clientes_path, :notice => "El proveedor no se ha podido eliminar porque existen datos relacionados a este registro, puedo asignarle estado igual a baja desde editar registro.") }
          end
    end
  end



end #final
