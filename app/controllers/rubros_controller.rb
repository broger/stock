class RubrosController < ApplicationController
  # GET /rubros
  # GET /rubros.xml
  def index
    @rubros = Rubro.paginate(:page => params[:page],:per_page => 6,:order => "nombre")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rubros }
    end
  end

  # GET /rubros/1
  # GET /rubros/1.xml
  def show
    @rubro = Rubro.find(params[:id])

    respond_to do |format|
       format.html{render :layout=>false}
    end
  end

  # GET /rubros/new
  # GET /rubros/new.xml
  def new
    @rubro = Rubro.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rubro }
    end
  end

  # GET /rubros/1/edit
  def edit
    @rubro = Rubro.find(params[:id])
  end

  # POST /rubros
  # POST /rubros.xml
  def create
    @rubro = Rubro.new(params[:rubro])

    respond_to do |format|
      if @rubro.save
        format.html { redirect_to(@rubro, :notice => 'Rubro ha sido creado satisfactoriamente.') }
        format.xml  { render :xml => @rubro, :status => :created, :location => @rubro }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @rubro.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rubros/1
  # PUT /rubros/1.xml
  def update
    @rubro = Rubro.find(params[:id])

    respond_to do |format|
      if @rubro.update_attributes(params[:rubro])
        format.html { redirect_to(@rubro, :notice => 'Rubro ha sido actualizado satisfactoriamente.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rubro.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rubros/1
  # DELETE /rubros/1.xml
  def destroy
    @rubro = Rubro.find(params[:id])
    @rubro.destroy

    respond_to do |format|
      format.html { redirect_to(rubros_url) }
      format.xml  { head :ok }
    end
  end
end
