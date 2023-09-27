class ChargesController < ApplicationController
  include Rails.application.routes.url_helpers

  def index
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
  end  
  def new
  end
  def success
  
  end  
  def pay
  end
  
  def create
    product = Product.find(params[:id])
    img = params[:image]
    product_image_url = url_for(product.image)

    price_in_cents = (product.price * 100).to_i
    @session = Stripe::Checkout::Session.create({
      customer_email: current_user.email,
      line_items: [{
        price_data: {
          currency: 'INR',
          product_data: {
            name: product.name,
            images: [ product_image_url]
          },
          unit_amount: price_in_cents ,
        },
        quantity: 1,
      }],
      mode: 'payment',
      success_url: "http://localhost:3000/success",
      cancel_url: root_url,
    })
    redirect_to charges_path(session_id: @session.id)
    
  end

end
