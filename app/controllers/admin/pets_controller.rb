module Admin
    class PetsController < BaseController
      def show
        @pet = Pet.find(params[:id])
      end
    end
  end
  