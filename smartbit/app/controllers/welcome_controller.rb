class WelcomeController < ApplicationController
	before_action :set_compra, only: [:comprado]
  def index
  end
  def comprar
  	@products = Product.all
  	respond_to do |format|

	  format.html # show.html.erb
	  format.json { render json: @products }

 end
  end
  def comprado
  	@products.update_attributes(:user_id=> current_user.id)
  	@mensaje = 'El bitcoin va a la alza, te recomendamos comprar la proxima semana'

  end
  private
     def set_compra
      @products = Product.find(params[:id])
    end

end
