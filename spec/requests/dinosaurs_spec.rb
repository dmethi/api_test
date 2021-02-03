# require 'rails_helper'
#
# RSpec.describe 'Dinsoaurs API' do
#   # Initialize test data
#   let!(:cage) {create (:cage)}
#   let!(:dinosaurs) {create_list(:item, 30, cage_id: cage.id)}
#   let(:cage_id) {cage.id}
#   let(:dinosaur_id) {dinosaurs.first.id}
#
#   # Test suite for GET/dinosaurs
#   describe 'GET /dinosaurs' do
#     before { get '/dinosaurs'}
#
#     context 'when dinosaurs exist' do
#       it 'returns status code 200' do
#         expect(response).to have_http_status(200)
#       end
#
#       it 'returns all dinosaurs' do
#         expect(json.size).to eq(30)
#       end
#     end
#
#     context 'when dinosaurs do not exist' do
#       let (:dinosaurs) {nil}
#
#       it 'returns status code 404' do
#         expect(response).to have_http_status(404)
#       end
#     end
#   end
#
#   # Test suite for POST/dinosaurs
#   describe 'POST /dinosaurs' do
#     let(:valid_attributes) { {name: 'Joe',  species: 'T-rex', is_carnivore: false, cage: 0} }
#
#     context 'when request attributes are valid' do
#       before { post '/dinosaurs', params: valid_attributes}
#
#       it 'returns status code 201' do
#         expect(response).to have_http_status(201)
#       end
#     end
#
#     context 'when request is invalid' do
#       before {post '/dinosaurs', params: {}}
#
#       it 'returns status code 422' do
#         expect(response).to have_http_status(422)
#       end
#     end
#   end
#
#   # Test suite for POST/dinosaurs/filter
#
#   # Test suite for POST/dinosaurs/add_to_cage
#
#   # Test suite for GET/dinosaurs/:id
#   describe 'GET /dinosaurs/:id' do
#     before { get '/dinosaurs/#{dinosaur_id}'}
#
#     context 'when dinosaur exists' do
#       it 'returns status code 200' do
#         expect(response).to have_http_status(200)
#       end
#
#       it 'returns the item' do
#         expect(json['id']).to eq(dinosaur_id)
#       end
#     end
#
#     context 'when the dinosaur does not exist' do
#       let(:dinosaur_id) {0}
#
#       it 'returns status code 404' do
#         expect(response).to have_http_status(404)
#       end
#     end
#   end
#
#   # Test suite for PUT/dinosaurs/:id
#   describe 'PUT /dinosaurs/:id' do
#     let(:valid_attributes) { {name: 'dmeth'} }
#
#     before { put '/dinosaurs/#{dinosaur_id}', params: valid_attributes}
#
#     context 'when item exists' do
#       it 'returns status code 204' do
#         expect(response).to have_http_status(204)
#       end
#
#       it 'updates the dinosaur' do
#         updated_dinosaur = Dinosaur.find(id)
#         expect(updated_dinosaur.name).to match(/dmeth/)
#       end
#     end
#
#     context 'when the item does not exist' do
#       let(:dinosaur_id) {0}
#
#       it 'returns status code 404' do
#         expect(response).to have_http_status(404)
#       end
#     end
#   end
#
#   # Test suite for DELETE/dinosaurs/:id
#   describe 'DELETE /dinosaur/:id' do
#     before {delete '/dinosaur/#{dinosaur_id}'}
#
#     it 'returns status code 204' do
#       expect(response).to have_http_status(204)
#     end
#   end
# end
