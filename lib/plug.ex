defmodule StripeIdentity.Plug do
  import Plug.Conn

  def init(options) do
    # TODO: fail if not found
    Keyword.take(options, [:api_key, :path, :on_verify])
  end

  def call(%{request_path: path, method: "POST"} = conn, options) do
    hook_path = Keyword.get(options, :path)
    on_verify_fn = Keyword.get(options, :on_verify)

    if same_path?(path, hook_path) do
      verification = parse_verification_results(conn)

      # TODO: check if callbacks like this are a good idea in a plug
      on_verify_fn.(verification)

      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, Jason.encode!(%{"test" => true}))
    else
      not_found(conn)
    end
  end

  def call(conn, _opts), do: not_found(conn)

  defp parse_verification_results(conn) do
    # TODO
    parse_body(conn)
  end

  defp parse_body(conn) do
    {:ok, body, _} = read_body(conn, length: 1_000_000)
    Jason.decode!(body)
  end

  defp not_found(conn) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(404, Jason.encode!(%{"error" => "unknown path"}))
  end

  defp same_path?(a, b), do: URI.parse(a).path == URI.parse(b).path
end
