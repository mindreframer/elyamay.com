module BasicHelpers
  def active_if(regex)
    request.path =~ regex ? "active" : ''
  end
end
