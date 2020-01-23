require 'rails_helper'

describe 'Car Management' do
  context 'show' do
    it 'renders car correctly' do
      car = create(:car)

      get api_v1_car_path(car)
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json[:car_model_id]).to eq(car.car_model_id)
      expect(json[:car_km]).to eq(car.car_km)
      expect(json[:license_plate]).to eq(car.license_plate)
      expect(json[:status]).to eq(car.status)
      expect(json[:subsidiary_id]).to eq(car.subsidiary_id)
      expect(json[:color]).to eq(car.color)
    end

    it 'car not found' do
      get api_v1_car_path(999)

      expect(response).to have_http_status(:not_found)
    end
  end
  context 'index' do
    it 'render car index' do
      car = create_list(:car, 7)

      get api_v1_cars_path
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json[0][:car_model_id]).to eq(car.first.car_model_id)
      expect(json[0][:car_km]).to eq(car.first.car_km)
      expect(json[0][:license_plate]).to eq(car[0].license_plate)
      expect(json[0][:status]).to eq(car[0].status)
      expect(json[0][:subsidiary_id]).to eq(car[0].subsidiary_id)
      expect(json[0][:color]).to eq(car[0].color)

      expect(json[1][:car_model_id]).to eq(car[1].car_model_id)
      expect(json[1][:car_km]).to eq(car[1].car_km)
      expect(json[1][:license_plate]).to eq(car[1].license_plate)
      expect(json[1][:status]).to eq(car[1].status)
      expect(json[1][:subsidiary_id]).to eq(car[1].subsidiary_id)
      expect(json[1][:color]).to eq(car[1].color)

      expect(json[2][:car_model_id]).to eq(car[2].car_model_id)
      expect(json[2][:car_km]).to eq(car[2].car_km)
      expect(json[2][:license_plate]).to eq(car[2].license_plate)
      expect(json[2][:status]).to eq(car[2].status)
      expect(json[2][:subsidiary_id]).to eq(car[2].subsidiary_id)
      expect(json[2][:color]).to eq(car[2].color)
    end

    it 'car not found' do
      get api_v1_cars_path
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to be_empty
    end
  end

  context 'post' do
    it 'should create car' do
      car_model = create(:car_model)
      subsidiary = create(:subsidiary)

      post api_v1_cars_path, params: {car_model_id: car_model.id, subsidiary_id: subsidiary.id,
                                     car_km: 200, license_plate: "ABC-1234", color: "Branco"}
       
      json = JSON.parse(response.body, symbolize_names: true)
                               
      expect(response).to have_http_status(201)
      
      car_last = Car.last
      expect(car_last.license_plate).to eq("ABC-1234")
      
      expect(json[:car_model_id]).to eq(car_model.id)
      expect(json[:car_km]).to eq(200)

    end
    it 'should not be blank' do
      post api_v1_cars_path

      expect(response).to have_http_status(412)
    end

    it 'should change car count' do
      car_model = create(:car_model)
      subsidiary = create(:subsidiary)

      expect{
        post api_v1_cars_path, params: {car_model_id: car_model.id, subsidiary_id: subsidiary.id,
                                     car_km: 200, license_plate: "ABC-1234", color: "Branco"}
             }.to change(Car, :count).by(1)                   
    end
  end
  context 'patch' do
    it 'should update car' do
      car = create(:car, license_plate:'ABC-0987')

      patch api_v1_car_path(car), params: {license_plate: 'DEF-1234'}
      car.reload

      expect(response).to have_http_status(200)
      expect(car.license_plate).to eq("DEF-1234")

    end

    it 'should not create another car' do
      car = create(:car, license_plate:'ABC-0987')

      expect{
        patch api_v1_car_path(car), params: {license_plate: 'DEF-1234'}
             }.to change(Car, :count).by(0)    

    end
  end
end
