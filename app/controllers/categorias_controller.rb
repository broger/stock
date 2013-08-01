class CategoriasController < ApplicationController
  
  before_filter :login_required

  # GET /categorias
  # GET /categorias.xml
  def index
     if params[:txtbuscar].blank?
       @categorias = Categoria.paginate(:page => params[:page],:per_page => 6, :order => "nombre")
    else
       @categoria = Categoria.paginate(:page => params[:page],:per_page => 6, :conditions=> ['lower(nombre) like lower(?)','%'+params[:txtbuscar]+'%'],:order => "nombre")
    end


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @localidades }
    end
  end

  # GET /categorias/1
  # GET /categorias/1.xml
  def show
    @categoria = Categoria.find(params[:id])

    respond_to do |format|
       format.html{render :layout=>false}
    end
  end

  # GET /categorias/new
  # GET /categorias/new.xml
  def new
    @categoria = Categoria.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @categoria }
    end
  end

  # GET /categorias/1/edit
  def edit
    @categoria = Categoria.find(params[:id])
  end

  # POST /categorias
  # POST /categorias.xml
  def create
    @categoria = Categoria.new(params[:categoria])

    respond_to do |format|
      if @categoria.save
        format.html { redirect_to(categorias_path, :notice => 'La Categoria ha sido creada satisfactoriamente.') }
        format.xml  { render :xml => @categoria, :status => :created, :location => @categoria }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @categoria.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /categorias/1
  # PUT /categorias/1.xml
  def update
    @categoria = Categoria.find(params[:id])

    respond_to do |format|
      if @categoria.update_attributes(params[:categoria])
        format.html { redirect_to(categoria_path, :notice => 'la Categoria ha sido actualizada satisfactoriamente.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @categoria.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /categorias/1
  # DELETE /categorias/1.xml
  def destroy
    @categoria = Categoria.find(params[:id])
    @categoria.destroy

    respond_to do |format|
      format.html { redirect_to(categorias_url) }
      format.xml  { head :ok }
    end
  end
end
