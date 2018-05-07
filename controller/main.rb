class MainController < Controller
  def index
    @title = 'Welcome!'
  end

  def login
    @title = 'Login'
  end

  def handle_login
    if user_login.nil?
      u = User[login: request.params['login']]
      u.add_login(success: false) unless u.nil?
      flash[:alert] = 'Invalid credentials.'
      redirect(route(:login))
    else
      user.add_login(success: true)
      flash[:notice] = 'Logged in sucessfully.'
      redirect(AdvisorController.route(:/))
    end
  end

  def register
    @title = 'Register'
  end

  def handle_registration
    if request.params['password'].size < 8
      flash[:alert] = 'Password has to be at least 8 characters long.'
      redirect(route(:register))
    end
    begin
    user = User.create(login: request.params['login'],
                       password: Digest::SHA256.digest(request.params['password']),
                       theme: request.params['theme'])
    if user.nil?
      respond('Failed to register', 500)
    else
      user_login
      redirect(AdvisorController.route(:/))
    end
    rescue Sequel::UniqueConstraintViolation
      flash[:alert] = 'That username is taken.'
      redirect(route(:register))
    end
  end

  def logout
    user_logout
    flash[:notice] = 'Logged out successfully.'
    redirect(route(:index))
  end

  def show_logins
    if logged_in?
      @title = 'Your logins'
      @logins = user.logins
    else
      flash[:alert] = 'You have to login first'
      redirect(route(:login))
    end
  end

  def clear_logins
    if logged_in?
      user.logins_dataset.delete
      flash[:notice] = 'Successfully cleared all your login data'
      redirect(route(:show_logins))
    else
      flash[:alert] = 'You have to login first'
      redirect(route(:login))
    end
  end

  def pdf_report
    @logins = user.logins
    PDFKit.configure do |config|
      config.wkhtmltopdf = '/usr/local/bin/wkhtmltopdf'
    end
    kit = PDFKit.new(render_partial(:report))
    kit.stylesheets << 'public/css/bootstrap.min.css'
    kit.stylesheets << 'public/css/reset.css'
    kit.stylesheets << 'public/css/grid.css'
    kit.stylesheets << 'public/css/layout.css'
    kit.stylesheets << 'public/css/text.css'
    respond(kit.to_pdf, 200, {'Content-Type' => 'application/pdf'})
  end
end
