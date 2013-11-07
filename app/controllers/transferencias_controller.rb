class TransferenciasController < ApplicationController


  def index
    @transferencias = Comprobante.transferencia.paginate(:page => params[:page],:per_page => 6, :conditions=>{:tipo_comprobante_id => 6})
    

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @transferencias }
    end
  end

  def new
     @transferencia = Comprobante.transferencia.new
     @ult_transf = TipoComprobante.find(6).ultimo_nro.to_i + 1
      
	   respond_to do |format|
	      format.html # new.html.erb
	      format.xml  { render :xml => @comprobante }
	 end	
  end


end
