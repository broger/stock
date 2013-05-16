class MenusRolesController < ApplicationController
  # GET /menu_roles
  # GET /menu_roles.xml
  def index
    @menus_roles = MenusRol.all

      respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @menus_roles }
    end
  end

  # GET /menu_roles/1
  # GET /menu_roles/1.xml
  def show
    @menus_rol = MenusRol.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @menus_rol }
    end
  end

  # GET /menu_roles/new
  # GET /menu_roles/new.xml
  def new
    @menus_rol = MenusRol.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @menus_rol }
    end
  end

  # GET /menu_roles/1/edit
  def edit
    @menus_rol = MenusRol.find(params[:id])
  end

  # POST /menu_roles
  # POST /menu_roles.xml
  def create
    @menus_rol = MenusRol.new(params[:menus_rol])

    respond_to do |format|
      if @menus_rol.save
        format.html { redirect_to(@menus_rol, :notice => 'MenuRol was successfully created.') }
        format.xml  { render :xml => @menus_rol, :status => :created, :location => @menus_rol }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @menus_rol.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /menu_roles/1
  # PUT /menu_roles/1.xml
  def update
    @menus_rol = MenusRol.find(params[:id])

    respond_to do |format|
      if @menus_rol.update_attributes(params[:menu_rol])
        format.html { redirect_to(@menus_rol, :notice => 'MenuRol was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @menus_rol.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /menu_roles/1
  # DELETE /menu_roles/1.xml
  def destroy
    @menus_rol = MenusRol.find(params[:id])
    @menus_rol.destroy

    respond_to do |format|
      format.html { redirect_to(menu_roles_url) }
      format.xml  { head :ok }
    end
  end
end
