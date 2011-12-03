class OffersController < ApplicationController

  require 'process_offer'
  require 'screenchot'

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
    link = params[:offer][:link]

    if link.include?("www.infojobs.net")
      # process information
      result = process_offer("infojobs", link)
      params[:offer][:title] = result["title"]
      params[:offer][:description] = result["description"]
    end

    @offer = Offer.new(params[:offer])

    # process the screenshot
    filename = "/tmp/" + result["title"].gsub(/\s+/, "") + ".png"
    screenchot(link, filename)
    @offer.screenshot = File.new(filename)

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

    respond_to do |format|
      format.json { render :json => "{'result' => 'OK', 'votes': #{votes}}" }
    end
  end

end
