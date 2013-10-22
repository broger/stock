class ConceptoOperacionesController < ApplicationController
  # GET /concepto_operacions
  # GET /concepto_operacions.xml
  def index
    @concepto_operaciones = ConceptoOperacion.paginate(:page => params[:page],:per_page => 6,:order => "nombre")
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @concepto_operaciones }
    end
  end

  # GET /concepto_operacions/1
  # GET /concepto_operacions/1.xml
  def show
    @concepto_operacion = ConceptoOperacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @concepto_operacion }
    end
  end

  # GET /concepto_operacions/new
  # GET /concepto_operacions/new.xml
  def new
    @concepto_operacion = ConceptoOperacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @concepto_operacion }
    end
  end

  # GET /concepto_operacions/1/edit
  def edit
    @concepto_operacion = ConceptoOperacion.find(params[:id])
  end

  # POST /concepto_operacions
  # POST /concepto_operacions.xml
  def create
    @concepto_operacion = ConceptoOperacion.new(params[:concepto_operacion])

    respond_to do |format|
      if @concepto_operacion.save
        format.html { redirect_to(@concepto_operacion, :notice => 'ConceptoOperacion was successfully created.') }
        format.xml  { render :xml => @concepto_operacion, :status => :created, :location => @concepto_operacion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @concepto_operacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /concepto_operacions/1
  # PUT /concepto_operacions/1.xml
  def update
    @concepto_operacion = ConceptoOperacion.find(params[:id])

    respond_to do |format|
      if @concepto_operacion.update_attributes(params[:concepto_operacion])
        format.html { redirect_to(@concepto_operacion, :notice => 'ConceptoOperacion was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @concepto_operacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /concepto_operacions/1
  # DELETE /concepto_operacions/1.xml
  def destroy
    @concepto_operacion = ConceptoOperacion.find(params[:id])
    @concepto_operacion.destroy

    respond_to do |format|
      format.html { redirect_to(concepto_operacions_url) }
      format.xml  { head :ok }
    end
  end
end
