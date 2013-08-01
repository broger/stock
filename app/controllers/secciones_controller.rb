class SeccionesController < ApplicationController
  # GET /secciones
  # GET /secciones.xml
  def index
    if params[:txtbuscar].blank?
       @secciones = Seccion.paginate(:page => params[:page],:per_page => 6,:order => "nombre")
    else
       @secciones = Seccion.paginate(:page => params[:page],:per_page => 6,:conditions=> ['lower(nombre) like lower(?)','%'+params[:txtbuscar]+'%'],:order => "nombre")
    end


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @localidades }
    end
  end

  # GET /secciones/1
  # GET /secciones/1.xml
  def show
    @seccion = Seccion.find(params[:id])

    respond_to do |format|
       format.html{render :layout=>false}
    end
  end

  # GET /secciones/new
  # GET /secciones/new.xml
  def new
    @seccion = Seccion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @seccion }
    end
  end

  # GET /secciones/1/edit
  def edit
    @seccion = Seccion.find(params[:id])
  end

  # POST /secciones
  # POST /secciones.xml
  def create
    @seccion = Seccion.new(params[:seccion])

    respond_to do |format|
      if @seccion.save
        format.html { redirect_to(secciones_path, :notice => 'La Secci&oacute;n   ha sido creado satisfactoriamente.') }
        format.xml  { render :xml => @seccion, :status => :created, :location => @seccion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @seccion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /secciones/1
  # PUT /secciones/1.xml
  def update
    @seccion = Seccion.find(params[:id])

    respond_to do |format|
      if @seccion.update_attributes(params[:seccion])
        format.html { redirect_to(secciones_path, :notice => 'La Secci&oacute;n  ha sido creado satisfactoriamente.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @seccion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /secciones/1
  # DELETE /secciones/1.xml
  def destroy
    @seccion = Seccion.find(params[:id])
    @seccion.destroy

    respond_to do |format|
      format.html { redirect_to(secciones_url) }
      format.xml  { head :ok }
    end
  end
end
