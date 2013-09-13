class TipoComprobantesController < ApplicationController
  # GET /tipo_comprobantes
  # GET /tipo_comprobantes.xml
  def index
    @tipo_comprobantes = TipoComprobante.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tipo_comprobantes }
    end
  end

  # GET /tipo_comprobantes/1
  # GET /tipo_comprobantes/1.xml
  def show
    @tipo_comprobante = TipoComprobante.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tipo_comprobante }
    end
  end

  # GET /tipo_comprobantes/new
  # GET /tipo_comprobantes/new.xml
  def new
    @tipo_comprobante = TipoComprobante.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tipo_comprobante }
    end
  end

  # GET /tipo_comprobantes/1/edit
  def edit
    @tipo_comprobante = TipoComprobante.find(params[:id])
  end

  # POST /tipo_comprobantes
  # POST /tipo_comprobantes.xml
  def create
    @tipo_comprobante = TipoComprobante.new(params[:tipo_comprobante])

    respond_to do |format|
      if @tipo_comprobante.save
        format.html { redirect_to(@tipo_comprobante, :notice => 'TipoComprobante was successfully created.') }
        format.xml  { render :xml => @tipo_comprobante, :status => :created, :location => @tipo_comprobante }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tipo_comprobante.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tipo_comprobantes/1
  # PUT /tipo_comprobantes/1.xml
  def update
    @tipo_comprobante = TipoComprobante.find(params[:id])

    respond_to do |format|
      if @tipo_comprobante.update_attributes(params[:tipo_comprobante])
        format.html { redirect_to(@tipo_comprobante, :notice => 'TipoComprobante was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tipo_comprobante.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tipo_comprobantes/1
  # DELETE /tipo_comprobantes/1.xml
  def destroy
    @tipo_comprobante = TipoComprobante.find(params[:id])
    @tipo_comprobante.destroy

    respond_to do |format|
      format.html { redirect_to(tipo_comprobantes_url) }
      format.xml  { head :ok }
    end
  end
end
