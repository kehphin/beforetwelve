module Response
  def json_response(object, opts = {})
    opts[:status] ||= :ok
    render opts.merge(json: object)
  end
end
