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

  # POST /dinosaurs/filter_by_species
  def filter_by_species
    @dinos = Dinosaur.where({species:(params[:species])})
    json_response(@dinos)
  end

  # POST /dinosaurs/filter_by_cage
  def filter_by_cage
    @dinos = Dinosaur.where({cage: params[:cage]})
    json_response(@dinos)
  end

  # PUT /dinosaurs/:id/move_to_cage
  def move_to_cage
    @cage = Cage.find(params[:cage])
    @dino = Dinosaur.find(params[:id])

    if @dino.cage == params[:cage]
      raise Exception.new('Error - Dinosaur already in cage')
      return
    end

    if @cage.status == 'DOWN' || @cage.capacity == @cage.num_dinos
      raise Exception.new('Error - Cannot add dinos to this cage at this time')
      return
    end
    ## check empty
    if @cage.num_dinos == 0
      @dino.update(add_to_cage_params)
      @cage.update(num_dinos: @cage.num_dinos + 1)
      json_response(@dino)
    else
      ##carnivore case
      if @dino.is_carnivore
        if Dinosaur.where({cage: (params[:cage])}).first.species == @dino.species
          @dino.update(add_to_cage_params)
          @cage.update(num_dinos: @cage.num_dinos + 1)
          json_response(@dino)
        else
          raise Exception.new('Error - Carnivores must be in cages with the same species')
        end
      ## herbivore case
      else
        if Dinosaur.where({cage: (params[:cage])}).first.is_carnivore == false
          @dino.update(add_to_cage_params)
          @cage.update(num_dinos: @cage.num_dinos + 1)
          json_response(@dino)
        else
          raise Exception.new('Error - Cage is not safe for herbivores')
        end
      end
    end
  end

  # GET /dinosaurs/:id
  def show
    json_response(Dinosaur.find(params[:id]))
  end

  # PUT /dinosaurs/:id
  def update
    @dino = Dinosaur.find(params[:id])
    @dino.update(update_params)
    json_response(@dino)
  end

  # DELETE /dinosaurs/:id
  def destroy
    @dino = Dinosaur.find(params[:id])
    @dino.destroy
    head :no_content
  end

  private

  def dino_params
    params.permit(:name, :is_carnivore, :species, :cage)
  end

  def update_params
    params.permit(:name, :is_carnivore, :species)
  end

  def add_to_cage_params
    params.permit(:cage)
  end
end
