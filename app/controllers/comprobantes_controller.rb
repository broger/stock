class ComprobantesController < ApplicationController
  # GET /comprobantes
  # GET /comprobantes.xml
  def index
    @comprobantes = Comprobante.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comprobantes }
    end
  end

  # GET /comprobantes/1
  # GET /comprobantes/1.xml
  def show
    @comprobante = Comprobante.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comprobante }
    end
  end

  # GET /comprobantes/new
  # GET /comprobantes/new.xml
  def new
    @comprobante = Comprobante.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comprobante }
    end
  end

  # GET /comprobantes/1/edit
  def edit
    @comprobante = Comprobante.find(params[:id])
  end

  # POST /comprobantes
  # POST /comprobantes.xml
  def create
    @comprobante = Comprobante.new(params[:comprobante])

    respond_to do |format|
      if @comprobante.save
        format.html { redirect_to(@comprobante, :notice => 'Comprobante was successfully created.') }
        format.xml  { render :xml => @comprobante, :status => :created, :location => @comprobante }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comprobante.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /comprobantes/1
  # PUT /comprobantes/1.xml
  def update
    @comprobante = Comprobante.find(params[:id])

    respond_to do |format|
      if @comprobante.update_attributes(params[:comprobante])
        format.html { redirect_to(@comprobante, :notice => 'Comprobante was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comprobante.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comprobantes/1
  # DELETE /comprobantes/1.xml
  def destroy
    @comprobante = Comprobante.find(params[:id])
    @comprobante.destroy

    respond_to do |format|
      format.html { redirect_to(comprobantes_url) }
      format.xml  { head :ok }
    end
  end
end
