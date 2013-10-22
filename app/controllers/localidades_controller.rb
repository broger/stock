class LocalidadesController < ApplicationController

  before_filter :login_required

  # GET /localidads
  # GET /localidads.xml
  def index
    if params[:txtbuscar].blank?
       @localidades = Localidad.paginate(:page => params[:page],:per_page => 6,:order => "nombre")
    else
       @localidades = Localidad.paginate(:page => params[:page],:per_page => 6,:conditions=> ['lower(nombre) like lower(?)','%'+params[:txtbuscar]+'%'],:order => "nombre")
    end

    @busqueda = params[:txtbuscar]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @localidades }
    end
  end

  # GET /localidads/1
  # GET /localidads/1.xml
  def show
    @localidad = Localidad.find(params[:id])
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @localidades }
    end
  end

  def new
    @localidad = Localidad.new

    respond_to do |format|
      format.html{render :layout=>false}
    end
  end

  # GET /localidads/1/edit
  def edit
    @localidad = Localidad.find(params[:id])
    
    respond_to do |format|
      format.html{render :layout=>false}
    end
  end

  # POST /localidads
  # POST /localidads.xml
  def create
    @localidad = Localidad.new(params[:localidad])

    respond_to do |format|
      if @localidad.save
        format.html { redirect_to(localidades_path, :notice => 'La Localidad ha sido creada satisfactoriamente.') }
        format.xml  { render :xml => @localidad, :status => :created, :location => @localidad }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @localidad.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /localidads/1
  # PUT /localidads/1.xml
  def update
    @localidad = Localidad.find(params[:id])

    respond_to do |format|
      if @localidad.update_attributes(params[:localidad])
        format.html { redirect_to(localidades_path, :notice => 'La Localidad ha sido actualizada satisfactoriamente.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @localidad.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /localidads/1
  # DELETE /localidads/1.xml
  def destroy
    @localidad = Localidad.find(params[:id])
    @localidad.destroy

    respond_to do |format|
      format.html { redirect_to(localidades_url, :notice => 'La Localidad ha sido eliminada satisfactoriamente.') }
      format.xml  { head :ok }
    end
  end
end
