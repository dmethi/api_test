require 'rails_helper'

RSpec.describe 'Cages API', type: :request do
  #initialize test data
  let!(:cages) {create_list(:cage, 10)}
  let(:cage_id) {cages.first.id}

  # Test suite for GET/cages
  describe 'GET /cages' do
    before {get '/cages'}

    it 'returns cages' do
      expect(json).not_to_be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

  end

  # Test suite for POST/cages
  describe 'POST /cages' do
    # test valid attributes
    let(:valid_attributes) { {capacity: 25, status: 'DOWN', num_dinos: 0} }

    context 'when the request is valid' do
      before { post '/cages', params: valid_attributes }

      it 'creates a cage' do
        expect(json['capacity']).to eq(25)
      end

      it 'returns a status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before {post '/cages', params: {status: 'DOWN', num_dinos: 0} }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Capacity can't be blank/)
      end
    end
  end

  # Test suite for POST/cages/filter
  # unsure how to test -- tested through manual testing

  # Test suite for PUT/cages/:id
  describe 'PUT /cages/:id' do
    let(:valid_attributes) {{capacity: 30}}

    context 'when the record exists' do
      before {put '/cages/#{cage_id}', params: valid_attributes}

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when the record does not exist' do
      before {put '/cages/#{38192}', params: valid_attributes}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  # Test suite for GET/cages/:id
  describe 'GET /cages/:id' do
    before {get 'cages/#{cage_id}'}

    context 'when the record exists' do
      it 'returns the cage' do
        expect(json).not_to_be_empty
        expect(json['id']).to eq(cage_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:cage_id) {12345}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Cage/)
      end
    end
  end

  # Test suite for DELETE/cages/:id
  describe 'DELETE /cages/:id' do
    before {delete '/cages/#{cage_id}'}

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
