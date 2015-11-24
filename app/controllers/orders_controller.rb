class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!


  # GET /orders
  # GET /orders.json
  def index
    if current_user.admin?
      @orders = Order.all
    else
      @orders = Order.where(:user_id => current_user.id).all
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.order_status_id = OrderStatus.find_by_status("未提交").id
    @order.user_id = current_user.id

    respond_to do |format|
      if @order.save
        format.html { redirect_to orders_url, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { redirect_to orders_url, alert: 'Order was not created.' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    @order.user_id = current_user.id
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to orders_url, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { redirect_to orders_url, alert: 'Order was not updated.' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    if (@order.user == current_user) or current_user.admin?
      @order.destroy
      respond_to do |format|
        format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  def push_to_review
    # send orders to admin to review
    respond_to do |format|
      begin
        orders = Order.find(params[:orders])
        orders.each do |o|
          if current_user == o.user and o.order_status.status == "未提交"
            o.order_status= OrderStatus.find_by_status("已提交平台")
            o.save
          end
        end
        format.json { render json: orders, status: :ok}
      rescue Exception => e
        format.json { render plain: e}
      end
    end
  end

  def push_to_customs
    # send orders to customs upstream system
    # call backend workers
  end

  def decline_order
    # order is declined, user need to do update
  end

  def is_origin_order_number_valid?
    respond_to do |format|
      if Order.where(:origin_order_number => params[:oo_id]).count == 0
        format.json { render plain: "true"}
      else
        format.json { render plain: "false"}
      end
    end
  end

  def is_origin_payment_number_valid?
    respond_to do |format|
      if Order.where(:origin_payment_number => params[:op_id]).count == 0
        format.json { render plain: "true"}
      else
        format.json { render plain: "false"}
      end
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(:order_status_id, :origin_order_number, :origin_payment_number, :customer_name,
                                  :phone, :id_number, :province, :city, :area, :street, :zip_code, :shipping_fee,
                                  order_products_attributes: [:product_id,:number, :custom_price, :_destroy, :id])
  end

end
