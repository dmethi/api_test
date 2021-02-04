class DinosaursController < ApplicationController
  include Response
  include ExceptionHandler

  # GET /dinosaurs
  def index
    @dinos = Dinosaur.all
    json_response(@dinos)
  end

  # POST /dinosaurs
  def create
    @dino = Dinosaur.create!(dino_params)
    json_response(@dino, :created)
  end

  # POST /dinosaurs/filter

  # POST /dinosaurs/move_to_cage

  # GET /dinosaurs/:id

  # PUT /dinosaurs/:id

  # DELETE /dinosaurs/:id

  private

  def dino_params
    params.permit(:name, :is_carnivore, :species, :cage)
  end
end
