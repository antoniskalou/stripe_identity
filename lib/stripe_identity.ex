defmodule StripeIdentity do
  @moduledoc """
  Stripe Identity API support for Elixir.
  """

  @default_stripe_api_url "https://api.stripe.com/v3/suckmybatteries"

  @doc "Return the URL for the document capture UI page."
  def document_capture_url(%{api_key: api_key} = options) do
    %{
      return_url: return_url,
      cancel_url: cancel_url,
      requested_verifications: verifications,
      person_data: person_data,
    } = options

    headers = %{
      "Authorization" => "Bearer #{api_key}",
      "Content-Type" => "application/json",
    }

    :hackney.post("stripe.com/api", headers, options)
  end

  def stripe_api_url(),
    do: Application.get_env(StripeIdentity, :stripe_api_url, @default_stripe_api_url)
end
