class MarcasRubrosController < ApplicationController
  # GET /marcas_rubros
  # GET /marcas_rubros.xml
  def index
    @marcas_rubros = MarcasRubro.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @marcas_rubros }
    end
  end

  # GET /marcas_rubros/1
  # GET /marcas_rubros/1.xml
  def show
    @marcas_rubro = MarcasRubro.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @marcas_rubro }
    end
  end

  # GET /marcas_rubros/new
  # GET /marcas_rubros/new.xml
  def new
    @marcas_rubro = MarcasRubro.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @marcas_rubro }
    end
  end

  # GET /marcas_rubros/1/edit
  def edit
    @marcas_rubro = MarcasRubro.find(params[:id])
  end

  # POST /marcas_rubros
  # POST /marcas_rubros.xml
  def create
    @marcas_rubro = MarcasRubro.new(params[:marcas_rubro])

    respond_to do |format|
      if @marcas_rubro.save
        format.html { redirect_to(@marcas_rubro, :notice => 'MarcasRubro was successfully created.') }
        format.xml  { render :xml => @marcas_rubro, :status => :created, :location => @marcas_rubro }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @marcas_rubro.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /marcas_rubros/1
  # PUT /marcas_rubros/1.xml
  def update
    @marcas_rubro = MarcasRubro.find(params[:id])

    respond_to do |format|
      if @marcas_rubro.update_attributes(params[:marcas_rubro])
        format.html { redirect_to(@marcas_rubro, :notice => 'MarcasRubro was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @marcas_rubro.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /marcas_rubros/1
  # DELETE /marcas_rubros/1.xml
  def destroy
    @marcas_rubro = MarcasRubro.find(params[:id])
    @marcas_rubro.destroy

    respond_to do |format|
      format.html { redirect_to(marcas_rubros_url) }
      format.xml  { head :ok }
    end
  end
end
