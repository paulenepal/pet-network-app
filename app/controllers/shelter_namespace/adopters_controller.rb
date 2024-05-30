module ShelterNamespace
  class AdoptersController < BaseController
      def show
          @adopter = Adopter.find(params[:id])
        end
      end
  end
