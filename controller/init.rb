# Define a subclass of Ramaze::Controller holding your defaults for all controllers. Note 
# that these changes can be overwritten in sub controllers by simply calling the method 
# but with a different value.
module CustomHelpers
  def theme
    logged_in?? user.theme : '#e33f1e'
  end

  def darker_theme
    theme.gsub(/[1-9a-f]/) {|char| (char.to_i(16) - 1).to_s(16) }
  end
end

class Controller < Ramaze::Controller
  layout :default
  helper :xhtml, :user
  engine :haml
  include CustomHelpers
end

# Here you can require all your other controllers. Note that if you have multiple
# controllers you might want to do something like the following:
#
#  Dir.glob('controller/*.rb').each do |controller|
#    require(controller)
#  end
#
require __DIR__('main')
require __DIR__('advisor')
