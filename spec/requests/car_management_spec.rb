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
end
