require 'rails_helper'

RSpec.describe TwitterUsersController, type: :controller do
  before :each do
    @user = create(:user)
    sign_in @user
    @twitter_user = create(:twitter_user, user: @user)
  end

  describe 'action #index' do
    it 'contains twitter user' do
      get :index
      expect(assigns(:twitter_users)).to contain_exactly(@twitter_user)
    end
    it 'renders the :index view' do
      get :index
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end
  describe 'action #new' do
    it 'initiates empty twitter user' do
      get :new
      expect(assigns(:twitter_user)).to be_a_new(TwitterUser)
    end
    it 'renders the :new view' do
      get :new
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
    end
  end
  describe 'action #show' do
    it 'assigns the requested twitter user to @twitter user' do
      get :show, params: { id: @twitter_user.id }
      expect(assigns(:twitter_user)).to eq(@twitter_user)
    end
    it 'renders the :show view' do
      get :show, params: { id: @twitter_user.id }
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
    end
  end
  describe 'action #create' do
    context 'with valid attributes' do
      let!(:val_twitter_user) { build(:twitter_user) }

      it 'saves a new twitter user' do
        expect do
          post :create, params: { twitter_user: { name: val_twitter_user.name,
                                                  owner: val_twitter_user.owner } }
        end.to change(TwitterUser, :count).by(1)
      end

      it 'redirects to the twitter user' do
        post :create, params: { twitter_user: { name: val_twitter_user.name,
                                                owner: val_twitter_user.owner } }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to TwitterUser.last
        expect(controller).to set_flash[:success]
      end
    end
  end
  describe 'action #update' do
    context 'valid attributes' do
      it 'locates the requested twitter user' do
        put :update, params: { id: @twitter_user.id,
                               twitter_user: { name: @twitter_user.name,
                                               owner: @twitter_user.owner } }
        expect(assigns(:twitter_user)).to eq(@twitter_user)
      end
      it "changes twitter user's attributes" do
        put :update, params: { id: @twitter_user.id,
                               twitter_user: { name: 'misha',
                                               owner: 'mishatwitter'} }
        @twitter_user.reload
        expect(@twitter_user.name).to eq('Misha')
        expect(@twitter_user.owner).to eq('mishatwitter')
      end
      it 'redirects to the twitter users table' do
        put :update, params: { id: @twitter_user.id,
                               twitter_user: { name: 'misha',
                                               owner: 'mishatwitter'} }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to @twitter_user
        expect(controller).to set_flash[:success]
      end
    end
    context 'invalid attributes' do
      it "does not change twitter user's attributes" do
        put :update, params: { id: @twitter_user.id,
                               twitter_user: { name: nil,
                                               owner: nil} }
        @twitter_user.reload
        expect(@twitter_user.name).not_to eq(nil)
        expect(@twitter_user.owner).not_to eq(nil)
      end

      it 're-renders the edit method' do
        put :update, params: { id: @twitter_user.id,
                               twitter_user: { name: nil,
                                               owner: nil} }
        expect(response).to have_http_status(200)
        expect(response).to render_template :edit
        expect(controller).to set_flash[:danger]
      end
    end
  end
  describe 'action #edit' do
    it 'gets the twitter user data for editing' do
      get :edit, params: { id: @twitter_user.id }
      expect(response).to have_http_status(200)
      expect(response).to render_template :edit
    end
  end

  describe 'action #destroy' do
    it 'deletes the user' do
      expect do
        delete :destroy, params: { id: @twitter_user.id }
      end.to change(TwitterUser, :count).by(-1)
    end

    it 'redirects to twitter user#index' do
      delete :destroy, params: { id: @twitter_user.id }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to twitter_users_path
      expect(controller).to set_flash[:success]
    end
  end

  describe 'action #export_to_exel' do
    it 'makes the right response' do
      get :export_to_exel, format: :xlsx
      expect(response.content_type.to_s).to eq(Mime::Type.lookup_by_extension(:xlsx).to_s)
    end
  end
end