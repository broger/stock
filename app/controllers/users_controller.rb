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
  end

  def create
    #logout_keeping_session!
    params[:usuario][:password]='123'
    params[:usuario][:password_confirmation]='123'
    @usuario = User.new(params[:usuario])
    success = @usuario && @usuario.save
    if success && @usuario.errors.empty?
      # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      #self.current_usuario = @usuario # !! now logged in
      #redirect_back_or_default('/')
      flash[:notice] = "Usuario agregado con exito."
      redirect_to(usuarios_url)
    else
      flash[:error]  = "No se pudo guardar el usuario."
      render :action => 'new'
    end
  end


  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
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
    @areas=[]
   end

    def update
    @usuario = User.find(params[:id])
                  if @usuario.update_attributes(params[:user])
                     @usuario.roles.clear
                     @usuario.rol_ids = params[:usuario][:rol_ids]
                     @usuario.update_attributes(params[:usuario])
                     @usuario.save!
                  end
                  redirect_to(users_url)
                  flash[:notice] = "El Usuario fue actualizado exitosamente."

    end


    def cambiar_clave
      @user = User.find(params[:id])
    end

    
    def guardar_clave
       @user = User.find(params[:id])
       @user.password = params[:user][:password]
       @user.password_confirmation = params[:user][:password_confirmation]
       @user.update_attributes(params[:user])
       respond_to do |format|
           if params[:user][:password] == params[:user][:password_confirmation]
              @user.save
              flash[:notice] = 'La contraseña se cambio con exito.'
              format.html { redirect_to(user_url(@user)) }
           else
              flash[:notice] = 'Hubo un error al cambiar la password.'
              format.html { redirect_to :action => "cambiarclave" }
           end
       end
    end



end
