class CagesController < ApplicationController
  include Response
  include ExceptionHandler

  before_action :set_cage, only: [:show, :update, :destroy]
  before_action :set_num_dinos

  # GET /cages
  def index
    @cages = Cage.all
    json_response(@cages)
  end

  # POST /cages
  def create
    @cage = Cage.create!(cage_params)
    json_response(@cage, :created)
  end

  # POST /cages/filter
  def filter
    if params[:status] == 'DOWN'
      @cages = Cage.powered_off
    elsif params[:status] == 'ACTIVE'
      @cages = Cage.powered_on
    else
      raise Exception.new('Can only filter for statues that are "DOWN" or "ACTIVE"')
    end
    json_response(@cages)
  end

  # PUT /cages/:id
  def update
    ## edge case verification
    if params.has_key?(:status) && params[:status] == 'DOWN' && @cage.num_dinos > 0
      raise Exception.new("Cannot shut down cage with dinosaurs still in it")
      return
    end

    @cage.update(cage_params)
    json_response(@cage)
  end

  # GET /cages/:id
  def show
    json_response(@cage)
  end

  # DELETE /cages/:id
  def destroy
    @cage.destroy
    head :no_content
  end

  private

  def cage_params
    params.permit(:capacity, :status, :num_dinos)
  end

  def set_cage
    @cage = Cage.find(params[:id])
  end

  def set_num_dinos
    Cage.all.each do | cage |
      cage.num_dinos = Dinosaur.where({id: cage.id}).count
    end
  end
end
