class ClientesController < ApplicationController


  def index
    if params[:txtbuscar].blank?
       @clientes = Cliente.paginate(:page => params[:page],:per_page => 6,:order => "nombre")
    else
       @clientes = Cliente.paginate(:page => params[:page],:per_page => 6,:conditions=> ['lower(nombre) like lower(?)','%'+params[:txtbuscar]+'%'],:order => "nombre")
    end

    @busqueda = params[:txtbuscar]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @clientes }
    end
  end


  def show
    @cliente = Cliente.find(params[:id])

    respond_to do |format|
      format.html{render :layout=>false}
    end
  end

  # GET /clientes/new
  # GET /clientes/new.xml
  def new
    @cliente = Cliente.new
 
    respond_to do |format|
      format.html{render :layout=>false}
    end
  end

  # GET /clientes/1/edit
  def edit
    @cliente = Cliente.find(params[:id])
    respond_to do |format|
      format.html{render :layout=>false}
    end
  end

  # POST /clientes
  # POST /clientes.xml
  def create
    @cliente = Cliente.new(params[:cliente])

    respond_to do |format|
      if @cliente.save
        format.html { redirect_to(clientes_path, :notice => "El cliente #{@cliente.nombre} ha sido creado satisfactoriamente.") }
        format.xml  { render :xml => @cliente, :status => :created, :location => @cliente }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cliente.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /clientes/1
  # PUT /clientes/1.xml
  def update
    @cliente = Cliente.find(params[:id])

    respond_to do |format|
      if @cliente.update_attributes(params[:cliente])
        format.html { redirect_to(clientes_path, :notice => "El cliente #{@cliente.nombre} ha sido actualizado satisfactoriamente.") }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cliente.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /clientes/1
  # DELETE /clientes/1.xml
  def destroy
    @cliente = Cliente.find(params[:id])
    control = Comprobante.find(:all, :conditions=>{:cliente_id => params[:id]})

    respond_to do |format|
         if control.blank?
            @cliente.destroy
            format.html { redirect_to(clientes_path, :notice => "El cliente #{@cliente.nombre} ha sido eliminado satisfactoriamente.") }
            format.xml  { render :xml => @cliente, :status => :created, :location => @cliente }
          else
            format.html { redirect_to(clientes_path, :notice => "El cliente no se ha podido eliminar porque existen datos relacionados a este registro, puedo asignarle estado igual a baja desde editar registro.") }
          end
    end
  end



  def baja(id)

       a = Cliente.find(id)
       a.estado_id = 2
       a.save!

      redirect_to(clientes_path,:notice => "El cliente #{a.nombre} ahora se encuentra con estado igual a Baja.")    
  end



end #final