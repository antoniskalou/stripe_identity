defmodule StripeIdentity do
  @moduledoc """
  Stripe Identity API support for Elixir.
  """

  @default_stripe_files_url "https://files.stripe.com/v1/files"

  @doc "Submit a document to the document capture API."
  def submit_document_verification(owned_by, file) do
    data = %{
      file: file,
      purpose: "identity_document_downloadable",
      owned_by: owned_by,
    }

    headers = %{
      "Authorization" => "Bearer #{api_key}",
      "Content-Type" => "multipart/form-data",
    }

    :hackney.post(stripe_files_url(), headers, data)
  end

  def stripe_files_url(),
    do: Application.get_env(StripeIdentity, :stripe_files_url, @default_stripe_files_url)
end
