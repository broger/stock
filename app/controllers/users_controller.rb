class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead

  #before_filter :login_required

  include AuthenticatedSystem
  

   def index
    @usuario = User.new
    if params[:txtbuscar].blank?
       @usuarios = User.paginate(:page => params[:page],:per_page => 6,:order => 'name')
    else
       @usuarios = User.paginate(:page => params[:page],:per_page => 6,:conditions=> ['lower(name) like lower(?)','%'+params[:txtbuscar]+'%'],:order => "name")
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @usuarios }
    end
  end


   def new
       @usuario = User.new
       @roles = Rol.find(:all)

       respond_to do |format|
        format.html{render :layout=>false}
      end
  end

  def create
    params[:user][:password] = Parametro.first.password
    params[:user][:password_confirmation] = Parametro.first.password
    @user = User.new(params[:user])
    @user.activated_at = Date.strptime(params[:user][:activated_at], "%d/%m/%Y")
    @user.sucursal_id = params[:user][:sucursal_id]
        

    success = @user && @user.save
    if @user.update_attributes(params[:user])
                     @user.rol_ids = params[:user][:rol_ids]
                     @user.update_attributes(params[:user])
                     @user.save!
                  end

    if success && @user.errors.empty?
      # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      #self.current_usuario = @usuario # !! now logged in
      #redirect_back_or_default('/')
      flash[:notice] = "Usuario agregado con exito."
      redirect_to(users_url)
    else
      flash[:error]  = "No se pudo guardar el usuario."
      render :action => 'new'
    end
  end


  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      flash[:notice] = "Signup complete! Please sign in to continue."
      redirect_to '/login'
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_back_or_default('/')
    else 
      flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      redirect_back_or_default('/')
    end
  end


   def edit
    @usuario = User.find(params[:id])
    @roles = Rol.find(:all)
   end

    def update

    @usuario = User.find(params[:id])
                  if @usuario.update_attributes(params[:user])
                     @usuario.activated_at = params[:user][:activated_at]
                     @usuario.roles.clear
                     @usuario.rol_ids = params[:usuario][:rol_ids]
                     @usuario.update_attributes(params[:usuario])
                     @usuario.save!
                  end
                  redirect_to(users_url)
                  flash[:notice] = "El Usuario fue actualizado exitosamente."

    end


    def editar_x_usuario
        @user = User.find(params[:id])

        respond_to do |format|
            format.html{render :layout=>false}
        end
    end

    
    def guardar_x_usuario
       @user = User.find(params[:id])
       @user.password = params[:user][:password]
       @user.password_confirmation = params[:user][:password_confirmation]
       @user.email = params[:user][:email]
       @user.direccion = params[:user][:direccion]
       @user.celular = params[:user][:celular]
       @user.telefono = params[:user][:telefono]
       @user.update_attributes(params[:user])
       respond_to do |format|
           if params[:user][:password] == params[:user][:password_confirmation]
              @user.save!
              flash[:notice] = 'Los datos se actualizaron satisfactoriamente.'
              format.html { redirect_to(root_url()) }
           else
              flash[:notice] = 'Hubo un error al cambiar los datos.'
              format.html { redirect_to :action => "cambiarclave" }
           end
       end
    end

    def destroy
    @user = User.find(params[:id])
     
    respond_to do |format|
         if @user.puedo_eliminarlo?
            @user.destroy
            format.html { redirect_to(users_path, :notice => "El usuario ha sido eliminado satisfactoriamente.") }
          else
            format.html { redirect_to(users_path, :notice => "El usuario no se ha podido eliminar porque existen datos relacionados a &eacute;l, puedo asignarle estado igual a baja desde editar registro.") }
          end
    end
  end


end