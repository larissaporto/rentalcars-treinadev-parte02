class Api::V1::CarsController < Api::V1::ApiController
  def show
    @car = Car.find_by(params[:id])
    if @car.blank?
      head 404
    else
      render json: @car
    end
  end

  def index
    @cars = Car.all
    render json: @cars
  end
end