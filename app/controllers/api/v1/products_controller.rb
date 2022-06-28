module Api
  module V1
    class ProductsController < ApplicationController
      def index
        json_response(Product.all)
      end
    end
  end
end
