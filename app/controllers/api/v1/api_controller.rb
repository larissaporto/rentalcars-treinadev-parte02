class Api::V1::ApiController < ActionController::API
rescue_from ActiveRecord::RecordNotFound, with: :show_errors
rescue_from ActiveRecord::RecordInvalid, with: :show_errors

private

  def show_errors
    render json: {body: "Não encontrado"}, status: 404
  end
end
