require 'sinatra'
require 'haml'
require 'coffee-script'

require "./model"

set :public_folder, 'assets'
# set :coffee, 'assets/coffee'
enable :sessions

module ModelHelpers
  def register 
    params.delete('password_check')
    data = {
    	:username => params[:username],
    	:email => params[:email],
    	:password => params[:password],
    	:created_on => Time.now,
    	:active => false,
    	:status => "Registered",
    	:is_mod => false,
    	:total_score => 0,
    	:played_sessions => 0,
    	:sessions_won => 0,
    	:confirmed_hits => 0,
    	:score => 0,
    	:sessions_won => 0	
    }
    if @spooner = Spooner.create(data)
    	set_user_data
    	return session[:user_valid] = true
    else
    	return session[:user_valid] = false
    end
  end

  def valid_email?
    Spooner.first(:email => params[:email])
  end

  def valid_username?
    Spooner.first(:username => params[:username])
  end

  def login?
  	if @spooner = Spooner.first(:email => params[:email])
	  	if @spooner.password == params[:password]
	  		set_user_data
		  	return session[:user_valid] = true
		  else
		  	return session[:user_valid] = false
		  end
		else
			return false
		end
  end

  def set_user_data
  	session[:user_data] = {
  		"id" 			  => @spooner.id,
  		"username"  => @spooner.username,
  		"email" 	  => @spooner.email,
  		"moderator" => @spooner.is_mod,
  	}
  end

  def logout?
  	session[:user_data] = nil
  	session[:user_valid] = false	
  	return true
  end

  def validate_page
  	redirect '/' unless session[:user_valid]
  end

  def find_spooner
  	id = session[:user_data]["id"]
  	@spooner = Spooner.get(id)
  	@role = (@spooner.is_mod ? "Moderator" : "Spooner")
  	if @spooner.active == true and @spooner.is_mod == true
  		@game_session = @spooner.sessions.first(:active)
  	elsif @spooner.active
  		@target = Spooner.get(@spooner.current_target)
      @game_session = Sessions.get(@spooner.active_session)
  	end
  end
  
  def create_session?
  	find_spooner
  	@spooner.active = true
  	@spooner.is_mod = true
  	@spooner.status = "Playing" 
  	@spooner.save
  	
  	case 
  		when !session[:user_valid]
  			valid_session = false
  			@msg = "Please register or login, before creating new Spooner session."
  		when @spooner.sessions.all(:active => true).count != 0
  			valid_session = false
  			@msg = "You all ready have an active session."
  		else
  			valid_session = true
  	end
  	data = {
  		:name => params[:name],
  		:created_on => Time.now,
  		:active => true,
  		:status => "Session created",
  	}
	  if valid_session
	  	@spooner.sessions.create(data)
  	else
  		return false
  	end
  end

  def save_image

  end

  def spooners_in_session
  	Spooner.all(:active_session => @game_session.id, :is_mod => false).count
  end

  def eliminated_spooners
  	Spooner.all(:active_session => @game_session.id, :active => false).count
  end

  def best_spooner
  	Spooner.max()
  end

  def active_spooners_in_session
  	Spooner.all(:active_session => @game_session.id, :is_mod => false, :active => true).count
  end

  def get_spooners_in_session
  	@active_spooners = Spooner.all(:active_session => @game_session.id, :is_mod => false)
  end
end


helpers ModelHelpers

helpers do
	def css(*stylesheets)
		stylesheets.map do |stylesheet|
		 	"<link href=\"/css/#{stylesheet}.css\" media=\"screen, projection\" type=\"text/css\" rel=\"stylesheet\" />"
	 	end.join
	end

	def js(*scripts)
		scripts.map do |script|
		 	"<script  src=\"/js/#{script}.js\" type=\"text/javascript\"></script>"
	 	end.join
	end

	def current?(path='/')
		(request.path == path ||request.path == path + '/') ? 'current' : nil
	end
end

get ('/js/script.js') {coffee :script}

get ('/uploads/:file') { send_file('uploads/'+params[:file], :disposition => 'inline')}

get '/' do 
	haml :home
end

get '/sessions' do
	haml :sessions
end

get '/profile' do
	validate_page
	find_spooner
	haml :profile
end

get '/active_session' do
	validate_page
	find_spooner
	get_spooners_in_session
	haml :active_session
end

get '/spooners' do
  @all_spooners = Spooner.all()
  haml :spooners
end


post '/register' do
	content_type 'application/json'
	case 
		when params[:password] != params[:password_check]
			valid_user = false
			msg = "Passwords do not match"
		when valid_username?
			msg = "Username is not available!"
			valid_user = false
		when valid_email?
			msg = "Email is not available!"
			valid_user = false
		else 
			msg = "Sucessfully registered!"
			valid_user = true
	end

	if valid_user
		if register
			response = {"success" => 1, "message" => msg}		
		else
			response = {"success" => 0, "message" => "There was a problem in the db!"}		
		end
	else
		response = {"success" => 0, "message" => msg}
	end
	response.to_json
end

post '/login' do
	content_type 'application/json'
	if login?
		response = {"success" => 1, "message" => "Successful login!", "spooner" => session[:user_data]}
	else
		response = {"success" => 0, "message" => "Ooops there was a problem with your login!"}
	end
	response.to_json
end

post '/logout' do
	content_type 'application/json'
	if logout?
		response = {"success" => 1}
	else
		response = {"success" => 0}		
	end
	response.to_json
end

post '/create_session' do
	content_type 'application/json'
	if create_session?
		response = {"success" => 1, "message" => "New session created!"}
	else
		response = {"success" => 0, "message" => @msg}		
	end
	response.to_json
end

post '/upload-img' do
  content_type 'application/json'
  File.open('uploads/' + params['profile-img'][:filename], "w") do |f|
    f.write(params['profile-img'][:tempfile].read)
  end
  @spooner = Spooner.get(session[:user_data]["id"])
  @spooner.profile_img = params['profile-img'][:filename]
  if @spooner.save
    response = {"success" => 1, "message" => "Profile image uploaded!", "filename" => params['profile-img'][:filename]}
  else 
    response = {"success" => 0, "message" => "There was a problem while uploading"}    
  end
#  response = {"success" => 1, "message" => "Profile image uploaded!", "filename" => params['profile-img'][:filename]}
  response.to_json
end

post '/invite_spooner' do
  #poslat email spooneru
  #postavit mu status invited i active
  #dodat ga u session i na session listu od moda koji ga je pozvao
  #na profile dodati invited to session!
end














