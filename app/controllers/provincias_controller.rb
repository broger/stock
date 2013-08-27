class ProvinciasController < ApplicationController

  before_filter :login_required

  # GET /provincias
  # GET /provincias.xml
  def index
      if params[:txtbuscar].blank?
         @provincias = Provincia.paginate(:page => params[:page],:per_page => 6,:order => "nombre")
      else
         @provincias = Provincia.paginate(:page => params[:page],:per_page => 6,:conditions=> ['lower(nombre) like lower(?)','%'+params[:txtbuscar]+'%'],:order => "nombre")
      end


      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @localidades }
      end
  end


  # GET /provincias/1
  # GET /provincias/1.xml
  def show
    @provincia = Provincia.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @provincia }
    end
  end

  # GET /provincias/new
  # GET /provincias/new.xml
  def new
    @provincia = Provincia.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @provincia }
    end
  end

  # GET /provincias/1/edit
  def edit
    @provincia = Provincia.find(params[:id])
  end

  # POST /provincias
  # POST /provincias.xml
  def create
    @provincia = Provincia.new(params[:provincia])

    respond_to do |format|
      if @provincia.save
        format.html { redirect_to(@provincia, :notice => 'Provincia  ha sido creada satisfactoriamente.') }
        format.xml  { render :xml => @provincia, :status => :created, :location => @provincia }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @provincia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /provincias/1
  # PUT /provincias/1.xml
  def update
    @provincia = Provincia.find(params[:id])

    respond_to do |format|
      if @provincia.update_attributes(params[:provincia])
        format.html { redirect_to(@provincia, :notice => 'Provincia  ha sido actualizada satisfactoriamente.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @provincia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /provincias/1
  # DELETE /provincias/1.xml
  def destroy
    @provincia = Provincia.find(params[:id])
    @provincia.destroy

    respond_to do |format|
      format.html { redirect_to(provincias_url) }
      format.xml  { head :ok }
    end
  end
end
