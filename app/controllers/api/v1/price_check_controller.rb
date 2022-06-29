module Api
  module V1
    class PriceCheckController < ApplicationController
      def create
        # debugger
        PriceCheck.new(items: query_params[:items]).total.tap do |total|
          json_response(total)
        end
      end

      private

      def query_params
        # puts params
        params.require(:query).permit(items: {}).to_h || {}
      end
    end
  end
end
