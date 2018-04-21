class MainController < Controller
  def index
    @title = 'Welcome!'
  end

  def login
    @title = 'Login'
  end

  def handle_login
    if user_login.nil?
      flash[:alert] = 'Invalid credentials.'
      redirect(route('login'))
    else
      flash[:notice] = 'Logged in sucessfully.'
      redirect(route('advisor'))
    end
  end

  def register
    @title = 'Register'
  end

  def handle_registration
    user = User.create(login: request.params['login'],
                       password: Digest::SHA256.digest(request.params['password']),
                       theme: request.params['theme'])
    if user.nil?
      respond('Failed to register', 500)
    else
      user_login
      redirect(route('advisor'))
    end
  end

  def logout
    user_logout
    flash[:notice] = 'Logged out successfully.'
    redirect(route('index'))
  end
end
