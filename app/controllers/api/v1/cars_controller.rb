class Api::V1::CarsController < Api::V1::ApiController
  def show
    @car = Car.find(params[:id])
    render json: @car
  end

  def index
    @cars = Car.all
    render json: @cars
  end

  def create
    @car = Car.create(params.permit(%i[car_model_id car_km color license_plate subsidiary_id]))
    if @car.valid?
      if @car.persisted?
        render json: @car, status: 201
      end
    else
      head 412
    end
  end

  def update
    @car = Car.find(params[:id])
    @car.update(params.permit(%i[car_model_id car_km color license_plate subsidiary_id]))
    render json: @car
  end

  def destroy
    @car = Car.find(params[:id])
    @car.destroy
    render json: {body: "Carro deletado com sucesso"}, status: 200
  end
end