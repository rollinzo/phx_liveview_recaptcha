defmodule Demo.GoogleRecaptcha do
  #use Tesla


  def verify(form_resp) do
    #request_body = %{secret: get_secret(), response: resp}
    #request_body = URI.encode_query(%{secret: get_secret(), response: form_resp}) |> Jason.encode_to_iodata!()
    request_body = URI.encode_query(%{secret: get_secret(), response: form_resp})
    {:ok, resp} = Finch.build(
      :post,
      "https://www.google.com/recaptcha/api/siteverify",
      [{"Content-Type", "application/x-www-form-urlencoded"}],
      request_body
    ) |> Finch.request(MyFinch)

    {:ok, %{"success" => success}} = resp.body |> Jason.decode()
    success
  end



  # Take a note of this function
  defp get_secret() do
    config = Application.get_env(:demo, :google_recaptcha)
    config[:secret]
  end

  def get_public_key() do
    config = Application.get_env(:demo, :google_recaptcha)
    config[:public_key]
  end
end
