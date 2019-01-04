defmodule Home.Notification do
  alias HTTPoison.Response

  def send_to_all_subscribed(title, msg) do
    Task.Supervisor.start_child(__MODULE__, fn ->
      app_id = Application.get_env(:home, :one_signal_app_id)
      api_key = Application.get_env(:home, :one_signal_api_key)
      body = Jason.encode!(%{
        "app_id" => app_id,
        "contents" => %{ "en" => msg },
        "headings" => %{ "en" => title },
        "included_segments" => ["Subscribed Users"]
      })
      {:ok, %Response{status_code: 200}=_response} = HTTPoison.post(
        "https://onesignal.com/api/v1/notifications",
        body,
        [
          {"Content-Type", "application/json; charset=utf-8"},
          {"Authorization", "Basic #{api_key}"}
        ]
      )
    end)
  end
end
