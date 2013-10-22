class RolesController < ApplicationController

  before_filter :login_required

  def index
    @roles = Rol.paginate(:page => params[:page],:per_page => 6,:order => "nombre")
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @roles }
    end
  end

  # GET /roles/1
  # GET /roles/1.xml
  def show
    @rol = Rol.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rol }
    end
  end

  # GET /roles/new
  # GET /roles/new.xml
  def new
    @rol = Rol.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rol }
    end
  end

  # GET /roles/1/edit
  def edit
    @rol = Rol.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rol }
    end
  end

  # POST /roles
  # POST /roles.xml
  def create
    @rol = Rol.new(params[:rol])

    respond_to do |format|
      if @rol.save
        format.html { redirect_to(@roles_url, :notice => 'EL rol #{@rol} ha sido creado satisfactoriomante.') }
        format.xml  { render :xml => @rol, :status => :created, :location => @rol }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @rol.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /roles/1
  # PUT /roles/1.xml
  def update
    @rol = Rol.find(params[:id])

    respond_to do |format|
      if @rol.update_attributes(params[:rol])
        format.html { redirect_to(@roles_url, :notice => 'EL rol #{@rol} ha sido actualizado satisfactoriomante.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rol.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.xml
  def destroy
    @rol = Rol.find(params[:id])
    @rol.destroy

    respond_to do |format|
      format.html { redirect_to(roles_url) }
      format.xml  { head :ok }
    end
  end
end
