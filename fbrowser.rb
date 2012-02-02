require 'sinatra'
require 'haml'
require 'sass'
require 'yaml'

configure do
  set YAML.load_file('config.yml');
  set :path, ''
  set :environment, :development
  set :haml, { :format => :html5 }
end

get '/' do
  redirect to('/browse')
end

get '/browse' do
  @content = Dir.entries("#{settings.default_dir}").sort.delete_if {|e| e == "." || e == ".." }
  @path = "/"
  haml :index
end

get '/browse/*' do
  #puts "Edit #{params[:splat][-1]}"
  @content = Dir.entries("#{settings.default_dir}/#{params[:splat].join("/")}").sort.delete_if {|e| e == "." || e == ".." }
  @path = "/" + params[:splat].join("/")
  haml :_panel, :layout => false
end

get '/screen.css' do
  puts 'SCSS rendered!'
  content_type 'text/css', :charset => 'utf-8'
  render :scss, :screen, :layout => false, :views => './public/stylesheets'
end
