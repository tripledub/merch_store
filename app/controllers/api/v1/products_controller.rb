module Api
  module V1
    class ProductsController < ApplicationController
      def index
        json_response(Product.all)
      end

      def update
        Product.find(params[:id]).tap do |product|
          json_response(product) if product.update!(product_params)
        end
      end

      private

      def product_params
        params.require(:product).permit(:price)
      end
    end
  end
end
