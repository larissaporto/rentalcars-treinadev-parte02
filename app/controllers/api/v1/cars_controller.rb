class Api::V1::CarsController < Api::V1::ApiController
  def show
    @car = Car.find(params[:id])
    
    render json: @car.as_json(method: :url_for(@car.image))
  end

  def index
    @cars = Car.all
    render json: @cars
  end

  def create
    @car = Car.create(params.permit(%i[car_model_id car_km color license_plate subsidiary_id image]))
    if @car.valid?
      return render json: @car, status: 201 if @car.persisted?
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