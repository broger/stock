class InventariosController < ApplicationController
  
  def ajuste_positivo
  	   @comprobante = Comprobante.ajuste_positivo.new
       @ajuste_pos = TipoComprobante.find(4).ultimo_nro .to_i + 1
      
	   respond_to do |format|
	      format.html # new.html.erb
	      format.xml  { render :xml => @comprobante }
	   end	

  end

  def ajuste_negativo

  end


  def tomar_inventario


  end

  def transferencia_sucursales

  end

end
