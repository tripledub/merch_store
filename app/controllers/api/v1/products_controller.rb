module Api
  module V1
    class ProductsController < ApplicationController
      def index
        json_response(Product.all)
      end

      def update
        # debugger
        Product.find(params[:id]).tap do |product|
          json_response(product) if product.update!(product_params)
        end
      end

      private

      def product_params
        product_params = params[:product]
        if product_params
          product_params.permit(
            :price
          )
        else
          {}
        end
      end
    end
  end
end
