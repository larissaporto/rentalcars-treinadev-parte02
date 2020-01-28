require 'rails_helper'

RSpec.describe IndividualClientMailer, type: :mailer do
  describe '.confirm' do
    it 'should send to client' do
      individual_client = create(:individual_client, name: 'Joca',
                                  cpf: '2342342423',
                                  email: 'joca@email.com')
      mail = IndividualClientMailer.confirm(individual_client.id)

      expect(mail.to).to include(individual_client.email)
    end

    it 'should send from rentalcars' do
      individual_client = create(:individual_client, name: 'Joca',
                                  cpf: '2342342423',
                                  email: 'joca@email.com')
      mail = IndividualClientMailer.confirm(individual_client.id)

      expect(mail.from).to include('confirmation-client@rentalcars.com')
    end

    it 'should send subject' do
      individual_client = create(:individual_client, name: 'Joca',
                                  cpf: '2342342423',
                                  email: 'joca@email.com')
      mail = IndividualClientMailer.confirm(individual_client.id)

      expect(mail.subject).to include("Cliente #{individual_client.name} cadastrado com sucesso")
    end

    it 'should send body' do
      individual_client = create(:individual_client, name: 'Joca',
                                  cpf: '2342342423',
                                  email: 'joca@email.com')
      mail = IndividualClientMailer.confirm(individual_client.id)

      expect(mail.body).to include("Olá #{individual_client.name}, seu cadastro foi realizado com sucesso")
    end
  end
end