class CarEvaluationsController < ApplicationController
  before_action :load_fields, only: [:new]

  def new
  end

  def create
    @evaluation_price = PriceModel.predict(params[:car])
  end

  private

    def load_fields
      @body_type = ["Cabrio", "Combi", "Compact", "Coupe", "Sedan", "SUV", "Small car", "Minivan"]
      @gearbox_type = ["Manual", "Automatic"]
      @transmition_type = ["Front", "Rear", "4x4"]
      @fuel_type = ["Petrol", "Diesel", "GPL", "Petrol + GPL", "Electric", "Hybrid"]
    end

end
