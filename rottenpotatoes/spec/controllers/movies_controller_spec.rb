require 'rails_helper'

describe MoviesController do
  describe 'search by movie\'s director' do
    before(:each) do
      @movie_A = Movie.create(:director => "Me")
      @movie_B = Movie.create(:director => "Me")
      @movie_D = Movie.create()
    end
    context 'when the specified movie has a director' do 
      it 'should find director\'s other movies' do
        get 'find_same_director', :id => @movie_A.id
        assigns(:movies).should include(@movie_A)
        assigns(:movies).should include(@movie_B)
      end
      it 'should render find_same_director' do
        get 'find_same_director', :id => @movie_A.id
        response.should render_template 'find_same_director'
      end
    end
    
    context 'when the specified movie has no director' do
      it 'should redirect to home' do
        get 'find_same_director', :id => @movie_D.id
        response.should redirect_to movies_path 
      end
      #it 'should display error message'
    end
  end
end