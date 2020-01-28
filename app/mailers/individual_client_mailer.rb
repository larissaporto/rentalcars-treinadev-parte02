class IndividualClientMailer < ApplicationMailer
  default from: 'confirmation-client@rentalcars.com'
  def confirm(client_id)
    @costumer = IndividualClient.find(client_id)
    mail(to: @costumer.email, subject: "Cliente #{@costumer.name} cadastrado com sucesso")
  end
end