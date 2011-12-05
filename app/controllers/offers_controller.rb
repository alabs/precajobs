class OffersController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]

  # GET /offers
  def index
    @offers = Offer.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /offers/1
  def show
    @offer = Offer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /offers/new
  def new
    @offer = Offer.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /offers/1/edit
  def edit
    @offer = Offer.find(params[:id])
  end

  # POST /offers
  def create
    @offer = Offer.new(params[:offer])

    respond_to do |format|
      if @offer.save
        format.html { redirect_to(@offer, :notice => 'La oferta se ha creado correctamente.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /offers/1
  def update
    @offer = Offer.find(params[:id])

    respond_to do |format|
      if @offer.update_attributes(params[:offer])
        format.html { redirect_to(@offer, :notice => 'La oferta se ha actualizado correctamente.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /offers/1
  def destroy
    @offer = Offer.find(params[:id])
    @offer.destroy

    respond_to do |format|
      format.html { redirect_to(offers_url) }
    end
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
    logger.info @offer
    logger.info params
    Comment.create(:user_id => current_user.id, :offer_id => @offer.id, :body => params[:comment][:body])
    redirect_to(@offer, :notice => 'El comentario se ha creado correctamente.')
  end

end
