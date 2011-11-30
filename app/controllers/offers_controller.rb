class OffersController < ApplicationController
  # FIXME: this shouldn't be here
  skip_before_filter :verify_authenticity_token, :only => [:voting]

  # GET /offers
  # GET /offers.xml
  def index
    @offers = Offer.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @offers }
    end
  end

  # GET /offers/1
  # GET /offers/1.xml
  def show
    @offer = Offer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @offer }
    end
  end

  # GET /offers/new
  # GET /offers/new.xml
  def new
    @offer = Offer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @offer }
    end
  end

  # GET /offers/1/edit
  def edit
    @offer = Offer.find(params[:id])
  end

  # POST /offers
  # POST /offers.xml
  def create
    @offer = Offer.new(params[:offer])

    respond_to do |format|
      if @offer.save
        format.html { redirect_to(@offer, :notice => 'Offer was successfully created.') }
        format.xml  { render :xml => @offer, :status => :created, :location => @offer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @offer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /offers/1
  # PUT /offers/1.xml
  def update
    @offer = Offer.find(params[:id])

    respond_to do |format|
      if @offer.update_attributes(params[:offer])
        format.html { redirect_to(@offer, :notice => 'Offer was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @offer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /offers/1
  # DELETE /offers/1.xml
  def destroy
    @offer = Offer.find(params[:id])
    @offer.destroy

    respond_to do |format|
      format.html { redirect_to(offers_url) }
      format.xml  { head :ok }
    end
  end

  # POST /offers/1/voting
  def voting 
    offer = Offer.find(params[:id])
    user = current_user
    if params[:direction] == 'up'
      current_user.vote_exclusively_for(offer)
    elsif params[:direction] == 'down'
      current_user.vote_exclusively_against(offer)
    end
    votes = offer.votes_for - offer.votes_against
    render :json => "{'result' => 'OK', 'votes': #{votes}}"
  end

  # POST /offers/1/comment
  def comment
    @offer = Offer.find(params[:id])
    logger.info @offer
    logger.info params
    Comment.create(:user_id => current_user.id, :offer_id => @offer.id, :body => params[:comment][:body])
    redirect_to(@offer, :notice => 'Comment was successfully created.')
  end

end
