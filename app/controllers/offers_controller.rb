# encoding: utf-8
class OffersController < ApplicationController

  require 'will_paginate/array'

  #before_filter :authenticate_user!, :except => [:index, :show, :last, :vote]

  # GET /offers
  def index
    offers = Offer.all(:order => "created_at desc")
    @offers = offers.paginate(:page => params[:page])
    @title = "Peores ofertas"
  end

  # GET /offers/last
  def worst
    offers = Offer.all(:order => "votes_count desc")
    @offers = offers.paginate(:page => params[:page])
    @title = "Últimas ofertas"
    render 'index'
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

    if verify_recaptcha(:model => @offer, :timeout => 15) and @offer.save
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

    logger.debug request.inspect
    if params[:direction] == 'down'
      offer.votes.create(:ip_address => request.remote_ip)
    end

    render :json => {'result' => 'OK', 'votes' => offer.votes.count }
  end

  # POST /offers/1/comment
  def comment
    @offer = Offer.find(params[:id])
    @comment = Comment.new(:offer_id => @offer.id, :body => params[:comment][:body])
    if verify_recaptcha(:model => @comment, :message => "El captcha está incorrecto", :timeout => 10) and @comment.save
      flash[:notice] = 'El comentario se ha creado correctamente.'
      redirect_to @offer
    else
      flash[:notice] = 'Ha habido un problema con el captcha.'
      redirect_to @offer
    end
  end

end
