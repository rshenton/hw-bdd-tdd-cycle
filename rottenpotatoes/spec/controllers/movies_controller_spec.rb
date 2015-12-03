require 'rails_helper'

describe MoviesController do
  describe '#find_same_director' do
    before(:each) do
      @movie_A = Movie.create :director => "Me"
      @movie_B = Movie.create :director => "Me"
      @movie_D = Movie.create
    end
    context 'when the specified movie has a director' do
      before(:each) do
        get :find_same_director, :id => @movie_A
      end
      it 'should find director\'s other movies' do
        assigns(:movies).should include @movie_A
        assigns(:movies).should include @movie_B
      end
      it 'should render find_same_director' do
        expect(response).to render_template 'find_same_director'
      end
    end
    
    context 'when the specified movie has no director' do
      before(:each) do
        get :find_same_director, :id => @movie_D
      end
      it 'should redirect to home' do
        expect(response).to redirect_to movies_path 
      end
      it 'should display error message' do
        expect(flash[:notice]).to match /has no director info./
      end
    end
  end
  
  describe '#create' do
    #it 'should add to DB' do
    #  expect{ post :create, :movie => {:title => 'A Title'} }.to change(Movie, :count).by 1
    #end
    context 'post DB add' do
      before(:each) do
        post :create, :movie => {:title => 'A Title' }
      end
      it 'should display feedback' do
        expect(flash[:notice]).to match /was successfully created./
      end
      it 'should redirect to home' do
        expect(response).to redirect_to movies_path 
      end
    end
  end
  
  describe '#destroy' do
    before(:each) do
      @movie_D = Movie.create
    end
    #it 'should remove from DB' do
    #  expect{ post :destroy, :id => @movie_D.id }.to change(Movie, :count).by -1
    #end
    context 'post DB removal' do
      before(:each) do
        post :destroy, :id => @movie_D.id
      end
      it 'should display feedback' do
        expect(flash[:notice]).to match /^Movie (.*) deleted.$/
      end
      it 'should redirect to home' do
        expect(response).to redirect_to movies_path 
      end
    end
  end
end