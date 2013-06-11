class ProveedoresController < ApplicationController
  # GET /proveedores
  # GET /proveedores.xml
  def index
    if params[:txtbuscar].blank?
       @proveedores = Proveedor.paginate(:page => params[:page],:order => "razon_social")
    else
       @proveedores = Proveedor.paginate(:page => params[:page],:conditions=> ['lower(razon_social) like lower(?)','%'+params[:txtbuscar]+'%'],:order => "razon_social")
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @localidades }
    end
  end

  
  # GET /proveedores/1
  # GET /proveedores/1.xml
  def show
    @proveedor = Proveedor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @proveedor }
    end
  end

  # GET /proveedores/new
  # GET /proveedores/new.xml
  def new
    @proveedor = Proveedor.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @proveedor }
    end
  end

  # GET /proveedores/1/edit
  def edit
    @proveedor = Proveedor.find(params[:id])
  end

  # POST /proveedores
  # POST /proveedores.xml
  def create
    @proveedor = Proveedor.new(params[:proveedor])

    respond_to do |format|
      if @proveedor.save
        format.html { redirect_to(@proveedor, :notice => 'El Proveedor ha sido creado satisfactoriamente.') }
        format.xml  { render :xml => @proveedor, :status => :created, :location => @proveedor }
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
        format.html { redirect_to(@proveedor, :notice => 'El Proveedor ha sido actualizado satisfactoriamente.') }
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
    @proveedor.destroy

    respond_to do |format|
      format.html { redirect_to(proveedores_url) }
      format.xml  { head :ok }
    end
  end
end
