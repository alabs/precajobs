require 'test_helper'

class OffersControllerTest < ActionController::TestCase
  setup do
    @offer = offers(:one)
    @user = users(:one)
    @user.confirm!
  end

  # anonymous

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:offers)
  end

  test "shouldn't get new as anonymous" do
    get :new
    assert_response :redirect
  end

  test "shouldn't create offer as anonymous" do
    post :create, :offer => @offer.attributes
    assert_response :redirect
  end

  test "should show offer" do
    get :show, :id => @offer.to_param
    assert_response :success
  end

  test "shouldn't get edit as anonymous" do
    get :edit, :id => @offer.to_param
    assert_response :redirect
  end

  test "shouldn't update offer as anonymous" do
    put :update, :id => @offer.to_param, :offer => @offer.attributes
    assert_response :redirect
  end

  test "shouldn't destroy offer as anonymous" do
    delete :destroy, :id => @offer.to_param
    assert_response :redirect
  end

  # logged in user

  test "should get new as user" do
    sign_in @user
    get :new
    assert_response :success
  end

  test "should create offer as user" do
    sign_in @user
    assert_difference('Offer.count') do
      post :create, :offer => Offer.new({:title => "blabla", :link => "http://google.es"})
    end
    print Offer.last
    assert_redirected_to offer_path(assigns(:offer))
  end

  test "should create infojobs offer as user" do
    sign_in @user
    link = 'https://www.infojobs.net/madrid/informacion-dirigida-comerciales-editorial/of-i3cf262b387430e9907bbdc07d6ad1a'
    assert_difference('Offer.count') do
      post :create, :offer => Offer.new({:title => "Preca", :link => link})
    end
    offer = Offer.last
    assert (offer.studies == 'Sin estudios')
  end

  test "should get edit" do
    sign_in @user
    get :edit, :id => @offer.to_param
    assert_response :success
   end
 
  test "should update offer as user" do
    sign_in @user 
    put :update, :id => @offer.to_param, :offer => @offer.attributes
    assert_redirected_to offer_path(assigns(:offer))
    #assert_response :success
   end

end
