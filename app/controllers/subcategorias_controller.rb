class SubcategoriasController < ApplicationController
  # GET /subcategorias
  # GET /subcategorias.xml
  def index
    @subcategorias = Subcategoria.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @subcategorias }
    end
  end

  # GET /subcategorias/1
  # GET /subcategorias/1.xml
  def show
    @subcategoria = Subcategoria.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @subcategoria }
    end
  end

  # GET /subcategorias/new
  # GET /subcategorias/new.xml
  def new
    @subcategoria = Subcategoria.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @subcategoria }
    end
  end

  # GET /subcategorias/1/edit
  def edit
    @subcategoria = Subcategoria.find(params[:id])
  end

  # POST /subcategorias
  # POST /subcategorias.xml
  def create
    @subcategoria = Subcategoria.new(params[:subcategoria])

    respond_to do |format|
      if @subcategoria.save
        format.html { redirect_to(@subcategoria, :notice => 'Subcategoria was successfully created.') }
        format.xml  { render :xml => @subcategoria, :status => :created, :location => @subcategoria }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @subcategoria.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /subcategorias/1
  # PUT /subcategorias/1.xml
  def update
    @subcategoria = Subcategoria.find(params[:id])

    respond_to do |format|
      if @subcategoria.update_attributes(params[:subcategoria])
        format.html { redirect_to(@subcategoria, :notice => 'Subcategoria was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @subcategoria.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /subcategorias/1
  # DELETE /subcategorias/1.xml
  def destroy
    @subcategoria = Subcategoria.find(params[:id])
    @subcategoria.destroy

    respond_to do |format|
      format.html { redirect_to(subcategorias_url) }
      format.xml  { head :ok }
    end
  end
end
