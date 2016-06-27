class PagesController < PaitinHana::BaseController
  def about
    render :about, {name: "Tutplus", lastname: "MVC frameworks"}
  end

  def tell_me
    # render :tell_me, { name: params["name"] }
    @name = "Eyio of the Ruby Tabernacle"
  end
end
