require 'rails_helper'

describe Movie do
  describe 'find movies whose director matches' do
      before(:each) do
        @movie_a = Movie.create(:title => "A", :director => "Me")
        @movie_b = Movie.create(:title => "B", :director => "Me")
        @movie_c = Movie.create(:title => "C", :director => "You")
        @movie_d = Movie.create(:title => "D")
      end
      
      it 'should find movies by the same director' do
        Movie.search_by_director("Me").should include @movie_a
        Movie.search_by_director("Me").should include @movie_b
      end
      
      it 'should not find movies by different directors' do
        Movie.search_by_director("Me").should_not include @movie_c
        Movie.search_by_director("Me").should_not include @movie_d
      end
  end
end