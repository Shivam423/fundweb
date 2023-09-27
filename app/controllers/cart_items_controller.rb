class CartItemsController < ApplicationController
    before_action :authenticate_user!
    def index
        @cart_item = current_user.cart_items.all
        @cart = calculate_total()
    end

    def create
        @cart_item = current_user.cart_items.build(product_id: params[:product_id])
        @cart_item.save
        redirect_to cart_items_path, notice: 'Item added to cart'
    end

    def destroy
        @cart_item = current_user.cart_items.find(params[:id])
        @cart_item.destroy
        redirect_to cart_items_path, notice: 'Item removed from cart'
    end

    def checkout
        order = current_user.orders.create(total: calculate_total)
        current_user.cart_items.update_all(order_id: order.id,user_id: current_user.id)
        # current_user.cart_items.delete_all
        #OrderConfirmationJob.perform_later(current_user)
        # toastr.success('Order successfully created!')
        redirect_to root_path, notice: 'Order placed successfully'
    end


    private

    def calculate_total 
        current_user.cart_items.sum { |item| item.product.price * item.quantity=1 }
    end
end
