class ProductoStocksController < ApplicationController
  # GET /producto_stocks
  # GET /producto_stocks.xml
  def index
    @producto_stocks = ProductoStock.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @producto_stocks }
    end
  end

  # GET /producto_stocks/1
  # GET /producto_stocks/1.xml
  def show
    @producto_stock = ProductoStock.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @producto_stock }
    end
  end

  # GET /producto_stocks/new
  # GET /producto_stocks/new.xml
  def new
    @producto_stock = ProductoStock.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @producto_stock }
    end
  end

  # GET /producto_stocks/1/edit
  def edit
    @producto_stock = ProductoStock.find(params[:id])
  end

  # POST /producto_stocks
  # POST /producto_stocks.xml
  def create
  
    @producto_stock = ProductoStock.new(params[:producto_stock])
    raise "ddd"
    respond_to do |format|
      if @producto_stock.save
        format.html { redirect_to(@producto_stock, :notice => 'ProductoStock was successfully created.') }
        format.xml  { render :xml => @producto_stock, :status => :created, :location => @producto_stock }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @producto_stock.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /producto_stocks/1
  # PUT /producto_stocks/1.xml
  def update
    @producto_stock = ProductoStock.find(params[:id])

    respond_to do |format|
      if @producto_stock.update_attributes(params[:producto_stock])
        format.html { redirect_to(@producto_stock, :notice => 'ProductoStock was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @producto_stock.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /producto_stocks/1
  # DELETE /producto_stocks/1.xml
  def destroy
    @producto_stock = ProductoStock.find(params[:id])
    @producto_stock.destroy

    respond_to do |format|
      format.html { redirect_to(producto_stocks_url) }
      format.xml  { head :ok }
    end
  end
end
