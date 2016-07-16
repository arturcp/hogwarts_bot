require 'rails_helper'

describe 'Score points', type: :request do
  context 'Slack webhook captures points trigger keywords' do
    it 'concedes points to the specified house' do
      create(:house, :ravenclaw)
      post '/point', params: { text: '5 points to Ravenclaw because they helped me a lot' }

      json = JSON.parse(response.body, symbolize_names: true)
      message = 'Ravenclaw has now 5 points! See the house cup dashboard in www.dashboard.com.br'
      expect(json[:text]).to eq(message)
      expect(json.count).to be_eql(1)
    end

    it 'renders an empty json with the message is invalid' do
      post '/point'

      json = JSON.parse(response.body, symbolize_names: true)
      message = 'Oops. Algo deu errado na contagem dos pontos =/ É melhor você procurar o Dumbledore.'
      expect(json[:text]).to eq(message)
    end
  end
end
