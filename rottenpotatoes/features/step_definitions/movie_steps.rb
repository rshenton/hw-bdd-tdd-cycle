Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create movie
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  
  expect(page.body).to have_content /#{e1}.*#{e2}/m
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  
  rating_list.split(', ').each { |rating| step %Q{I #{uncheck}check "ratings_#{rating}"} }
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  
  page.all('table#movies tbody tr').count.should == Movie.count.should
end

Then /the director of "(.*)" should be "(.*)"/ do |movie, director|
  expect(Movie.find_by_title(movie).director).to eq director
end