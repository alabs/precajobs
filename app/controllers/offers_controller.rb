class OffersController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]

  # GET /offers
  def index
    @offers = Offer.all
  end

  # GET /offers/last
  def last
    @offers = Offer.all(:order => "created_at desc")
  end

  # GET /offers/1
  def show
    @offer = Offer.find(params[:id])
  end

  # GET /offers/new
  def new
    @offer = Offer.new
  end

  # GET /offers/1/edit
  def edit
    @offer = Offer.find(params[:id])
  end

  # POST /offers
  def create
    @offer = Offer.new(params[:offer])

    if @offer.save
      flash[:notice] = 'La oferta se ha creado correctamente.'
      redirect_to @offer
    else
      render :action => "new"
    end

  end

  # PUT /offers/1
  def update
    @offer = Offer.find(params[:id])

    if @offer.update_attributes(params[:offer])
      flash[:notice] = 'La oferta se ha actualizado correctamente.'
      redirect_to @offer 
    else
      render :action => "edit" 
    end
  end

  # DELETE /offers/1
  def destroy
    @offer = Offer.find(params[:id])
    @offer.destroy

    redirect_to offers_url
  end

  # POST /offers/1/voting
  def vote
    offer = Offer.find(params[:id])

    if params[:direction] == 'up'
      current_user.vote_exclusively_for(offer)
    elsif params[:direction] == 'down'
      current_user.vote_exclusively_against(offer)
    end

    votes = offer.votes_for - offer.votes_against
    render :json => {'result' => 'OK', 'votes' => votes }
  end

  # POST /offers/1/comment
  def comment
    @offer = Offer.find(params[:id])
    Comment.create(:user_id => current_user.id, :offer_id => @offer.id, :body => params[:comment][:body])
    flash[:notice] = 'El comentario se ha creado correctamente.'
    redirect_to @offer
  end

end
